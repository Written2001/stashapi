testthat::test_that("public generated operation contracts remain stable", {
  testthat::expect_identical(
    names(formals(stashapi::findScenes)),
    c("scenefilter", "sceneids", "ids", "filter", "...")
  )
  testthat::expect_true("findScenes" %in% getNamespaceExports("stashapi"))
  testthat::expect_true("execute_mutations" %in% getNamespaceExports("stashapi"))
  testthat::expect_true("is_stash_connected" %in% getNamespaceExports("stashapi"))
})

testthat::test_that("response options retain their public contract", {
  testthat::expect_identical(
    stashapi:::prepare_stash_query_options(
      list(),
      return_default = "scenes"
    ),
    list(
      field = "scenes",
      response = "data",
      progress_bar = FALSE
    )
  )
  testthat::expect_error(
    stashapi:::prepare_stash_query_options(
      list(.field = "scenes", .response = "raw"),
      return_default = "scenes"
    ),
    "cannot be used"
  )
})

testthat::test_that("structured response errors retain their classes", {
  connection <- list(
    exec = function(query, variables) {
      '{"errors":[{"message":"contract test failure"}]}'
    }
  )

  error <- tryCatch(
    stashapi:::fetch_response(
      query = "query",
      variables = list(),
      connection = connection,
      return_default = NA_character_,
      field = NA_character_
    ),
    error = identity
  )

  testthat::expect_s3_class(error, "stashapi_graphql_error")
  testthat::expect_match(conditionMessage(error), "contract test failure")
})