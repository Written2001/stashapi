package_root <- normalizePath(testthat::test_path("..", ".."), mustWork = TRUE)
schema_path <- file.path(package_root, "inst", "extdata", "schema.json")

testthat::test_that("generated wrappers match the checked-in schema output", {
  generator_path <- file.path(package_root, "tools", "generate_wrappers.R")
  generated_wrapper_path <- file.path(package_root, "R", "stashapi_functions.R")
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
  writeLines(generator_environment$build_wrappers(), generated_path)

  expected <- readLines(generated_wrapper_path, warn = FALSE)
  actual <- readLines(generated_path, warn = FALSE)
  testthat::expect_identical(actual, expected)
})

testthat::test_that("generated operation names are exported", {
  generated_source <- readLines(
    file.path(package_root, "R", "stashapi_functions.R"),
    warn = FALSE
  )
  generated_names <- sub(
    "^([A-Za-z][A-Za-z0-9]*) <- function.*$",
    "\\1",
    generated_source[grepl("^[A-Za-z][A-Za-z0-9]* <- function", generated_source)]
  )

  testthat::expect_gt(length(generated_names), 0)
  testthat::expect_true(all(generated_names %in% getNamespaceExports("stashapi")))
  export_directives <- grepl("^#' @export$", generated_source)
  testthat::expect_length(export_directives, length(generated_source))
  testthat::expect_equal(
    sum(export_directives),
    length(generated_names)
  )
})

testthat::test_that("generated wrappers include schema-derived roxygen documentation", {
  generated_source <- paste(
    readLines(file.path(package_root, "R", "stashapi_functions.R"), warn = FALSE),
    collapse = "\n"
  )
  testthat::expect_match(generated_source, "#' Call GraphQL operation: findScenes")
  testthat::expect_match(generated_source, "#' @description A function which queries Scene objects")
  testthat::expect_match(generated_source, "#' @param scenefilter ")
  testthat::expect_match(
    generated_source,
    "#' @param ... Additional options",
    fixed = TRUE
  )
  testthat::expect_match(generated_source, "#' @return The processed API response\\.")
})

setwd(package_root)
render_environment <- new.env(parent = globalenv())
sys.source(file.path(package_root, "tools", "schema_types.R"), envir = render_environment)
sys.source(file.path(package_root, "tools", "schema_inputs.R"), envir = render_environment)
sys.source(file.path(package_root, "tools", "render_input_helpers.R"), envir = render_environment)

build_input_builders <- function() {
  raw_schema <- jsonlite::fromJSON(schema_path, flatten = FALSE)$data$`__schema`$types
  registry <- render_environment$normalize_schema_registry(raw_schema)
  render_environment$build_input_builder_ir(registry)
}

testthat::test_that("input helper source uses stable readable names", {
  builders <- build_input_builders()
  result <- render_environment$render_input_helper(builders$SceneFilterType)

  testthat::expect_match(result, "scene_filter <- function")
  testthat::expect_match(result, 'type_name = "SceneFilterType"')
  testthat::expect_match(result, '"tags"')
  testthat::expect_length(parse(text = result), 1)
})

testthat::test_that("all schema-derived input helpers render and parse", {
  result <- render_environment$render_input_helpers(build_input_builders())

  testthat::expect_length(parse(text = result), 158)
  testthat::expect_true(grepl("scene_filter <- function", result, fixed = TRUE))
  testthat::expect_true(grepl("gallery_create_input <- function", result, fixed = TRUE))
})

doc_environment <- new.env(parent = globalenv())
sys.source(
  file.path(package_root, "tools", "generate_input_helper_docs.R"),
  envir = doc_environment
)
raw_schema <- jsonlite::fromJSON(schema_path, flatten = FALSE)$data$`__schema`$types
doc_registry <- doc_environment$normalize_schema_registry(raw_schema)
doc_builders <- doc_environment$build_input_builder_ir(doc_registry)

testthat::test_that("generated filter docs cover every schema field", {
  output_dir <- tempfile()
  dir.create(output_dir)
  on.exit(unlink(output_dir, recursive = TRUE), add = TRUE)
  doc_environment$generate_input_helper_docs(schema_path, output_dir)

  for (type_name in names(doc_environment$curated_types)) {
    builder <- doc_builders[[type_name]]
    path <- file.path(
      output_dir,
      paste0(doc_environment$helper_name(type_name, builder), ".Rd")
    )
    content <- paste(readLines(path, warn = FALSE), collapse = "\n")
    for (field_name in builder$field_names) {
      testthat::expect_true(
        grepl(paste0("\\code{", field_name, "}"), content, fixed = TRUE),
        info = paste(type_name, field_name)
      )
    }
  }
})

testthat::test_that("generated filter docs are deterministic and parseable", {
  first <- doc_environment$render_filter_doc(
    doc_builders$SceneFilterType,
    doc_environment$curated_types[["SceneFilterType"]]
  )
  second <- doc_environment$render_filter_doc(
    doc_builders$SceneFilterType,
    doc_environment$curated_types[["SceneFilterType"]]
  )
  testthat::expect_identical(first, second)

  path <- tempfile(fileext = ".Rd")
  writeLines(first, path)
  testthat::expect_silent(tools::parse_Rd(path))
  unlink(path)
  testthat::expect_match(first, "\\section{Allowed fields}", fixed = TRUE)
  testthat::expect_match(
    first,
    '\\examples{scene_filter(title = includes("example"))}',
    fixed = TRUE
  )
  testthat::expect_match(
    first,
    'R input: `criterion, e.g. includes("text")`',
    fixed = TRUE
  )
})