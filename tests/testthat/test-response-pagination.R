testthat::test_that("object responses combine all pages and retain metadata", {
  response_api <- new.env(parent = globalenv())
  sys.source(
    file.path(testthat::test_path("..", ".."), "R", "executeQuery.R"),
    envir = response_api
  )
  sys.source(
    file.path(testthat::test_path("..", ".."), "R", "progress_helpers.R"),
    envir = response_api
  )
  connection <- list(
    exec = function(query, variables) {
      page <- if ("page" %in% names(variables$filter)) variables$filter$page else 1L
      ids <- if (page == 1L) 1:5000 else 5001:6000
      jsonlite::toJSON(
        list(data = list(find = list(count = 6000L, items = data.frame(id = ids)))),
        auto_unbox = TRUE
      )
    }
  )

  result <- response_api$executeQuery(
    query = "query",
    variables = list(filter = list(per_page = -1L)),
    connection = connection,
    return_default = "items",
    field = "items",
    response = "object"
  )

  testthat::expect_s3_class(result, "stashapi_response")
  testthat::expect_equal(nrow(result$data), 6000)
  testthat::expect_identical(result$meta$count, 6000L)
  testthat::expect_identical(result$meta$pages, 2L)
})
