schema_path <- schema_fixture_path()
type_path <- file.path(package_root, "tools", "schema_types.R")
input_path <- file.path(package_root, "tools", "schema_inputs.R")

schema_types <- new.env(parent = globalenv())
sys.source(type_path, envir = schema_types)
sys.source(input_path, envir = schema_types)

build_registry <- function() {
  raw_schema <- read_schema_fixture() # nolint: object_usage_linter
  schema_types$normalize_schema_registry(raw_schema)
}

testthat::test_that("input builder names are readable snake_case", {
  testthat::expect_identical(schema_types$input_builder_name("SceneFilterType"), "scene_filter")
  testthat::expect_identical(schema_types$input_builder_name("GalleryCreateInput"), "gallery_create_input")
})

testthat::test_that("input builder IR covers schema input objects", {
  builders <- schema_types$build_input_builder_ir(build_registry())

  testthat::expect_true("SceneFilterType" %in% names(builders))
  testthat::expect_identical(builders$SceneFilterType$function_name, "scene_filter")
  testthat::expect_true("id" %in% builders$SceneFilterType$field_names)
  testthat::expect_identical(builders$SceneFilterType$type_name, "SceneFilterType")
})

testthat::test_that("gql_input returns legacy-compatible named lists", {
  registry <- build_registry()
  result <- schema_types$gql_input(
    "SceneFilterType",
    tags = list(value = 182, modifier = "INCLUDES"),
    .registry = registry
  )

  testthat::expect_identical(
    result,
    list(tags = list(value = 182, modifier = "INCLUDES"))
  )
})

testthat::test_that("gql_input rejects unknown fields by default", {
  testthat::expect_error(
    schema_types$gql_input("SceneFilterType", not_a_field = 1, .registry = build_registry()),
    "unknown fields"
  )
})

testthat::test_that("criterion helpers compose the documented filter shape", {
  testthat::expect_identical(equals <- schema_types$equals("4k"), list(value = "4k", modifier = "EQUALS"))
  testthat::expect_identical(schema_types$includes(182), list(value = 182, modifier = "INCLUDES"))
  testthat::expect_identical(schema_types$includes_all(c(84, 85)), list(value = c(84, 85), modifier = "INCLUDES_ALL"))
  testthat::expect_identical(schema_types$is_null(), list(value = TRUE, modifier = "IS_NULL"))
  testthat::expect_identical(schema_types$not_null(), list(modifier = "NOT_NULL"))
  testthat::expect_identical(
    schema_types$includes(182, depth = -1, excludes = c(183, 184)),
    list(value = 182, modifier = "INCLUDES", depth = -1, excludes = c(183, 184))
  )
  testthat::expect_identical(
    schema_types$excludes(182, depth = -1),
    list(value = 182, modifier = "EXCLUDES", depth = -1)
  )
  testthat::expect_identical(
    schema_types$between(1, 10),
    list(value = 1, modifier = "BETWEEN", value2 = 10)
  )
  testthat::expect_identical(schema_types$greater_than(3), list(value = 3, modifier = "GREATER_THAN"))
  testthat::expect_identical(schema_types$less_than(10), list(value = 10, modifier = "LESS_THAN"))
  testthat::expect_identical(schema_types$matches_regex("^path/"), list(value = "^path/", modifier = "MATCHES_REGEX"))
  testthat::expect_identical(
    schema_types$not_matches_regex("tmp$"),
    list(value = "tmp$", modifier = "NOT_MATCHES_REGEX")
  )
})
