#' Build an intermediate representation for Query and Mutation fields.
#'
#' The operation IR is deliberately independent of GraphQL text generation. It
#' retains the schema facts needed by both the GraphQL and R renderers.
#'
#' @param registry A named registry returned by normalize_schema_registry().
#' @param root_types Root object names whose fields should become operations.
#' @param named_type_fn Function that returns the leaf type name.
#' @param type_string_fn Function that serializes a normalized type.
#' @param response_policy_fn Function that creates the response policy record.
#' @return A named list of operation records.
#' @noRd
build_operation_ir <- function(
  registry,
  root_types = c("Query", "Mutation"),
  named_type_fn = get("type_ref_named_type", mode = "function"),
  type_string_fn = get("type_ref_to_string", mode = "function"),
  response_policy_fn = NULL
) {
  if (!is.list(registry) || is.null(names(registry))) {
    stop("registry must be a named schema registry", call. = FALSE)
  }

  missing_roots <- setdiff(root_types, names(registry))
  if (length(missing_roots) > 0L) {
    stop("schema registry is missing root type: ", paste(missing_roots, collapse = ", "), call. = FALSE)
  }
  if (is.null(response_policy_fn)) {
    response_policy_fn <- if (exists("build_response_policy", mode = "function")) {
      get("build_response_policy", mode = "function")
    } else {
      function(operation_name, return_named_type, registry) {
        list(default_field = NA_character_, source = "none")
      }
    }
  }

  operations <- unlist(lapply(root_types, function(root_type) {
    root <- registry[[root_type]]
    if (!identical(root$kind, "OBJECT")) {
      stop("operation root is not an object: ", root_type, call. = FALSE)
    }

    fields <- Filter(function(field) !isTRUE(field$is_deprecated), root$fields)
    lapply(fields, function(field) {
      return_type <- field$type
      named_type <- named_type_fn(return_type)
      return_definition <- registry[[named_type]]
      selection_kind <- if (is.null(return_definition)) {
        "UNKNOWN"
      } else {
        return_definition$kind
      }

      arguments <- lapply(field$arguments, function(argument) {
        list(
          name = argument$name,
          r_name = gsub("_", "", argument$name),
          type = argument$type,
          type_string = type_string_fn(argument$type),
          required = identical(argument$type$kind, "NON_NULL"),
          default_value = argument$default_value,
          description = argument$description
        )
      })

      list(
        name = field$name,
        operation_kind = tolower(root_type),
        root_type = root_type,
        description = field$description,
        arguments = arguments,
        return_type = return_type,
        return_type_string = type_string_fn(return_type),
        return_named_type = named_type,
        selection_kind = selection_kind,
        response_policy = response_policy_fn(field$name, named_type, registry)
      )
    })
  }), recursive = FALSE)

  operation_names <- vapply(operations, function(operation) operation$name, character(1))
  if (anyDuplicated(operation_names)) {
    stop("schema contains duplicate operation names", call. = FALSE)
  }

  names(operations) <- operation_names
  operations
}

#' Find one operation in an operation IR by its GraphQL name.
#'
#' @param operations A named operation IR.
#' @param operation_name GraphQL field name.
#' @return One operation record.
#' @noRd
get_operation <- function(operations, operation_name) {
  if (!is.list(operations) || is.null(operations[[operation_name]])) {
    stop("operation not found: ", operation_name, call. = FALSE)
  }

  operations[[operation_name]]
}
