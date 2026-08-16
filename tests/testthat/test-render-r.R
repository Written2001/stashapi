package_root <- normalizePath(testthat::test_path("..", ".."), mustWork = TRUE)
schema_path <- file.path(package_root, "inst", "extdata", "schema.json")
type_path <- file.path(package_root, "tools", "schema_types.R")
operation_path <- file.path(package_root, "tools", "schema_operations.R")
render_path <- file.path(package_root, "tools", "schema_render.R")
r_path <- file.path(package_root, "tools", "render_r.R")

schema_types <- new.env(parent = globalenv())
sys.source(type_path, envir = schema_types)
sys.source(operation_path, envir = schema_types)
sys.source(render_path, envir = schema_types)
sys.source(r_path, envir = schema_types)

build_operations <- function() {
  raw_schema <- jsonlite::fromJSON(schema_path, flatten = FALSE)$data$`__schema`$types
  registry <- schema_types$normalize_schema_registry(raw_schema)
  schema_types$build_operation_ir(registry)
}

testthat::test_that("R formals preserve sanitized operation argument names", {
  operation <- build_operations()$findScenes

  testthat::expect_identical(
    schema_types$render_r_formals(operation),
    "scenefilter = NA, sceneids = list(), ids = list(), filter = NA, ..."
  )
})

testthat::test_that("R variable serialization uses sanitized names", {
  operation <- build_operations()$findScenes
  result <- schema_types$render_r_variables(operation)

  testthat::expect_match(result, "variables <- list\\(\\)")
  testthat::expect_match(result, "variables\\[\\['scenefilter'\\]\\] <- scenefilter")
  testthat::expect_match(result, "variables\\[\\['sceneids'\\]\\] <- sceneids")
})

testthat::test_that("R wrapper renderer emits required argument checks", {
  operation <- build_operations()$sceneAddO
  result <- schema_types$render_r_validation(operation)

  testthat::expect_match(result, "id.*required")
  testthat::expect_match(result, "ID!")
  testthat::expect_false(grepl("times.*required", result))
})

testthat::test_that("R wrapper source preserves execution and field-selection behavior", {
  operation <- build_operations()$findScenes
  document <- "query findScenes { findScenes { ...FindScenesResultType } }"
  result <- schema_types$render_r_wrapper(operation, document)

  testthat::expect_true(grepl(
    "findScenes <- function(scenefilter = NA, sceneids = list(), ids = list(), filter = NA, ...)",
    result,
    fixed = TRUE
  ))
  testthat::expect_match(result, "query\\$query\\('findScenes'")
  testthat::expect_match(result, "query = query\\$queries\\$findScenes")
  testthat::expect_match(result, "connection = get_stash_connection\\(\\)")
  testthat::expect_match(result, "dotargs\\$\\.field")
})

testthat::test_that("R wrapper renderer handles no-argument operations", {
  operation <- build_operations()$downloadFFMpeg
  result <- schema_types$render_r_wrapper(operation, "mutation downloadFFMpeg { downloadFFMpeg }")

  testthat::expect_true(
    grepl("downloadFFMpeg <- function(...)", result, fixed = TRUE)
  )
  testthat::expect_match(result, "variables <- list\\(\\)")
})
