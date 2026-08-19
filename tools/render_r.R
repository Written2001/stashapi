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

render_roxygen_text <- function(value, fallback) {
  value <- if (length(value) == 0L || is.na(value[[1]])) "" else as.character(value[[1]])
  value <- trimws(value)
  if (!nzchar(value)) value <- fallback
  gsub("\\r?\\n", "\n#' ", value)
}

render_r_documentation <- function(operation) {
  title <- paste0("Call GraphQL operation: ", operation$name)
  description <- render_roxygen_text(
    operation$description,
    paste0("Executes the GraphQL operation `", operation$name, "`.")
  )
  arguments <- vapply(operation$arguments, function(argument) {
    description <- render_roxygen_text(
      argument$description,
      "See the Stash Playground for details."
    )
    paste0("#' @param ", argument$r_name, " ", description)
  }, character(1))

  lines <- c(
    paste0("#' ", title),
    "#'",
    paste0("#' @description ", description),
    arguments,
    "#' @param ... Additional options such as `.field`, `.response`, and `.progress_bar`.",
    "#' @return The processed API response.",
    "#' @export"
  )
  paste(lines, collapse = "\n")
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
    render_r_documentation(operation), "\n",
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
    "  options <- prepare_stash_query_options(list(...), return_default)\n",
    "  field <- options$field\n",
    "  response <- options$response\n",
    "  progress_bar <- options$progress_bar\n",
    "  res <- execute_query(\n",
    "    query = query$queries$", query_name, ",\n",
    "    variables = variables,\n",
    "    connection = get_stash_connection(),\n",
    "    return_default = return_default,\n",
    "    field = field,\n",
    "    response = response,\n",
    "    progress_bar = progress_bar\n",
    "  )\n\n",
    "  return(res)\n",
    "}\n"
  )
}
