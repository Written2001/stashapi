package_root <- normalizePath(testthat::test_path("..", ".."), mustWork = TRUE)
generated_wrapper_path <- file.path(package_root, "R", "stashapi_functions.R")
schema_path <- file.path(package_root, "inst", "extdata", "schema.json")
generator_path <- file.path(package_root, "tools", "build_functions.R")

testthat::test_that("generated wrappers match the checked-in schema output", {
  testthat::skip_if_not(
    file.exists(generator_path),
    "The source-tree generator is unavailable in an installed package test."
  )
  testthat::expect_true(file.exists(schema_path))
  testthat::expect_true(file.exists(generated_wrapper_path))

  previous_directory <- setwd(package_root)
  on.exit(setwd(previous_directory), add = TRUE)

  generated_path <- tempfile(fileext = ".R")
  on.exit(unlink(generated_path), add = TRUE)

  generator_environment <- new.env(parent = globalenv())
  sys.source(generator_path, envir = generator_environment)
  generator_environment$generate_functions(generated_path)

  expected <- readLines(generated_wrapper_path, warn = FALSE)
  actual <- readLines(generated_path, warn = FALSE)
  testthat::expect_identical(actual, expected)
})

testthat::test_that("generated operation names are exported", {
  generated_source <- readLines(generated_wrapper_path, warn = FALSE)
  generated_names <- sub(
    "^([A-Za-z][A-Za-z0-9]*) <- function.*$",
    "\\1",
    generated_source[grepl("^[A-Za-z][A-Za-z0-9]* <- function", generated_source)]
  )

  testthat::expect_gt(length(generated_names), 0)
  testthat::expect_true(all(generated_names %in% getNamespaceExports("stashapi")))
})

testthat::test_that("findScenes preserves its schema-derived contract", {
  find_scenes_formals <- names(formals(stashapi::findScenes))
  testthat::expect_identical(
    find_scenes_formals,
    c("scenefilter", "sceneids", "ids", "filter", "...")
  )

  generated_source <- paste(readLines(generated_wrapper_path, warn = FALSE), collapse = "\n")
  testthat::expect_match(
    generated_source,
    "query findScenes\\(\\$scenefilter: SceneFilterType \\$sceneids: \\[Int!\\] \\$ids: \\[ID!\\] \\$filter: FindFilterType\\)"
  )
  testthat::expect_match(generated_source, "scene_filter: \\$scenefilter")
  testthat::expect_match(generated_source, "fragment FindScenesResultType on FindScenesResultType")
  testthat::expect_match(generated_source, "return_default <- \"scenes\"")
  testthat::expect_match(generated_source, "dotargs\\$\\.field")
})
