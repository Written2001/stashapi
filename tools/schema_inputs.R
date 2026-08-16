#' Convert a GraphQL type name to a readable R builder name.
#'
#' @param type_name GraphQL input-object name.
#' @return A snake_case R name.
#' @noRd
input_builder_name <- function(type_name) {
  base_name <- sub("Type$", "", type_name)
  snake_name <- gsub("([a-z0-9])([A-Z])", "\\1_\\2", base_name)
  tolower(snake_name)
}

#' Build metadata for schema-aware input constructors.
#'
#' @param registry A named schema registry.
#' @return A named list of input-builder records.
#' @noRd
build_input_builder_ir <- function(registry) {
  input_types <- Filter(function(type) identical(type$kind, "INPUT_OBJECT"), registry)
  builders <- lapply(input_types, function(type) {
    fields <- type$input_fields
    list(
      type_name = type$name,
      function_name = input_builder_name(type$name),
      fields = fields,
      field_names = vapply(fields, function(field) field$name, character(1)),
      required_fields = vapply(
        Filter(function(field) identical(field$type$kind, "NON_NULL"), fields),
        function(field) field$name,
        character(1)
      )
    )
  })
  names(builders) <- vapply(builders, function(builder) builder$type_name, character(1))
  builders
}

#' Validate and return GraphQL input fields as an ordinary R list.
#'
#' @param values Named input values.
#' @param allowed_fields GraphQL field names accepted by the input type.
#' @param type_name Input type name used in error messages.
#' @param strict Whether unknown fields should cause an error.
#' @return A named list.
#' @noRd
gql_input_fields <- function(values, allowed_fields, type_name, strict = TRUE) {
  unknown_fields <- setdiff(names(values), allowed_fields)
  if (isTRUE(strict) && length(unknown_fields) > 0L) {
    stop("unknown fields for ", type_name, ": ", paste(unknown_fields, collapse = ", "), call. = FALSE)
  }

  values
}

#' Construct a schema-aware GraphQL input object as an ordinary R list.
#'
#' @param type_name GraphQL INPUT_OBJECT type name.
#' @param ... Input fields using GraphQL field names.
#' @param registry A named schema registry.
#' @param strict Whether unknown fields should cause an error.
#' @return A named list suitable for an existing generated wrapper.
#' @noRd
gql_input <- function(type_name, ..., .registry, .strict = TRUE) {
  type_definition <- .registry[[type_name]]
  if (is.null(type_definition) || !identical(type_definition$kind, "INPUT_OBJECT")) {
    stop("input object type not found: ", type_name, call. = FALSE)
  }

  values <- list(...)
  known_fields <- vapply(type_definition$input_fields, function(field) field$name, character(1))
  gql_input_fields(values, known_fields, type_name, strict = .strict)
}

#' Build a criterion input value.
#'
#' @param value Criterion value.
#' @param modifier GraphQL criterion modifier.
#' @return A named criterion list.
#' @noRd
gql_criterion <- function(value = NULL, modifier, value2 = NULL, depth = NULL, excludes = NULL) {
  result <- list()
  if (!is.null(value)) result$value <- value
  if (!is.null(value2)) result$value2 <- value2
  result$modifier <- modifier
  if (!is.null(depth)) result$depth <- depth
  if (!is.null(excludes)) result$excludes <- excludes
  result
}

#' Build an EQUALS criterion.
#'
#' @param value Criterion value.
#' @return A named criterion list.
#' @noRd
equals <- function(value) gql_criterion(value, "EQUALS")

#' Build an INCLUDES criterion.
#'
#' @param value Criterion value.
#' @return A named criterion list.
#' @noRd
includes <- function(value, depth = NULL, excludes = NULL) {
  gql_criterion(value, "INCLUDES", depth = depth, excludes = excludes)
}

#' Build an INCLUDES_ALL criterion.
#'
#' @param value Criterion value.
#' @return A named criterion list.
#' @noRd
includes_all <- function(value, depth = NULL, excludes = NULL) {
  gql_criterion(value, "INCLUDES_ALL", depth = depth, excludes = excludes)
}

#' Build an IS_NULL criterion.
#'
#' @param value Boolean null criterion value.
#' @return A named criterion list.
#' @noRd
is_null <- function(value = TRUE) gql_criterion(value, "IS_NULL")

not_null <- function(value = NULL) gql_criterion(value, "NOT_NULL")

excludes <- function(value, depth = NULL) {
  gql_criterion(value, "EXCLUDES", depth = depth)
}

not_equals <- function(value) gql_criterion(value, "NOT_EQUALS")

between <- function(value, value2) {
  list(value = value, modifier = "BETWEEN", value2 = value2)
}

greater_than <- function(value) gql_criterion(value, "GREATER_THAN")

less_than <- function(value) gql_criterion(value, "LESS_THAN")

matches_regex <- function(value) gql_criterion(value, "MATCHES_REGEX")

not_matches_regex <- function(value) gql_criterion(value, "NOT_MATCHES_REGEX")
