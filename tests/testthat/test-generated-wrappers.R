testthat::test_that("findScenes preserves legacy nested-list calls", {
  testthat::skip_if_not(
    requireNamespace("stashapi", quietly = TRUE),
    "The installed package namespace is unavailable."
  )

  observed_variables <- NULL
  connection <- list(
    exec = function(query, variables) {
      observed_variables <<- variables
      '{"data":{"findScenes":{"count":1,"duration":0,"filesize":0,"scenes":[{"id":"1"}]}}}'
    }
  )

  package_namespace <- asNamespace("stashapi")
  get("set_stash_connection", envir = package_namespace)(connection)
  on.exit(get("stash_disconnect", envir = package_namespace)(), add = TRUE)

  result <- get("findScenes", envir = package_namespace)(
    scenefilter = list(tags = list(value = 182, modifier = "INCLUDES")),
    filter = list(per_page = 25)
  )

  testthat::expect_identical(
    observed_variables,
    list(
      scenefilter = list(tags = list(value = 182, modifier = "INCLUDES")),
      sceneids = list(),
      ids = list(),
      filter = list(per_page = 25)
    )
  )
  testthat::expect_type(result, "list")
  testthat::expect_identical(result[[1]], "1")
})
