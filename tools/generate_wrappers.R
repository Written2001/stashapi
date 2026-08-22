source("tools/schema_types.R")
source("tools/schema_loader.R")
source("tools/schema_policy.R")
source("tools/schema_operations.R")
source("tools/schema_selection.R")
source("tools/schema_render.R")
source("tools/render_r.R")

#' Generate all GraphQL operation wrappers from schema data.
#'
#' Provide exactly one of `schema_path` or `source_root`. The first reads an
#' existing introspection snapshot; the second parses a pinned SDL checkout.
#' The result is one deterministic R source string for the wrapper file.
#'
#' @param schema_path Path to an introspection JSON snapshot.
#' @param source_root Path to a pinned Stash SDL checkout.
#' @param source_ref Optional source reference passed to the SDL parser.
#' @return Character scalar containing generated R source.
#' @noRd
build_wrappers <- function(
  schema_path = NULL,
  source_root = NULL,
  source_ref = NULL
) {
  if (is.null(schema_path) && is.null(source_root)) {
    source_root <- Sys.getenv("STASH_SOURCE_ROOT", unset = "")
  }
  if (is.null(source_root) || !nzchar(source_root)) source_root <- NULL
  if (is.null(schema_path) && is.null(source_root)) {
    stop("STASH_SOURCE_ROOT must identify a pinned SDL checkout", call. = FALSE)
  }
  normalize_registry <- get("normalize_schema_registry", mode = "function")
  build_operations <- get("build_operation_ir", mode = "function")
  build_fragments <- get("build_fragment_graph", mode = "function")
  render_document <- get("render_graphql_document", mode = "function")
  render_leaf_operation <- get("render_operation", mode = "function")
  render_wrapper <- get("render_r_wrapper", mode = "function")
  raw_schema <- read_schema_types(
    schema_path = if (is.null(source_root)) schema_path else NULL,
    source_root = source_root,
    source_ref = source_ref
  )
  registry <- normalize_registry(raw_schema)
  operations <- build_operations(registry)

  wrappers <- lapply(operations, function(operation) {
    if (operation$selection_kind %in% c("OBJECT", "UNION", "INTERFACE")) {
      graph <- build_fragments(registry, operation$return_named_type)
      document <- render_document(operation, graph, allow_cycles = TRUE)
    } else {
      document <- render_leaf_operation(operation)
    }
    render_wrapper(operation, document)
  })

  paste(unlist(wrappers, use.names = FALSE), collapse = "\n")
}

args <- commandArgs(trailingOnly = TRUE)
if (length(args) > 0L) {
  output_path <- args[[1]]
  if (length(args) > 1L && identical(args[[2]], "--schema")) {
    writeLines(build_wrappers(schema_path = args[[3]]), output_path)
  } else {
    source_root <- if (length(args) > 1L) args[[2]] else NULL
    source_ref <- if (length(args) > 2L) args[[3]] else NULL
    writeLines(build_wrappers(
      schema_path = NULL,
      source_root = source_root,
      source_ref = source_ref
    ), output_path)
  }
}
