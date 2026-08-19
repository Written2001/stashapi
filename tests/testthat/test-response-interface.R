response_api <- new.env(parent = globalenv())
sys.source(
  file.path(testthat::test_path("..", ".."), "R", "execute_query.R"),
  envir = response_api
)
sys.source(
  file.path(testthat::test_path("..", ".."), "R", "progress_helpers.R"),
  envir = response_api
)

testthat::test_that("default response mode preserves selected data", {
  connection <- list(
    exec = function(query, variables) {
      '{"data":{"find":{"count":2,"items":[{"id":1}]}}}'
    }
  )

  result <- response_api$execute_query(
    query = "query",
    variables = list(),
    connection = connection,
    return_default = "find",
    field = "items"
  )

  testthat::expect_true(is.data.frame(result))
  testthat::expect_identical(result$id, 1L)
})

testthat::test_that("object responses preserve data and metadata", {
  connection <- list(
    exec = function(query, variables) {
      '{"data":{"find":{"count":2,"items":[{"id":1}]}}}'
    }
  )

  result <- response_api$execute_query(
    query = "query",
    variables = list(),
    connection = connection,
    return_default = "find",
    field = "items",
    response = "object"
  )

  testthat::expect_s3_class(result, "stashapi_response")
  testthat::expect_true(is.data.frame(result$data))
  testthat::expect_identical(result$meta$count, 2L)
  testthat::expect_identical(result$raw$data$find$count, 2L)
})

testthat::test_that("raw responses return the decoded GraphQL envelope", {
  connection <- list(
    exec = function(query, variables) {
      '{"data":{"find":{"count":2}}}'
    }
  )

  result <- response_api$execute_query(
    query = "query",
    variables = list(),
    connection = connection,
    return_default = "find",
    field = NA_character_,
    response = "raw"
  )

  testthat::expect_identical(result$data$find$count, 2L)
  raw_field_error <- tryCatch(
    response_api$execute_query(
      query = "query",
      variables = list(),
      connection = connection,
      return_default = "find",
      field = "find",
      response = "raw"
    ),
    error = identity
  )
  testthat::expect_s3_class(raw_field_error, "error")
  testthat::expect_match(conditionMessage(raw_field_error), "cannot be used")
})

testthat::test_that("response failures use structured error classes", {
  connection <- list(
    exec = function(query, variables) {
      '{"errors":[{"message":"invalid query"}]}'
    }
  )

  error <- tryCatch(
    response_api$fetch_response(
      query = "query",
      variables = list(),
      connection = connection,
      return_default = NA_character_,
      field = NA_character_
    ),
    error = identity
  )

  testthat::expect_s3_class(error, "stashapi_graphql_error")
  testthat::expect_match(conditionMessage(error), "invalid query")
})

testthat::test_that("object responses combine all pages and retain metadata", {
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

  result <- response_api$execute_query(
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

testthat::test_that("response cleaning normalizes empty nested values", {
  input <- list(
    id = 42,
    empty = list(),
    missing = NULL,
    nested = list(name = "example")
  )

  result <- response_api$clean_response_data(input)

  testthat::expect_true(tibble::is_tibble(result))
  testthat::expect_identical(result$id, 42)
  testthat::expect_true(is.na(result$empty))
  testthat::expect_true(is.na(result$missing))
  testthat::expect_identical(result$nested[[1]], "example")
})
