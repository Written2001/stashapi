package_root <- normalizePath(testthat::test_path("..", ".."), mustWork = TRUE)

schema_fixture_path <- function() {
  file.path(package_root, "inst", "extdata", "schema.json")
}

read_schema_fixture <- function() {
  jsonlite::fromJSON(schema_fixture_path(), flatten = FALSE)$data$`__schema`$types
}

utils::globalVariables("read_schema_fixture")
