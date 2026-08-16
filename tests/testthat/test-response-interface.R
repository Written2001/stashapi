response_api <- new.env(parent = globalenv())
sys.source(
  file.path(testthat::test_path("..", ".."), "R", "executeQuery.R"),
  envir = response_api
)

testthat::test_that("default response mode preserves selected data", {
  connection <- list(
    exec = function(query, variables) {
      '{"data":{"find":{"count":2,"items":[{"id":1}]}}}'
    }
  )

  result <- response_api$executeQuery(
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

  result <- response_api$executeQuery(
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

  result <- response_api$executeQuery(
    query = "query",
    variables = list(),
    connection = connection,
    return_default = "find",
    field = NA_character_,
    response = "raw"
  )

  testthat::expect_identical(result$data$find$count, 2L)
  raw_field_error <- tryCatch(
    response_api$executeQuery(
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
    response_api$fetch(
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
