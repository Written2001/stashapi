package_root <- normalizePath(testthat::test_path("..", ".."), mustWork = TRUE)
schema_path <- file.path(package_root, "inst", "extdata", "schema.json")
type_path <- file.path(package_root, "tools", "schema_types.R")
operation_path <- file.path(package_root, "tools", "schema_operations.R")

schema_types <- new.env(parent = globalenv())
sys.source(type_path, envir = schema_types)
sys.source(operation_path, envir = schema_types)

build_registry <- function() {
  raw_schema <- jsonlite::fromJSON(schema_path, flatten = FALSE)$data$`__schema`$types
  schema_types$normalize_schema_registry(raw_schema)
}

testthat::test_that("operation IR covers non-deprecated Query and Mutation fields", {
  operations <- schema_types$build_operation_ir(build_registry())

  testthat::expect_length(operations, 187)
  testthat::expect_true(all(nzchar(names(operations))))
  testthat::expect_identical(operations$findScenes$operation_kind, "query")
  testthat::expect_identical(operations$sceneCreate$operation_kind, "mutation")
  testthat::expect_false("findDefaultFilter" %in% names(operations))
})

testthat::test_that("operation IR preserves argument and return type metadata", {
  operations <- schema_types$build_operation_ir(build_registry())
  find_scenes <- operations$findScenes

  testthat::expect_identical(find_scenes$return_named_type, "FindScenesResultType")
  testthat::expect_identical(find_scenes$return_type_string, "FindScenesResultType!")
  testthat::expect_identical(find_scenes$selection_kind, "OBJECT")
  testthat::expect_identical(
    vapply(find_scenes$arguments, function(argument) argument$r_name, character(1)),
    c("scenefilter", "sceneids", "ids", "filter")
  )
  testthat::expect_identical(find_scenes$arguments[[2]]$type_string, "[Int!]")
  testthat::expect_false(find_scenes$arguments[[2]]$required)
  testthat::expect_true(schema_types$type_ref_contains(find_scenes$arguments[[2]]$type, "NON_NULL"))
})

testthat::test_that("operation lookup returns records and reports missing names", {
  operations <- schema_types$build_operation_ir(build_registry())
  operation <- schema_types$get_operation(operations, "findScenes")

  testthat::expect_identical(operation$name, "findScenes")
  testthat::expect_error(
    schema_types$get_operation(operations, "notAnOperation"),
    "operation not found"
  )
})

testthat::test_that("operation IR rejects missing roots", {
  testthat::expect_error(
    schema_types$build_operation_ir(list(Query = list(kind = "OBJECT", fields = list())), root_types = "Mutation"),
    "missing root type"
  )
})
