#' Build symbolic fragment records reachable from named schema types.
#'
#' Each record contains a fragment name, its GraphQL type condition, rendered
#' selection tokens, and symbolic references to other fragments.
#'
#' @param registry A named schema registry.
#' @param roots Named object, union, or interface types to include.
#' @param named_type_fn Function that returns the leaf type name.
#' @param type_string_fn Function that serializes a normalized type.
#' @param selection_policy_fn Function that chooses nested field selection policy.
#' @return A named list of fragment records.
#' @noRd
build_fragment_graph <- function(
  registry,
  roots,
  named_type_fn = get("type_ref_named_type", mode = "function"),
  type_string_fn = get("type_ref_to_string", mode = "function"),
  selection_policy_fn = NULL
) {
  if (!is.list(registry) || is.null(names(registry))) {
    stop("registry must be a named schema registry", call. = FALSE)
  }
  if (length(roots) == 0L) return(list())
  if (is.null(selection_policy_fn)) {
    selection_policy_fn <- if (exists("build_selection_policy", mode = "function")) {
      get("build_selection_policy", mode = "function")
    } else {
      function(parent_type, field_name, referenced_type) {
        list(selection = NULL, reference = referenced_type, source = "recursive")
      }
    }
  }

  graph_state <- new.env(parent = emptyenv())
  graph_state$records <- list()
  collect_fragment <- function(type_name) {
    if (!is.null(graph_state$records[[type_name]])) return(invisible(NULL))
    type_definition <- registry[[type_name]]
    if (is.null(type_definition)) {
      stop("fragment type not found: ", type_name, call. = FALSE)
    }
    if (!type_definition$kind %in% c("OBJECT", "UNION", "INTERFACE")) {
      stop("fragment type is not abstract or object: ", type_name, call. = FALSE)
    }

    if (type_definition$kind %in% c("UNION", "INTERFACE")) {
      references <- unique(type_definition$possible_types)
      selections <- paste0("...", references)
    } else {
      fields <- Filter(function(field) !isTRUE(field$is_deprecated), type_definition$fields)
      field_parts <- lapply(fields, function(field) {
        named_type <- named_type_fn(field$type)
        named_definition <- registry[[named_type]]
        if (!is.null(named_definition) && named_definition$kind %in% c("OBJECT", "UNION", "INTERFACE")) {
          policy <- selection_policy_fn(type_name, field$name, named_type)
          if (!is.null(policy$selection) && is.na(policy$selection)) return(NULL)
          if (!is.null(policy$selection)) {
            return(list(text = paste0(field$name, " ", policy$selection), reference = policy$reference))
          }
          list(
            text = paste0(field$name, " { ...", named_type, " }"),
            reference = named_type
          )
        } else {
          policy <- selection_policy_fn(type_name, field$name, named_type)
          if (!is.null(policy$selection) && is.na(policy$selection)) return(NULL)
          list(text = if (is.null(policy$selection)) field$name else policy$selection, reference = NULL)
        }
      })
      field_parts <- Filter(Negate(is.null), field_parts)
      references <- unique(Filter(Negate(is.null), lapply(field_parts, `[[`, "reference")))
      selections <- vapply(field_parts, `[[`, character(1), "text")
    }

    graph_state$records[[type_name]] <- list(
      name = type_name,
      type_condition = type_name,
      kind = type_definition$kind,
      selections = selections,
      references = references,
      selection_string = paste(selections, collapse = " "),
      type_string = type_string_fn(make_leaf_type(type_name, type_definition$kind))
    )

    for (reference in references) collect_fragment(reference)
    invisible(NULL)
  }

  make_leaf_type <- function(type_name, kind) {
    list(kind = kind, name = type_name)
  }

  for (root in unique(roots)) collect_fragment(root)
  graph_state$records
}

#' Resolve symbolic fragment dependencies in dependency-first order.
#'
#' Cycles are reported rather than silently discarded. The returned order still
#' contains each reachable fragment once, allowing a later policy to decide how
#' to handle cyclic selections.
#'
#' @param graph A named fragment graph from build_fragment_graph().
#' @param roots Fragment names whose dependencies should be resolved.
#' @return A list with `order` and `cycles` components.
#' @noRd
resolve_fragment_dependencies <- function(graph, roots) {
  if (!is.list(graph) || is.null(names(graph))) {
    stop("graph must be a named fragment graph", call. = FALSE)
  }

  state <- new.env(parent = emptyenv())
  state$visited <- character()
  state$order <- character()
  state$cycles <- list()

  visit <- function(name, stack = character()) {
    if (name %in% stack) {
      cycle_start <- match(name, stack)
      state$cycles[[length(state$cycles) + 1L]] <- c(stack[cycle_start:length(stack)], name)
      return(invisible(NULL))
    }
    if (name %in% state$visited) return(invisible(NULL))
    fragment <- graph[[name]]
    if (is.null(fragment)) stop("fragment not found: ", name, call. = FALSE)

    next_stack <- c(stack, name)
    for (reference in fragment$references) visit(reference, next_stack)
    state$visited <- c(state$visited, name)
    state$order <- c(state$order, name)
    invisible(NULL)
  }

  for (root in unique(roots)) visit(root)
  list(order = state$order, cycles = state$cycles)
}

#' Remove one spread edge from each detected cycle for GraphQL rendering.
#'
#' @param graph A named fragment graph.
#' @param cycles Cycle paths from resolve_fragment_dependencies().
#' @return A graph with cyclic spread edges removed.
#' @noRd
break_fragment_cycles <- function(graph, cycles) {
  for (cycle in cycles) {
    parent <- cycle[[1]]
    child <- cycle[[2]]
    fragment <- graph[[parent]]
    if (is.null(fragment)) next
    fragment$references <- setdiff(fragment$references, child)
    fragment$selections <- fragment$selections[
      !grepl(paste0("...", child), fragment$selections, fixed = TRUE)
    ]
    fragment$selection_string <- paste(fragment$selections, collapse = " ")
    graph[[parent]] <- fragment
  }
  graph
}
