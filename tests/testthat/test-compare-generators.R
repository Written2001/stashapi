package_root <- normalizePath(testthat::test_path("..", ".."), mustWork = TRUE)
comparison_path <- file.path(package_root, "tools", "compare_generators.R")

comparison_environment <- new.env(parent = globalenv())
sys.source(comparison_path, envir = comparison_environment)

comparison <- comparison_environment$compare_generators(package_root)

# The comparison is intentionally contract-level: renderer formatting is allowed
# to differ while operation behavior must remain equivalent.
testthat::test_that("old and new generators cover the same operations", {
  testthat::expect_length(comparison$legacy, 187)
  testthat::expect_length(comparison$new, 187)
  testthat::expect_identical(comparison$comparison$missing_from_new, character())
  testthat::expect_identical(comparison$comparison$added_in_new, character())
})

testthat::test_that("old and new generators preserve operation contracts", {
  differences <- comparison$comparison$differences
  testthat::expect_length(differences, 2)
  testthat::expect_identical(
    vapply(differences, function(difference) difference$name, character(1)),
    c("findFile", "findFiles")
  )
  testthat::expect_identical(differences[[1]]$fields, "return_class")
  testthat::expect_identical(differences[[2]]$fields, "response_field")
})

testthat::test_that("representative legacy and new contracts agree", {
  for (operation_name in c("findScenes", "findTags", "sceneCreate", "downloadFFMpeg")) {
    old <- comparison$legacy[[operation_name]]
    new <- comparison$new[[operation_name]]
    testthat::expect_identical(old$operation_kind, new$operation_kind)
    testthat::expect_identical(old$arguments, new$arguments)
    testthat::expect_identical(old$r_arguments, new$r_arguments)
    testthat::expect_identical(old$return_class, new$return_class)
    testthat::expect_identical(old$return_named_type, new$return_named_type)
  }
})
