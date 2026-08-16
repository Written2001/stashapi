testthat::test_that("public filter helpers return legacy-compatible lists", {
  testthat::skip_if_not(
    requireNamespace("stashapi", quietly = TRUE),
    "The installed package namespace is unavailable."
  )

  testthat::expect_identical(
    stashapi::scene_filter(tags = stashapi::includes(182)),
    list(tags = list(value = 182, modifier = "INCLUDES"))
  )
  testthat::expect_identical(
    stashapi::tag_filter(name = stashapi::equals("4k")),
    list(name = list(value = "4k", modifier = "EQUALS"))
  )
  testthat::expect_identical(
    stashapi::find_filter(per_page = 250, page = 2),
    list(per_page = 250, page = 2)
  )
  testthat::expect_identical(stashapi::not_null(), list(modifier = "NOT_NULL"))
  testthat::expect_identical(stashapi::excludes(182, depth = -1), list(value = 182, modifier = "EXCLUDES", depth = -1))
  testthat::expect_identical(stashapi::not_equals("4k"), list(value = "4k", modifier = "NOT_EQUALS"))
  testthat::expect_identical(stashapi::between(1, 10), list(value = 1, modifier = "BETWEEN", value2 = 10))
  testthat::expect_identical(stashapi::greater_than(3), list(value = 3, modifier = "GREATER_THAN"))
  testthat::expect_identical(stashapi::less_than(10), list(value = 10, modifier = "LESS_THAN"))
  testthat::expect_identical(stashapi::matches_regex("^path/"), list(value = "^path/", modifier = "MATCHES_REGEX"))
  testthat::expect_identical(stashapi::not_matches_regex("tmp$"), list(value = "tmp$", modifier = "NOT_MATCHES_REGEX"))
  testthat::expect_identical(
    stashapi::image_filter(resolution = stashapi::equals("FULL_HD")),
    list(
      resolution = list(value = "FULL_HD", modifier = "EQUALS")
    )
  )
  testthat::expect_identical(
    stashapi::studio_filter(stash_id = stashapi::stash_id("https://stashdb.org", "abc123")),
    list(
      stash_id_endpoint = list(endpoint = "https://stashdb.org", stash_id = "abc123", modifier = "EQUALS")
    )
  )
  testthat::expect_identical(
    stashapi::gallery_filter(title = stashapi::equals("Album")),
    list(title = list(value = "Album", modifier = "EQUALS"))
  )
  testthat::expect_identical(
    stashapi::group_filter(tags = stashapi::includes(182)),
    list(tags = list(value = 182, modifier = "INCLUDES"))
  )
  testthat::expect_identical(
    stashapi::marker_filter(tags = stashapi::includes(182)),
    list(tags = list(value = 182, modifier = "INCLUDES"))
  )
  testthat::expect_identical(
    stashapi::includes(182, depth = -1, excludes = c(183, 184)),
    list(value = 182, modifier = "INCLUDES", depth = -1, excludes = c(183, 184))
  )
})

testthat::test_that("public filter helpers reject unknown fields", {
  testthat::skip_if_not(
    requireNamespace("stashapi", quietly = TRUE),
    "The installed package namespace is unavailable."
  )

  testthat::expect_error(stashapi::scene_filter(not_a_field = 1), "unknown fields")
})
