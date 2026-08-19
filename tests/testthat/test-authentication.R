testthat::test_that("connection values resolve explicit, file, then environment", {
  credentials_file <- tempfile()
  on.exit(unlink(credentials_file), add = TRUE)
  writeLines(c("http://file/graphql", "file-key"), credentials_file)

  old_url <- Sys.getenv("STASH_URL", unset = NA_character_)
  old_key <- Sys.getenv("STASH_API_KEY", unset = NA_character_)
  on.exit({
    if (is.na(old_url)) Sys.unsetenv("STASH_URL") else Sys.setenv(STASH_URL = old_url)
    if (is.na(old_key)) Sys.unsetenv("STASH_API_KEY") else Sys.setenv(STASH_API_KEY = old_key)
  }, add = TRUE)
  Sys.setenv(STASH_URL = "http://environment/graphql", STASH_API_KEY = "environment-key")

  file_values <- stashapi:::read_credentials_file(credentials_file)
  testthat::expect_identical(
    stashapi:::first_connection_value("http://explicit/graphql", file_values$url, Sys.getenv("STASH_URL")),
    "http://explicit/graphql"
  )
  testthat::expect_identical(
    stashapi:::first_connection_value(NULL, file_values$api_key, Sys.getenv("STASH_API_KEY")),
    "file-key"
  )
  testthat::expect_identical(
    stashapi:::first_connection_value(NULL, NULL, Sys.getenv("STASH_URL")),
    "http://environment/graphql"
  )
})

testthat::test_that("TLS options support secure, insecure, and custom CA connections", {
  testthat::expect_identical(
    stashapi:::build_tls_options(TRUE),
    list(ssl_verifypeer = TRUE, ssl_verifyhost = 2)
  )
  testthat::expect_identical(
    stashapi:::build_tls_options(FALSE),
    list(ssl_verifypeer = FALSE, ssl_verifyhost = 0)
  )

  ca_file <- tempfile(fileext = ".pem")
  on.exit(unlink(ca_file), add = TRUE)
  file.create(ca_file)
  testthat::expect_identical(
    stashapi:::build_tls_options(TRUE, ca_file),
    list(ssl_verifypeer = TRUE, ssl_verifyhost = 2, cainfo = ca_file)
  )
})

testthat::test_that("connection adapter forwards configured curl options", {
  observed <- NULL
  client <- list(exec = function(query, variables, ...) {
    observed <<- list(query = query, variables = variables, options = list(...))
    "ok"
  })
  connection <- stashapi:::new_stash_connection(
    client,
    list(ssl_verifypeer = FALSE, ssl_verifyhost = 0)
  )

  result <- connection$exec("query", list(id = 1L))

  testthat::expect_identical(result, "ok")
  testthat::expect_identical(observed$query, "query")
  testthat::expect_identical(observed$variables, list(id = 1L))
  testthat::expect_identical(
    observed$options,
    list(ssl_verifypeer = FALSE, ssl_verifyhost = 0)
  )
})

testthat::test_that("disconnect removes the active connection", {
  stashapi::stash_disconnect()
  testthat::expect_false(stashapi::is_stash_connected())
})

testthat::test_that("authentication exports use the current API names", {
  exports <- getNamespaceExports("stashapi")
  testthat::expect_true("is_stash_connected" %in% exports)
  testthat::expect_false("hasConnection" %in% exports)
  testthat::expect_false("setStashCredentials" %in% exports)
})

testthat::test_that("missing connections auto-load the default credentials file", {
  old_directory <- getwd()
  directory <- tempfile()
  dir.create(directory)
  on.exit(setwd(old_directory), add = TRUE)
  setwd(directory)
  writeLines(c("http://localhost:9999/graphql", "test-key"), ".stash_credentials")
  stashapi::stash_disconnect()

  connection <- stashapi:::get_stash_connection()

  testthat::expect_s3_class(connection, "stashapi_connection")
  stashapi::stash_disconnect()
})

testthat::test_that("the default credentials file is optional but explicit files are required", {
  testthat::expect_equal(
    stashapi:::read_credentials_file(tempfile(), optional = TRUE),
    list(url = NULL, api_key = NULL)
  )
  testthat::expect_error(
    stashapi:::read_credentials_file(tempfile()),
    "Credentials file does not exist"
  )
})
