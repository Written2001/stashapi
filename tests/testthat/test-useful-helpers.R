testthat::test_that("wait_for_job returns a completed job after polling", {
  statuses <- c("RUNNING", "FINISHED")
  calls <- 0L
  delays <- numeric()
  find_job <- function(input) {
    calls <<- calls + 1L
    list(id = input$id, status = statuses[[calls]])
  }
  sleep <- function(seconds) delays <<- c(delays, seconds)

  result <- stashapi:::wait_for_job_impl(
    "job-1", 5, NULL, FALSE, find_job, sleep
  )

  testthat::expect_identical(result$status, "FINISHED")
  testthat::expect_identical(calls, 2L)
  testthat::expect_identical(delays, 5)
})

testthat::test_that("wait_for_job reports failed, unknown, and timed out jobs", {
  find_job <- function(input) list(id = input$id, status = "FAILED")
  testthat::expect_error(
    stashapi:::wait_for_job_impl("job-1", 0, NULL, FALSE, find_job, identity),
    "ended with status FAILED"
  )

  find_job <- function(input) list(id = input$id, status = "PAUSED")
  testthat::expect_error(
    stashapi:::wait_for_job_impl("job-1", 0, NULL, FALSE, find_job, identity),
    "unknown status: PAUSED"
  )

  find_job <- function(input) list(id = input$id, status = "RUNNING")
  testthat::expect_error(
    stashapi:::wait_for_job_impl("job-1", 0, 0, FALSE, find_job, identity),
    "Timed out waiting"
  )
})

testthat::test_that("named lookup helpers handle zero, one, and multiple matches", {
  observed <- NULL
  finder <- function(...) {
    observed <<- list(...)
    c("12", "13")
  }

  testthat::expect_error(
    stashapi:::resolve_named_id(
      "Example", "error", finder, list(name = equals("Example")), "studio"
    ),
    "Multiple studios"
  )
  testthat::expect_identical(
    stashapi:::resolve_named_id(
      "Example", "first", finder, list(name = equals("Example")), "studio"
    ),
    "12"
  )
  testthat::expect_identical(
    stashapi:::resolve_named_id(
      "Example", "all", finder, list(name = equals("Example")), "studio"
    ),
    c("12", "13")
  )
  testthat::expect_identical(observed$studiofilter, list(name = equals("Example")))
  testthat::expect_identical(observed$.field, c("studios", "id"))

  finder <- function(...) character()
  testthat::expect_error(
    stashapi:::resolve_named_id(
      "Missing", "error", finder, list(name = equals("Missing")), "tag"
    ),
    "No tag matched"
  )
})

testthat::test_that("helper inputs are validated", {
  testthat::expect_error(
    stashapi:::validate_wait_for_job_input("", 1, NULL, TRUE),
    "job_id"
  )
  testthat::expect_error(
    stashapi:::validate_wait_for_job_input("job-1", -1, NULL, TRUE),
    "check_interval"
  )
  testthat::expect_error(
    stashapi:::validate_wait_for_job_input("job-1", 1, -1, TRUE),
    "timeout"
  )
  testthat::expect_error(
    stashapi:::resolve_named_id("Example", "many", identity, list(), "tag"),
    "multiple must be"
  )
})
