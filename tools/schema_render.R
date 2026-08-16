utils::globalVariables("break_fragment_cycles")

#' Render GraphQL variable definitions from an operation IR record.
#'
#' @param operation One operation record from build_operation_ir().
#' @return A GraphQL variable-definition string, including parentheses when needed.
#' @noRd
#' @keywords internal
render_variable_definitions <- function(operation) {
  if (length(operation$arguments) == 0L) return("")

  definitions <- vapply(
    operation$arguments,
    function(argument) paste0("$", argument$r_name, ": ", argument$type_string),
    character(1)
  )
  paste0("(", paste(definitions, collapse = " "), ")")
}

#' Render GraphQL field arguments from an operation IR record.
#'
#' @param operation One operation record from build_operation_ir().
#' @return A GraphQL argument string, including parentheses when needed.
#' @noRd
render_field_arguments <- function(operation) {
  if (length(operation$arguments) == 0L) return("")

  arguments <- vapply(
    operation$arguments,
    function(argument) paste0(argument$name, ": $", argument$r_name),
    character(1)
  )
  paste0("(", paste(arguments, collapse = " "), ")")
}

#' Render one operation without fragment definitions.
#'
#' The default selection renderer emits a fragment spread for object-like
#' return values and no selection set for scalar or enum return values.
#'
#' @param operation One operation record from build_operation_ir().
#' @param selection_fn Function receiving the operation and returning a selection string.
#' @return One GraphQL operation string.
#' @noRd
render_operation <- function(operation, selection_fn = default_selection) {
  selection <- selection_fn(operation)
  variables <- render_variable_definitions(operation)
  arguments <- render_field_arguments(operation)
  field <- paste0(operation$name, arguments)
  field <- if (nzchar(selection)) paste0(field, " { ", selection, " }") else field

  paste0(operation$operation_kind, " ", operation$name, variables, " { ", field, " }")
}

#' Render the default selection for an operation return type.
#'
#' @param operation One operation record from build_operation_ir().
#' @return A fragment spread for object-like returns, otherwise an empty string.
#' @noRd
default_selection <- function(operation) {
  if (!operation$selection_kind %in% c("OBJECT", "UNION", "INTERFACE")) return("")
  paste0("...", operation$return_named_type)
}

#' Render one symbolic fragment definition.
#'
#' @param fragment A fragment record from build_fragment_graph().
#' @return One GraphQL fragment definition.
#' @noRd
render_fragment_definition <- function(fragment) {
  paste0(
    "fragment ", fragment$name, " on ", fragment$type_condition,
    " { ", fragment$selection_string, " }"
  )
}

#' Render fragment definitions in a supplied dependency order.
#'
#' @param graph A named fragment graph.
#' @param order Fragment names, usually from resolve_fragment_dependencies().
#' @return A character vector of GraphQL fragment definitions.
#' @noRd
render_fragment_definitions <- function(graph, order) {
  vapply(order, function(name) {
    fragment <- graph[[name]]
    if (is.null(fragment)) stop("fragment not found: ", name, call. = FALSE)
    render_fragment_definition(fragment)
  }, character(1))
}

#' Validate symbolic fragment references and dependency cycles.
#'
#' @param graph A named fragment graph.
#' @param roots Fragment names to validate.
#' @param dependency_fn Dependency resolver function.
#' @return Invisibly `TRUE`, or an error describing invalid graph structure.
#' @noRd
validate_fragment_graph <- function(
  graph,
  roots,
  dependency_fn = get("resolve_fragment_dependencies", mode = "function")
) {
  if (!is.list(graph) || is.null(names(graph))) {
    stop("graph must be a named fragment graph", call. = FALSE)
  }

  missing_references <- unique(unlist(lapply(graph, function(fragment) {
    setdiff(fragment$references, names(graph))
  }), use.names = FALSE))
  if (length(missing_references) > 0L) {
    stop("fragment references are undefined: ", paste(missing_references, collapse = ", "), call. = FALSE)
  }

  resolution <- dependency_fn(graph, roots)
  if (length(resolution$cycles) > 0L) {
    cycle <- paste(resolution$cycles[[1]], collapse = " -> ")
    stop("fragment dependency cycle: ", cycle, call. = FALSE)
  }

  invisible(TRUE)
}

#' Render a complete GraphQL document from an operation and fragment graph.
#'
#' @param operation One operation record from build_operation_ir().
#' @param graph A named fragment graph.
#' @param allow_cycles Whether to render despite reported fragment cycles.
#' @param dependency_fn Function that resolves symbolic fragment dependencies.
#' @param cycle_break_fn Function that removes cyclic spread edges.
#' @return One GraphQL operation followed by its fragment definitions.
#' @noRd
render_graphql_document <- function(
  operation,
  graph,
  allow_cycles = FALSE,
  dependency_fn = get("resolve_fragment_dependencies", mode = "function"),
  cycle_break_fn = get("break_fragment_cycles", mode = "function")
) {
  resolution <- dependency_fn(graph, operation$return_named_type)
  if (!allow_cycles) validate_fragment_graph(graph, operation$return_named_type)
  if (allow_cycles && length(resolution$cycles) > 0L) {
    graph <- cycle_break_fn(graph, resolution$cycles)
  }

  operation_text <- render_operation(operation)
  fragments <- render_fragment_definitions(graph, resolution$order)
  if (length(fragments) == 0L) return(operation_text)
  paste(c(operation_text, fragments), collapse = "\n")
}
