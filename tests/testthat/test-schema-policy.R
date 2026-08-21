schema_path <- schema_fixture_path()
type_path <- file.path(package_root, "tools", "schema_types.R")
policy_path <- file.path(package_root, "tools", "schema_policy.R")
operation_path <- file.path(package_root, "tools", "schema_operations.R")

schema_types <- new.env(parent = globalenv())
sys.source(type_path, envir = schema_types)
sys.source(policy_path, envir = schema_types)
sys.source(operation_path, envir = schema_types)

build_registry <- function() {
  raw_schema <- read_schema_fixture()
  schema_types$normalize_schema_registry(raw_schema)
}

testthat::test_that("response policies derive paginated fields from schema structure", {
  registry <- build_registry()
  policy <- schema_types$build_response_policy("findScenes", "FindScenesResultType", registry)

  testthat::expect_identical(policy$default_field, "scenes")
  testthat::expect_identical(policy$source, "schema")
})

testthat::test_that("response policies preserve whole responses when no list payload exists", {
  registry <- build_registry()
  policy <- schema_types$build_response_policy("sceneCreate", "Scene", registry)

  testthat::expect_true(is.na(policy$default_field))
  testthat::expect_identical(policy$source, "none")
})

testthat::test_that("response policy overrides take precedence", {
  registry <- build_registry()
  policy <- schema_types$build_response_policy(
    "findScenes",
    "FindScenesResultType",
    registry,
    overrides = c(findScenes = "count")
  )

  testthat::expect_identical(policy$default_field, "count")
  testthat::expect_identical(policy$source, "override")
})

testthat::test_that("operation IR carries explicit response policies", {
  registry <- build_registry()
  operations <- schema_types$build_operation_ir(registry)

  testthat::expect_identical(operations$findScenes$response_policy$default_field, "scenes")
  testthat::expect_true(is.na(operations$sceneCreate$response_policy$default_field))
})
