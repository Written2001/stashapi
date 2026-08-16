package_root <- normalizePath(testthat::test_path("..", ".."), mustWork = TRUE)
schema_path <- file.path(package_root, "inst", "extdata", "schema.json")
generator_path <- file.path(package_root, "tools", "build_schema.R")

testthat::test_that("the checked-in schema produces the expected generator model", {
  testthat::expect_true(file.exists(schema_path))
  testthat::expect_true(file.exists(generator_path))

  previous_directory <- setwd(package_root)
  on.exit(setwd(previous_directory), add = TRUE)

  generator_environment <- new.env(parent = globalenv())
  sys.source(generator_path, envir = generator_environment)

  testthat::expect_equal(nrow(generator_environment$schema_types), 309)
  testthat::expect_equal(nrow(generator_environment$schema_objects), 108)
  testthat::expect_equal(nrow(generator_environment$schema_unions), 2)
  testthat::expect_equal(nrow(generator_environment$schema_requests), 187)
  testthat::expect_length(unique(generator_environment$schema_requests$name), 187)
})

testthat::test_that("representative schema fields retain their generated contract", {
  previous_directory <- setwd(package_root)
  on.exit(setwd(previous_directory), add = TRUE)

  generator_environment <- new.env(parent = globalenv())
  sys.source(generator_path, envir = generator_environment)

  find_scenes <- generator_environment$schema_requests |>
    dplyr::filter(name == "findScenes")

  expected_request <- paste0(
    "query findScenes($scenefilter: SceneFilterType $sceneids: [Int!] ",
    "$ids: [ID!] $filter: FindFilterType) { ",
    "findScenes(scene_filter: $scenefilter scene_ids: $sceneids ids: $ids filter: $filter) ",
    "{ ...FindScenesResultType } }"
  )
  testthat::expect_equal(find_scenes$request, expected_request)
  testthat::expect_equal(find_scenes$return_object, "scenes")
  testthat::expect_true(grepl("fragment FindScenesResultType", find_scenes$combined_fragment))
  testthat::expect_true(grepl("fragment Scene on Scene", find_scenes$combined_fragment))

  scene_filter <- find_scenes$arg_types[[1]]
  testthat::expect_equal(scene_filter$name, c("scene_filter", "scene_ids", "ids", "filter"))
  testthat::expect_equal(scene_filter$san_name, c("scenefilter", "sceneids", "ids", "filter"))
  testthat::expect_equal(scene_filter$arg_type, c("SceneFilterType", "Int", "ID", "FindFilterType"))
})

testthat::test_that("fragment dependencies are transitive and cycle-safe", {
  previous_directory <- setwd(package_root)
  on.exit(setwd(previous_directory), add = TRUE)

  generator_environment <- new.env(parent = globalenv())
  sys.source(generator_path, envir = generator_environment)

  fragments <- generator_environment$fragments_df
  dependencies <- generator_environment$get_dependent_fragments(
    frag_objects = list(c("Scene")),
    fragments_df = fragments,
    visited_frag_objects = character()
  ) |>
    purrr::flatten_chr()

  testthat::expect_equal(dependencies[[1]], "Scene")
  testthat::expect_true("VideoFile" %in% dependencies)
  testthat::expect_true("Fingerprint" %in% dependencies)
  testthat::expect_equal(length(dependencies), length(unique(dependencies)))
})
