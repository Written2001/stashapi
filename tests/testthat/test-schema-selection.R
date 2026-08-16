package_root <- normalizePath(testthat::test_path("..", ".."), mustWork = TRUE)
schema_path <- file.path(package_root, "inst", "extdata", "schema.json")
type_path <- file.path(package_root, "tools", "schema_types.R")
selection_path <- file.path(package_root, "tools", "schema_selection.R")
policy_path <- file.path(package_root, "tools", "schema_policy.R")

schema_types <- new.env(parent = globalenv())
sys.source(type_path, envir = schema_types)
sys.source(policy_path, envir = schema_types)
sys.source(selection_path, envir = schema_types)

build_registry <- function() {
  raw_schema <- jsonlite::fromJSON(schema_path, flatten = FALSE)$data$`__schema`$types
  schema_types$normalize_schema_registry(raw_schema)
}

testthat::test_that("selection graph retains symbolic nested references", {
  registry <- build_registry()
  graph <- schema_types$build_fragment_graph(registry, roots = "Scene")

  testthat::expect_true(all(c("Scene", "VideoFile", "SceneMarker") %in% names(graph)))
  testthat::expect_true("VideoFile" %in% graph$Scene$references)
  testthat::expect_true("SceneMarker" %in% graph$Scene$references)
  testthat::expect_true("files { ...VideoFile }" %in% graph$Scene$selections)
  testthat::expect_false("Scene" %in% graph$SceneMarker$references)
  testthat::expect_true(any(grepl("scene \\{ id title \\}", graph$SceneMarker$selections)))
})

testthat::test_that("dependency resolution is unique and dependency-first", {
  registry <- build_registry()
  graph <- schema_types$build_fragment_graph(registry, roots = "Scene")
  resolved <- schema_types$resolve_fragment_dependencies(graph, roots = "Scene")

  testthat::expect_identical(length(resolved$order), length(unique(resolved$order)))
  testthat::expect_identical(tail(resolved$order, 1), "Scene")
  testthat::expect_lt(match("VideoFile", resolved$order), match("Scene", resolved$order))
  testthat::expect_length(resolved$cycles, 0)
})

testthat::test_that("compact selection policies prevent major-object recursion", {
  registry <- build_registry()
  graph <- schema_types$build_fragment_graph(registry, roots = "Scene")
  scene <- graph$Scene

  testthat::expect_true(any(grepl("studio \\{ id name \\}", scene$selections)))
  testthat::expect_true(any(grepl("performers \\{ id name gender \\}", scene$selections)))
  testthat::expect_false("Studio" %in% scene$references)
  testthat::expect_false("Performer" %in% scene$references)
  testthat::expect_false("image" %in% scene$selections)
})

testthat::test_that("result fragments spread broad top-level objects", {
  registry <- build_registry()
  graph <- schema_types$build_fragment_graph(registry, roots = "FindScenesResultType")

  testthat::expect_true("Scene" %in% graph$FindScenesResultType$references)
  testthat::expect_true("scenes { ...Scene }" %in% graph$FindScenesResultType$selections)
  testthat::expect_true("code" %in% graph$Scene$selections)
  testthat::expect_true("performers { id name gender }" %in% graph$Scene$selections)
})

testthat::test_that("selection policy overrides are parent-independent and explicit", {
  registry <- build_registry()
  custom_policy <- function(parent_type, field_name, referenced_type) {
    if (field_name == "studio") {
      return(list(selection = "{ id url }", reference = NULL, source = "custom"))
    }
    list(selection = NULL, reference = referenced_type, source = "recursive")
  }
  graph <- schema_types$build_fragment_graph(
    registry,
    roots = "Scene",
    selection_policy_fn = custom_policy
  )

  testthat::expect_true(any(grepl("studio \\{ id url \\}", graph$Scene$selections)))
})

testthat::test_that("selection graph handles union possible types", {
  registry <- build_registry()
  graph <- schema_types$build_fragment_graph(registry, roots = "ScrapedContent")

  expected_selections <- paste0("...", graph$ScrapedContent$references)
  testthat::expect_identical(graph$ScrapedContent$selections, expected_selections)
  testthat::expect_gt(length(graph$ScrapedContent$references), 1)
})

testthat::test_that("dependency resolver reports synthetic cycles", {
  graph <- list(
    A = list(references = "B"),
    B = list(references = "C"),
    C = list(references = "A")
  )
  names(graph) <- c("A", "B", "C")

  result <- schema_types$resolve_fragment_dependencies(graph, roots = "A")
  testthat::expect_identical(result$order, c("C", "B", "A"))
  testthat::expect_identical(result$cycles[[1]], c("A", "B", "C", "A"))
})
