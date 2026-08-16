source("tools/schema_types.R")
source("tools/schema_policy.R")
source("tools/schema_operations.R")
source("tools/schema_selection.R")
source("tools/schema_render.R")
source("tools/render_r.R")

build_wrappers <- function(schema_path = "inst/extdata/schema.json") {
  normalize_registry <- get("normalize_schema_registry", mode = "function")
  build_operations <- get("build_operation_ir", mode = "function")
  build_fragments <- get("build_fragment_graph", mode = "function")
  render_document <- get("render_graphql_document", mode = "function")
  render_leaf_operation <- get("render_operation", mode = "function")
  render_wrapper <- get("render_r_wrapper", mode = "function")
  raw_schema <- jsonlite::fromJSON(schema_path, flatten = FALSE)$data$`__schema`$types
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
if (length(args) > 0L) writeLines(build_wrappers(), args[[1]])
