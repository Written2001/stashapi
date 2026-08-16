#' Test whether an R value represents an omitted GraphQL value.
#'
#' `NULL` and scalar `NA` are treated as omitted. Empty lists are valid GraphQL
#' list values and are therefore not treated as missing.
#'
#' @param value R value.
#' @return A single logical value.
#' @noRd
is_graphql_missing <- function(value) {
  is.null(value) || (length(value) == 1L && is.na(value))
}

#' Validate one R value against a normalized GraphQL type.
#'
#' @param value R value to validate.
#' @param type_ref Normalized GraphQL type AST.
#' @param path Human-readable input path.
#' @param registry Optional schema registry for nested input objects and enums.
#' @param type_string_fn Function that serializes a normalized type.
#' @return Invisibly `TRUE` or an informative error.
#' @noRd
validate_graphql_value <- function(
  value,
  type_ref,
  path = "value",
  registry = NULL,
  type_string_fn = get("type_ref_to_string", mode = "function")
) {
  if (identical(type_ref$kind, "NON_NULL")) {
    if (is_graphql_missing(value)) {
      stop("`", path, "` is required by GraphQL type `", type_string_fn(type_ref), "`.", call. = FALSE)
    }
    return(validate_graphql_value(value, type_ref$of_type, path, registry, type_string_fn))
  }

  if (is_graphql_missing(value)) return(invisible(TRUE))

  if (identical(type_ref$kind, "LIST")) {
    values <- if (is.list(value)) value else as.list(value)
    for (index in seq_along(values)) {
      validate_graphql_value(
        values[[index]], type_ref$of_type, paste0(path, "[[", index, "]]"), registry, type_string_fn
      )
    }
    return(invisible(TRUE))
  }

  if (identical(type_ref$kind, "INPUT_OBJECT")) {
    if (!is.list(value)) {
      stop("`", path, "` must be a named list for GraphQL input object `", type_ref$name, "`.", call. = FALSE)
    }
    if (!is.null(registry)) {
      input_definition <- registry[[type_ref$name]]
      if (is.null(input_definition)) {
        stop("input object type not found: ", type_ref$name, call. = FALSE)
      }
      known_fields <- vapply(input_definition$input_fields, function(field) field$name, character(1))
      unknown_fields <- setdiff(names(value), known_fields)
      if (length(unknown_fields) > 0L) {
        stop("unknown fields for ", type_ref$name, ": ", paste(unknown_fields, collapse = ", "), call. = FALSE)
      }
      for (field in input_definition$input_fields) {
        if (field$name %in% names(value)) {
          validate_graphql_value(
            value[[field$name]], field$type, paste0(path, ".", field$name), registry, type_string_fn
          )
        } else if (
          identical(field$type$kind, "NON_NULL") &&
            (is.null(field$default_value) || is.na(field$default_value))
        ) {
          stop(
            "`", path, ".", field$name, "` is required by GraphQL type `",
            type_string_fn(field$type), "`.", call. = FALSE
          )
        }
      }
    }
    return(invisible(TRUE))
  }

  if (identical(type_ref$kind, "ENUM") && !is.null(registry)) {
    enum_values <- registry[[type_ref$name]]$enum_values
    if (length(enum_values) > 0L && any(!as.character(value) %in% enum_values)) {
      stop("`", path, "` is not a valid ", type_ref$name, " value.", call. = FALSE)
    }
  }

  invisible(TRUE)
}

#' Validate all operation arguments before a GraphQL request is sent.
#'
#' @param operation Operation IR record.
#' @param values Named R argument values keyed by sanitized names.
#' @param registry Optional schema registry for nested input validation.
#' @return Invisibly `TRUE` or an informative error.
#' @noRd
validate_operation_arguments <- function(operation, values, registry = NULL) {
  for (argument in operation$arguments) {
    value <- if (argument$r_name %in% names(values)) values[[argument$r_name]] else NULL
    validate_graphql_value(value, argument$type, argument$r_name, registry)
  }
  invisible(TRUE)
}
