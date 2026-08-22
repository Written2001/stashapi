schema_path <- schema_fixture_path()
type_path <- file.path(package_root, "tools", "schema_types.R")
operation_path <- file.path(package_root, "tools", "schema_operations.R")
render_path <- file.path(package_root, "tools", "schema_render.R")
selection_path <- file.path(package_root, "tools", "schema_selection.R")

schema_types <- new.env(parent = globalenv())
sys.source(type_path, envir = schema_types)
sys.source(operation_path, envir = schema_types)
sys.source(selection_path, envir = schema_types)
sys.source(render_path, envir = schema_types)

build_operations <- function() {
  raw_schema <- read_schema_fixture() # nolint: object_usage_linter
  registry <- schema_types$normalize_schema_registry(raw_schema)
  schema_types$build_operation_ir(registry)
}

testthat::test_that("renderer preserves operation variables and GraphQL names", {
  operation <- build_operations()$findScenes

  testthat::expect_identical(
    schema_types$render_variable_definitions(operation),
    "($scenefilter: SceneFilterType $sceneids: [Int!] $ids: [ID!] $filter: FindFilterType)"
  )
  testthat::expect_identical(
    schema_types$render_field_arguments(operation),
    "(scene_filter: $scenefilter scene_ids: $sceneids ids: $ids filter: $filter)"
  )
})

testthat::test_that("renderer creates a complete object-returning operation", {
  operation <- build_operations()$findScenes
  result <- schema_types$render_operation(operation)

  testthat::expect_identical(
    result,
    paste0(
      "query findScenes($scenefilter: SceneFilterType $sceneids: [Int!] $ids: [ID!] ",
      "$filter: FindFilterType) { findScenes(scene_filter: $scenefilter ",
      "scene_ids: $sceneids ids: $ids filter: $filter) { ...FindScenesResultType } }"
    )
  )
})

testthat::test_that("renderer handles no-argument leaf operations", {
  operation <- build_operations()$downloadFFMpeg
  testthat::expect_identical(
    schema_types$render_operation(operation),
    "mutation downloadFFMpeg { downloadFFMpeg }"
  )
})

testthat::test_that("renderer accepts a custom selection function", {
  operation <- build_operations()$findScenes
  result <- schema_types$render_operation(operation, selection_fn = function(operation) "id")

  testthat::expect_match(result, "findScenes\\(scene_filter:")
  testthat::expect_match(result, "\\{ id \\} \\}")
})

testthat::test_that("renderer emits fragments in dependency order", {
  operation <- list(
    name = "example",
    operation_kind = "query",
    arguments = list(),
    return_named_type = "Root",
    selection_kind = "OBJECT"
  )
  graph <- list(
    Root = list(
      name = "Root",
      type_condition = "Root",
      selection_string = "child { ...Child }",
      references = "Child"
    ),
    Child = list(
      name = "Child",
      type_condition = "Child",
      selection_string = "id",
      references = character()
    )
  )

  result <- schema_types$render_graphql_document(operation, graph)
  testthat::expect_identical(
    result,
    paste(
      "query example { example { ...Root } }",
      "fragment Child on Child { id }",
      "fragment Root on Root { child { ...Child } }",
      sep = "\n"
    )
  )
})

testthat::test_that("fragment validation rejects undefined references and cycles", {
  undefined_graph <- list(Root = list(references = "Missing"))
  testthat::expect_error(
    schema_types$validate_fragment_graph(undefined_graph, roots = "Root"),
    "undefined"
  )

  cyclic_graph <- list(
    A = list(references = "B"),
    B = list(references = "A")
  )
  testthat::expect_error(
    schema_types$validate_fragment_graph(cyclic_graph, roots = "A"),
    "cycle"
  )
})
