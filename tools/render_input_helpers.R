#' Render one schema-derived input helper.
#'
#' The generated helper delegates to gql_input_fields() and returns an
#' ordinary named list compatible with existing operation wrappers.
#'
#' @param builder One record from build_input_builder_ir().
#' @return R source for one input helper.
#' @noRd
render_input_helper <- function(builder) {
  allowed_fields <- paste0('"', builder$field_names, '"', collapse = ", ")
  paste0(
    builder$function_name, " <- function(..., .strict = TRUE) {\n",
    "  values <- list(...)\n",
    "  gql_input_fields(\n",
    "    values,\n",
    "    allowed_fields = c(", allowed_fields, "),\n",
    "    type_name = \"", builder$type_name, "\",\n",
    "    strict = .strict\n",
    "  )\n",
    "}\n"
  )
}

#' Render all schema-derived input helpers in stable schema order.
#'
#' @param builders Named input-builder IR records.
#' @return One deterministic R source string.
#' @noRd
render_input_helpers <- function(builders) {
  helpers <- lapply(builders, render_input_helper)
  paste(unlist(helpers, use.names = FALSE), collapse = "\n")
}
