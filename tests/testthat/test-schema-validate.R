schema_path <- schema_fixture_path()
type_path <- file.path(package_root, "tools", "schema_types.R")
policy_path <- file.path(package_root, "tools", "schema_policy.R")
operation_path <- file.path(package_root, "tools", "schema_operations.R")
validate_path <- file.path(package_root, "tools", "schema_validate.R")

schema_types <- new.env(parent = globalenv())
sys.source(type_path, envir = schema_types)
sys.source(policy_path, envir = schema_types)
sys.source(operation_path, envir = schema_types)
sys.source(validate_path, envir = schema_types)

build_context <- function() {
  raw_schema <- read_schema_fixture()
  registry <- schema_types$normalize_schema_registry(raw_schema)
  list(registry = registry, operations = schema_types$build_operation_ir(registry))
}

make_type <- function(kinds, names) {
  type <- data.frame(kind = kinds[length(kinds)], name = names[length(names)])
  if (length(kinds) == 1) return(type)
  for (index in rev(seq_len(length(kinds) - 1))) {
    parent <- data.frame(kind = kinds[index], name = names[index])
    parent$ofType <- type
    type <- parent
  }
  schema_types$normalize_type_ref(type)
}

testthat::test_that("requiredness distinguishes outer and nested non-null", {
  scalar_required <- make_type(c("NON_NULL", "SCALAR"), c(NA, "ID"))
  list_item_required <- make_type(c("LIST", "NON_NULL", "SCALAR"), c(NA, NA, "ID"))
  list_required <- make_type(c("NON_NULL", "LIST", "SCALAR"), c(NA, NA, "ID"))
  list_both_required <- make_type(c("NON_NULL", "LIST", "NON_NULL", "SCALAR"), c(NA, NA, NA, "ID"))

  testthat::expect_error(schema_types$validate_graphql_value(NA, scalar_required, "id"), "required")
  testthat::expect_silent(schema_types$validate_graphql_value(NA, list_item_required, "ids"))
  testthat::expect_error(schema_types$validate_graphql_value(NA, list_required, "ids"), "required")
  testthat::expect_error(schema_types$validate_graphql_value(list(NA), list_both_required, "ids"), "required")
  testthat::expect_silent(schema_types$validate_graphql_value(list(), list_both_required, "ids"))
})

testthat::test_that("nested input objects validate required fields", {
  context <- build_context()
  operation <- context$operations$addTempDLNAIP
  input <- list()
  input_argument <- operation$arguments[[1]]

  testthat::expect_error(
    schema_types$validate_graphql_value(input, input_argument$type, "input", context$registry),
    "required"
  )
})

testthat::test_that("operation validation rejects missing required arguments", {
  context <- build_context()
  operation <- context$operations$sceneAddO
  values <- list(id = NA, times = list())

  testthat::expect_error(
    schema_types$validate_operation_arguments(operation, values, context$registry),
    "id.*required"
  )
})

testthat::test_that("optional arguments can be omitted or set to NA", {
  context <- build_context()
  operation <- context$operations$findScenes
  values <- list(scenefilter = NA, sceneids = list(), ids = list(), filter = NA)

  testthat::expect_silent(
    schema_types$validate_operation_arguments(operation, values, context$registry)
  )
})
