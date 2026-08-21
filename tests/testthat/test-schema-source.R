package_root <- normalizePath(testthat::test_path("..", ".."), mustWork = TRUE)
source_path <- file.path(package_root, "tools", "schema_source.R")
schema_source <- new.env(parent = globalenv())
sys.source(source_path, envir = schema_source)

testthat::test_that("Stash schema source files are discovered deterministically", {
  source_root <- tempfile("stash-schema-")
  dir.create(file.path(source_root, "graphql", "schema", "types"), recursive = TRUE)
  writeLines(
    "type Query { hello: String }",
    file.path(source_root, "graphql", "schema", "schema.graphql")
  )
  writeLines(
    "type Scene { id: ID! }",
    file.path(source_root, "graphql", "schema", "types", "scene.graphql")
  )

  source_info <- schema_source$read_stash_schema_source(source_root, ref = "test-sha")

  testthat::expect_identical(source_info$source, "https://github.com/stashapp/stash")
  testthat::expect_identical(source_info$ref, "test-sha")
  testthat::expect_identical(
    source_info$files,
    c("graphql/schema/schema.graphql", "graphql/schema/types/scene.graphql")
  )
  testthat::expect_identical(source_info$contents[[1]], "type Query { hello: String }")
  testthat::expect_length(source_info$fingerprints, 2L)
})

testthat::test_that("missing Stash schema sources fail clearly", {
  source_root <- tempfile("stash-empty-")
  dir.create(source_root)

  testthat::expect_error(
    schema_source$resolve_stash_schema_files(source_root),
    "no Stash GraphQL schema files"
  )
})