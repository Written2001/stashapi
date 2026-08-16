package_root <- normalizePath(testthat::test_path("..", ".."), mustWork = TRUE)
type_path <- file.path(package_root, "tools", "schema_types.R")

schema_types <- new.env(parent = globalenv())
sys.source(type_path, envir = schema_types)

make_type_ref <- function(kinds, names) {
  type <- data.frame(kind = kinds[length(kinds)], name = names[length(names)])
  if (length(kinds) == 1) return(type)

  for (index in rev(seq_len(length(kinds) - 1))) {
    parent <- data.frame(kind = kinds[index], name = names[index])
    parent$ofType <- type
    type <- parent
  }

  type
}

testthat::test_that("type references preserve GraphQL wrapper order", {
  cases <- list(
    scalar = list(kinds = c("SCALAR"), names = c("Int"), expected = "Int"),
    non_null = list(kinds = c("NON_NULL", "SCALAR"), names = c(NA, "Int"), expected = "Int!"),
    list_type = list(kinds = c("LIST", "SCALAR"), names = c(NA, "Int"), expected = "[Int]"),
    list_item_required = list(kinds = c("LIST", "NON_NULL", "SCALAR"), names = c(NA, NA, "Int"), expected = "[Int!]"),
    list_required = list(kinds = c("NON_NULL", "LIST", "SCALAR"), names = c(NA, NA, "Int"), expected = "[Int]!"),
    list_and_item_required = list(
      kinds = c("NON_NULL", "LIST", "NON_NULL", "SCALAR"),
      names = c(NA, NA, NA, "Int"),
      expected = "[Int!]!"
    )
  )

  for (case in cases) {
    type_ref <- schema_types$normalize_type_ref(make_type_ref(case$kinds, case$names))
    testthat::expect_identical(schema_types$type_ref_to_string(type_ref), case$expected)
    testthat::expect_identical(schema_types$type_ref_named_type(type_ref), "Int")
  }
})

testthat::test_that("type reference predicates inspect nested wrappers", {
  type_ref <- schema_types$normalize_type_ref(
    make_type_ref(
      kinds = c("NON_NULL", "LIST", "NON_NULL", "INPUT_OBJECT"),
      names = c(NA, NA, NA, "SceneFilterType")
    )
  )

  testthat::expect_true(schema_types$type_ref_contains(type_ref, "LIST"))
  testthat::expect_true(schema_types$type_ref_contains(type_ref, "NON_NULL"))
  testthat::expect_true(schema_types$type_ref_contains(type_ref, "INPUT_OBJECT"))
  testthat::expect_false(schema_types$type_ref_contains(type_ref, "SCALAR"))
})

testthat::test_that("invalid type references fail clearly", {
  testthat::expect_error(
    schema_types$normalize_type_ref(data.frame(kind = "LIST", name = NA_character_)),
    "no ofType"
  )
  testthat::expect_error(
    schema_types$normalize_type_ref(data.frame(kind = NA_character_, name = NA_character_)),
    "no kind"
  )
  testthat::expect_error(
    schema_types$type_ref_to_string(list(kind = "SCALAR")),
    "no name"
  )
})

testthat::test_that("type reference depth is bounded", {
  type_ref <- make_type_ref(
    kinds = c(rep("LIST", 4), "SCALAR"),
    names = c(rep(NA_character_, 4), "Int")
  )

  testthat::expect_error(
    schema_types$normalize_type_ref(type_ref, max_depth = 3L),
    "maximum depth"
  )
})
