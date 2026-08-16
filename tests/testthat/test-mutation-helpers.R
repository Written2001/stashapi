testthat::test_that("prepare_mutations preserves nested update modes", {
  source <- data.frame(id = 10, stringsAsFactors = FALSE)
  plan <- stashapi::prepare_mutations(
    source,
    function(row, index) {
      list(
        ids = row$id,
        performer_ids = list(ids = c("12", NA), mode = "ADD"),
        urls = list(values = c("https://example.test", NA), mode = "SET"),
        date = NA_character_
      )
    },
    operation = "bulkImageUpdate"
  )

  input <- plan$entries[[1]]$input
  testthat::expect_s3_class(plan, "stashapi_mutation_plan")
  testthat::expect_identical(input$ids, 10)
  testthat::expect_identical(input$performer_ids, list(ids = "12", mode = "ADD"))
  testthat::expect_identical(input$urls, list(values = "https://example.test", mode = "SET"))
  testthat::expect_identical(plan$entries[[1]]$target, 10)
  testthat::expect_true("date" %in% plan$entries[[1]]$omitted)
})

testthat::test_that("prepare_mutations creates one bulk request per source row", {
  source <- list(
    list(image_ids = c("1", "2"), performer_ids = "10"),
    list(image_ids = "3", performer_ids = character())
  )
  plan <- stashapi::prepare_mutations(source, function(row, index) {
    list(
      ids = row$image_ids,
      performer_ids = list(ids = row$performer_ids, mode = "ADD"),
      organized = TRUE
    )
  })

  testthat::expect_length(plan$entries, 2)
  testthat::expect_identical(plan$entries[[1]]$target, c("1", "2"))
  testthat::expect_identical(plan$entries[[2]]$input$performer_ids, list(ids = character(), mode = "ADD"))
})

testthat::test_that("execute_mutations dry-run makes no mutation calls", {
  plan <- stashapi::prepare_mutations(
    list(list(id = "1"), list(id = "2")),
    function(row, index) list(id = row$id, title = "planned")
  )
  calls <- 0L
  mutate <- function(input) calls <<- calls + 1L

  result <- stashapi::execute_mutations(plan, mutate, progress = FALSE)

  testthat::expect_s3_class(result, "stashapi_mutation_result")
  testthat::expect_identical(calls, 0L)
  testthat::expect_identical(vapply(result$results, `[[`, character(1), "status"), c("planned", "planned"))
})

testthat::test_that("mutation prints show compact summaries instead of inputs", {
  plan <- stashapi::prepare_mutations(
    list(list(id = "1213")),
    function(row, index) list(id = row$id, fake_tits = "Augmented"),
    operation = "performerUpdate"
  )
  preview <- stashapi::execute_mutations(plan, function(input) input, progress = FALSE)

  plan_output <- capture.output(print(plan))
  result_output <- capture.output(print(preview))

  testthat::expect_match(paste(plan_output, collapse = "\n"), "fields")
  testthat::expect_match(paste(result_output, collapse = "\n"), "planned")
  testthat::expect_match(paste(result_output, collapse = "\n"), "fake_tits")
  testthat::expect_false(any(grepl("Augmented", result_output, fixed = TRUE)))
})

testthat::test_that("execute_mutations records indexed successes and failures", {
  plan <- stashapi::prepare_mutations(
    list(list(id = "1"), list(id = "2"), list(id = "3")),
    function(row, index) list(id = row$id)
  )
  mutate <- function(input) {
    if (identical(input$id, "2")) stop("rejected")
    input$id
  }

  result <- stashapi::execute_mutations(
    plan,
    mutate,
    dry_run = FALSE,
    on_error = "continue",
    progress = FALSE
  )

  testthat::expect_identical(vapply(result$results, `[[`, integer(1), "index"), c(1L, 2L, 3L))
  testthat::expect_identical(
    vapply(result$results, `[[`, character(1), "status"),
    c("succeeded", "failed", "succeeded")
  )
  testthat::expect_match(result$results[[2]]$error$message, "rejected")
})

testthat::test_that("execute_mutations stop mode exposes the failed row", {
  plan <- stashapi::prepare_mutations(
    list(list(id = "1")),
    function(row, index) list(id = row$id)
  )
  error <- tryCatch(
    stashapi::execute_mutations(
      plan,
      function(input) stop("rejected"),
      dry_run = FALSE,
      progress = FALSE
    ),
    error = identity
  )

  testthat::expect_s3_class(error, "stashapi_mutation_error")
  testthat::expect_identical(error$index, 1L)
  testthat::expect_match(conditionMessage(error), "rejected")
})

testthat::test_that("mutation helpers reject invalid plans and builders", {
  testthat::expect_error(
    stashapi::prepare_mutations(list(list(id = "1")), function(row, index) list(NA)),
    "named list"
  )
  testthat::expect_error(
    stashapi::prepare_mutations(list(list(id = "1")), function(row, index) NULL),
    "named list"
  )
  testthat::expect_error(
    stashapi::prepare_mutations(list(list(id = "1")), function(row, index) list(id = NA), na = "error"),
    "NA"
  )
  testthat::expect_error(
    stashapi::prepare_mutations(list(list(id = "1")), function(row, index) list(id = NULL), null = "error"),
    "NULL"
  )
  testthat::expect_error(
    stashapi::prepare_mutations(list(list(id = "1")), function(row, index) list(id = list("1"))),
    "unnamed list"
  )
})
