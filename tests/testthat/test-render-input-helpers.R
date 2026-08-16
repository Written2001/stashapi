package_root <- normalizePath(testthat::test_path("..", ".."), mustWork = TRUE)
schema_path <- file.path(package_root, "inst", "extdata", "schema.json")
type_path <- file.path(package_root, "tools", "schema_types.R")
input_path <- file.path(package_root, "tools", "schema_inputs.R")
render_path <- file.path(package_root, "tools", "render_input_helpers.R")

schema_types <- new.env(parent = globalenv())
sys.source(type_path, envir = schema_types)
sys.source(input_path, envir = schema_types)
sys.source(render_path, envir = schema_types)

build_builders <- function() {
  raw_schema <- jsonlite::fromJSON(schema_path, flatten = FALSE)$data$`__schema`$types
  registry <- schema_types$normalize_schema_registry(raw_schema)
  schema_types$build_input_builder_ir(registry)
}

testthat::test_that("input helper source uses stable readable names", {
  builders <- build_builders()
  result <- schema_types$render_input_helper(builders$SceneFilterType)

  testthat::expect_match(result, "scene_filter <- function")
  testthat::expect_match(result, "type_name = \\\"SceneFilterType\\\"")
  testthat::expect_match(result, "\\\"tags\\\"")
  testthat::expect_length(parse(text = result), 1)
})

testthat::test_that("all schema-derived input helpers render and parse", {
  result <- schema_types$render_input_helpers(build_builders())

  testthat::expect_length(parse(text = result), 158)
  testthat::expect_true(grepl("scene_filter <- function", result, fixed = TRUE))
  testthat::expect_true(grepl("gallery_create_input <- function", result, fixed = TRUE))
})
