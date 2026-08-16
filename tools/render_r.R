#' Render R function formals from an operation IR record.
#'
#' Requiredness is retained in the operation record; this first compatible
#' renderer keeps every generated argument callable with the existing API.
#'
#' @param operation One operation record from build_operation_ir().
#' @param contains_type_fn Function that checks nested type wrappers.
#' @return A function-formal string ending with `...`.
#' @noRd
render_r_formals <- function(
  operation,
  contains_type_fn = get("type_ref_contains", mode = "function")
) {
  arguments <- vapply(operation$arguments, function(argument) {
    default <- if (
      contains_type_fn(argument$type, "SCALAR") &&
        contains_type_fn(argument$type, "NON_NULL")
    ) {
      "list()"
    } else {
      "NA"
    }
    paste0(argument$r_name, " = ", default)
  }, character(1))
  paste(c(arguments, "..."), collapse = ", ")
}

#' Render variable serialization code for an operation.
#'
#' @param operation One operation record from build_operation_ir().
#' @return R source assigning function arguments to a GraphQL variables list.
#' @noRd
render_r_variables <- function(operation) {
  lines <- vapply(operation$arguments, function(argument) {
    paste0("variables[['", argument$r_name, "']] <- ", argument$r_name)
  }, character(1))
  paste(c("variables <- list()", lines), collapse = "\n  ")
}

#' Render local checks for operation-level required arguments.
#'
#' @param operation One operation record from build_operation_ir().
#' @return R source that rejects missing required GraphQL arguments.
#' @noRd
render_r_validation <- function(operation) {
  required_arguments <- Filter(function(argument) isTRUE(argument$required), operation$arguments)
  if (length(required_arguments) == 0L) return("")

  checks <- vapply(required_arguments, function(argument) {
    paste0(
      "if (is.null(", argument$r_name, ") || (length(", argument$r_name,
      ") == 1L && is.atomic(", argument$r_name, ") && is.na(", argument$r_name, "))",
      if (argument$type$of_type$kind == "SCALAR") {
        paste0(" || (is.list(", argument$r_name, ") && length(", argument$r_name, ") == 0L)")
      } else {
        ""
      }, ") {\n",
      "  stop(\"`", argument$r_name, "` is required by GraphQL type `",
      argument$type_string, "`.\", call. = FALSE)\n",
      "}"
    )
  }, character(1))
  paste(checks, collapse = "\n  ")
}

#' Render a backwards-compatible R wrapper.
#'
#' @param operation One operation record from build_operation_ir().
#' @param document GraphQL document for the operation.
#' @return R source for one exported operation wrapper.
#' @noRd
render_r_wrapper <- function(operation, document) {
  formals <- render_r_formals(operation)
  variables <- render_r_variables(operation)
  validation <- render_r_validation(operation)
  query_name <- operation$name

  paste0(
    operation$name, " <- function(", formals, ") {\n\n",
    "  query <- ghql::Query$new()\n",
    "  query$query('", query_name, "', '\n",
    "  ", document, "\n",
    "  ')\n\n",
    "  ", variables, "\n\n",
    if (nzchar(validation)) paste0("  ", validation, "\n\n") else "",
    "  return_default <- ",
    if (is.na(operation$response_policy$default_field)) {
      "NA_character_"
    } else {
      paste0("\"", operation$response_policy$default_field, "\"")
    }, "\n",
    "  dotargs <- list(...)\n",
    "  if (!\".field\" %in% names(dotargs)) {\n",
    "    dotargs$.field <- return_default\n",
    "  }\n",
    "  res <- executeQuery(\n",
    "    query = query$queries$", query_name, ",\n",
    "    variables = variables,\n",
    "    connection = the$connection,\n",
    "    return_default = return_default,\n",
    "    field = dotargs$.field\n",
    "  )\n\n",
    "  return(res)\n",
    "}\n"
  )
}
