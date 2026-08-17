testthat::test_that("clean_response_data normalizes empty nested values", {
  input <- list(
    id = 42,
    empty = list(),
    missing = NULL,
    nested = list(name = "example")
  )

  result <- stashapi:::clean_response_data(input)

  testthat::expect_true(tibble::is_tibble(result))
  testthat::expect_identical(result$id, 42)
  testthat::expect_true(is.na(result$empty))
  testthat::expect_true(is.na(result$missing))
  testthat::expect_identical(result$nested[[1]], "example")
})

testthat::test_that("fetch reports GraphQL errors from an offline fake connection", {
  connection <- list(
    exec = function(query, variables) {
      '{"errors":[{"message":"invalid query"}]}'
    }
  )

  testthat::expect_error(
    stashapi:::fetch_response(
      query = "query",
      variables = list(),
      connection = connection,
      return_default = NA_character_,
      field = NA_character_
    ),
    "invalid query"
  )
})

testthat::test_that("execute_query uses the fake connection without network access", {
  connection <- list(
    exec = function(query, variables) {
      '{"data":{"value":"ok"}}'
    }
  )

  result <- stashapi:::execute_query(
    query = "query",
    variables = list(),
    connection = connection,
    return_default = "value",
    field = NA_character_
  )

  testthat::expect_identical(result, "ok")
})
