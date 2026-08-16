package_root <- normalizePath(testthat::test_path("..", ".."), mustWork = TRUE)
schema_path <- file.path(package_root, "inst", "extdata", "schema.json")
type_path <- file.path(package_root, "tools", "schema_types.R")

schema_types <- new.env(parent = globalenv())
sys.source(type_path, envir = schema_types)

testthat::test_that("the checked-in schema becomes a complete named registry", {
  raw_schema <- jsonlite::fromJSON(schema_path, flatten = FALSE)$data$`__schema`$types
  registry <- schema_types$normalize_schema_registry(raw_schema)

  testthat::expect_length(registry, 309)
  testthat::expect_true(all(nzchar(names(registry))))
  testthat::expect_identical(registry$Scene$name, "Scene")
  testthat::expect_identical(registry$Scene$kind, "OBJECT")
  testthat::expect_true(length(registry$Scene$fields) > 0)
})

testthat::test_that("input object fields retain type and default metadata", {
  raw_schema <- jsonlite::fromJSON(schema_path, flatten = FALSE)$data$`__schema`$types
  registry <- schema_types$normalize_schema_registry(raw_schema)

  scene_filter <- registry$SceneFilterType
  testthat::expect_identical(scene_filter$kind, "INPUT_OBJECT")
  testthat::expect_gt(length(scene_filter$input_fields), 0)

  id_field <- scene_filter$input_fields[[which(vapply(
    scene_filter$input_fields,
    function(field) identical(field$name, "id"),
    logical(1)
  ))[1]]]
  testthat::expect_identical(schema_types$type_ref_named_type(id_field$type), "IntCriterionInput")
  testthat::expect_identical(id_field$field_kind, "input")
})

testthat::test_that("output fields retain arguments and abstract type metadata", {
  raw_schema <- jsonlite::fromJSON(schema_path, flatten = FALSE)$data$`__schema`$types
  registry <- schema_types$normalize_schema_registry(raw_schema)

  find_scenes <- registry$Query$fields[[which(vapply(
    registry$Query$fields,
    function(field) identical(field$name, "findScenes"),
    logical(1)
  ))[1]]]
  testthat::expect_identical(schema_types$type_ref_named_type(find_scenes$type), "FindScenesResultType")
  testthat::expect_identical(
    vapply(find_scenes$arguments, function(argument) argument$name, character(1)),
    c("scene_filter", "scene_ids", "ids", "filter")
  )
  testthat::expect_identical(schema_types$type_ref_to_string(find_scenes$arguments[[2]]$type), "[Int!]")
})

testthat::test_that("duplicate schema type names are rejected", {
  duplicate_schema <- data.frame(
    kind = c("SCALAR", "SCALAR"),
    name = c("Duplicate", "Duplicate"),
    description = c(NA_character_, NA_character_),
    stringsAsFactors = FALSE
  )

  testthat::expect_error(
    schema_types$normalize_schema_registry(duplicate_schema),
    "duplicate type names"
  )
})
