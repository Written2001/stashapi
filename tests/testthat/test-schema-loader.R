setwd(package_root)
loader_environment <- new.env(parent = globalenv())
sys.source(file.path(package_root, "tools", "schema_loader.R"), envir = loader_environment)

testthat::test_that("schema loader preserves the legacy JSON input", {
  raw_schema <- loader_environment$read_schema_types(
    schema_path = schema_fixture_path()
  )

  testthat::expect_true(is.data.frame(raw_schema))
  testthat::expect_true("Query" %in% raw_schema$name)
})

testthat::test_that("schema loader accepts a Stash SDL checkout", {
  source_root <- tempfile("stash-schema-")
  dir.create(file.path(source_root, "graphql", "schema", "types"), recursive = TRUE)
  writeLines(
    c("schema { query: Query mutation: Mutation }", "", "type Query { hello: String }", ""),
    file.path(source_root, "graphql", "schema", "schema.graphql")
  )
  writeLines(
    "type Mutation { update: Boolean }",
    file.path(source_root, "graphql", "schema", "types", "mutation.graphql")
  )

  raw_schema <- loader_environment$read_schema_types(source_root = source_root)

  testthat::expect_true(is.data.frame(raw_schema))
  testthat::expect_true("Query" %in% raw_schema$name)
  testthat::expect_true("Mutation" %in% raw_schema$name)
})

testthat::test_that("schema loader rejects ambiguous inputs", {
  testthat::expect_error(
    loader_environment$read_schema_types(),
    "exactly one"
  )
})

testthat::test_that("the pinned schema provenance identifies an immutable release", {
  provenance <- jsonlite::fromJSON(
    file.path(package_root, "inst", "extdata", "schema.provenance.json"),
    simplifyVector = FALSE
  )

  testthat::expect_identical(provenance$ref, "v0.31.1")
  testthat::expect_identical(provenance$stashapi_version, "0.8.2")
  testthat::expect_identical(
    provenance$commit,
    "4de2351e7cc990d7ccd7cb6c84c275cd53bf6e55"
  )
})
