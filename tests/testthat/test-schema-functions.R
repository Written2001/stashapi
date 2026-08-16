package_root <- normalizePath(testthat::test_path("..", ".."), mustWork = TRUE)
generator_path <- file.path(package_root, "tools", "build_schema.R")

previous_directory <- setwd(package_root)
on.exit(setwd(previous_directory), add = TRUE)

schema_functions <- new.env(parent = globalenv())
sys.source(generator_path, envir = schema_functions)

make_type <- function(kinds, names) {
  type <- data.frame(kind = kinds[length(kinds)], name = names[length(names)])
  if (length(kinds) == 1) return(type)

  for (index in rev(seq_len(length(kinds) - 1))) {
    parent <- data.frame(kind = kinds[index], name = names[index])
    parent$ofType <- type
    type <- parent
  }

  type
}

testthat::test_that("flatten_field_type preserves the complete type chain", {
  type <- make_type(
    kinds = c("NON_NULL", "LIST", "NON_NULL", "SCALAR"),
    names = c(NA_character_, NA_character_, NA_character_, "Int")
  )

  result <- schema_functions$flatten_field_type(type)[[1]]
  testthat::expect_equal(result$kinds, c("NON_NULL", "LIST", "NON_NULL", "SCALAR"))
  testthat::expect_equal(result$name, c(NA, NA, NA, "Int"))
})

testthat::test_that("flatten_args derives names, types, and nullability", {
  args <- data.frame(
    name = c("scene_ids", "filter"),
    description = c(NA_character_, NA_character_),
    type = I(list(
      make_type(c("LIST", "NON_NULL", "SCALAR"), c(NA_character_, NA_character_, "Int")),
      make_type("INPUT_OBJECT", "FindFilterType")
    )),
    defaultValue = c(NA_character_, NA_character_),
    stringsAsFactors = FALSE
  )

  result <- schema_functions$flatten_args(list(args))[[1]]
  testthat::expect_equal(result$san_name, c("sceneids", "filter"))
  testthat::expect_equal(result$arg_type, c("Int", "FindFilterType"))
  testthat::expect_equal(result$is_list, c(TRUE, FALSE))
  testthat::expect_equal(result$is_input_object, c(FALSE, TRUE))
  testthat::expect_equal(result$is_non_null, c(TRUE, FALSE))
})

testthat::test_that("flatten_args handles empty argument definitions", {
  result <- schema_functions$flatten_args(list(data.frame()))[[1]]
  testthat::expect_identical(result, tibble::tibble())
})

testthat::test_that("extract_fields classifies return types and aliases", {
  fields <- data.frame(
    name = c("scene", "scraped_tag", "title"),
    description = c(NA_character_, NA_character_, NA_character_),
    args = I(list(data.frame(), data.frame(), data.frame())),
    type = I(list(
      make_type("OBJECT", "Scene"),
      make_type("SCALAR", "ScrapedTag"),
      make_type("SCALAR", "String")
    )),
    isDeprecated = c(FALSE, FALSE, FALSE),
    deprecationReason = I(list(NULL, NULL, NULL)),
    stringsAsFactors = FALSE
  )
  fields$object_name <- "Example"

  result <- schema_functions$extract_fields(list(fields))[[1]]
  testthat::expect_equal(result$type_name, c("Scene", "ScrapedTag", "String"))
  testthat::expect_equal(result$is_object, c(TRUE, FALSE, FALSE))
  testthat::expect_equal(result$use_alias, c(FALSE, TRUE, TRUE))
  testthat::expect_equal(result$alias, c("Example_scene", "Example_scraped_tag", "Example_title"))
})

testthat::test_that("extract_return_field identifies paginated result fields", {
  fields <- data.frame(
    object_name = c("FindScenesResultType", "FindScenesResultType"),
    is_object = c(FALSE, TRUE),
    name = c("count", "scenes"),
    stringsAsFactors = FALSE
  )

  result <- schema_functions$extract_return_field(list(fields))
  testthat::expect_identical(result, "scenes")
})

testthat::test_that("extract_possibleTypes creates a union fragment", {
  possible_types <- data.frame(
    name = c("ScrapedScene", "ScrapedImage"),
    ofType = c(NA_character_, NA_character_),
    object_name = c("ScrapedContent", "ScrapedContent"),
    stringsAsFactors = FALSE
  )

  result <- schema_functions$extract_possibleTypes(list(possible_types))
  testthat::expect_identical(
    result,
    "fragment ScrapedContent on ScrapedContent { ...ScrapedScene ...ScrapedImage }"
  )
})

testthat::test_that("parse_variables renders GraphQL variable and argument strings", {
  args <- data.frame(
    name = c("scene_ids", "filter"),
    san_name = c("sceneids", "filter"),
    arg_type = c("Int", "FindFilterType"),
    is_list = c(TRUE, FALSE),
    is_non_null = c(TRUE, FALSE),
    is_multiple_non_null = c(FALSE, FALSE),
    stringsAsFactors = FALSE
  )

  result <- schema_functions$parse_variables(list(args))[[1]]
  testthat::expect_equal(result$variables_string, "($sceneids: [Int!] $filter: FindFilterType)")
  testthat::expect_equal(result$arguments_string, "(scene_ids: $sceneids filter: $filter)")
})

testthat::test_that("fragment builders omit deprecated fields and preserve overrides", {
  fields <- data.frame(
    object_name = c("Example", "Example", "Example"),
    name = c("title", "sceneStreams", "deprecated"),
    type_name = c("String", "String", "String"),
    is_object = c(FALSE, FALSE, FALSE),
    is_union = c(FALSE, FALSE, FALSE),
    use_alias = c(FALSE, FALSE, FALSE),
    alias = c("", "", ""),
    isDeprecated = c(FALSE, FALSE, TRUE),
    stringsAsFactors = FALSE
  )

  result <- schema_functions$build_fragments(list(fields))[[1]]
  testthat::expect_equal(result, "fragment Example on Example { title }")
})

testthat::test_that("fragment combination follows dependency order", {
  fragments <- tibble::tibble(
    name = c("Root", "Child", "Leaf"),
    fragment_string = c("fragment Root", "fragment Child", "fragment Leaf")
  )

  result <- schema_functions$combine_fragments(
    name = "Root",
    dependent_fragments = c("Child", "Leaf"),
    fragments_df = fragments
  )
  testthat::expect_identical(result, "  fragment Root\n  fragment Child\n  fragment Leaf")
})
