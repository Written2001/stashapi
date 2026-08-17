#' Build a GraphQL criterion.
#'
#' Criterion helpers return ordinary named lists that can be passed directly to
#' generated Stash API functions.
#'
#' @param value Criterion value. Omit it for unary modifiers such as `IS_NULL`.
#' @param modifier GraphQL criterion modifier.
#' @param value2 Optional second value for range criteria.
#' @param depth Optional hierarchy depth. `-1` means unlimited depth.
#' @param excludes Optional IDs excluded while traversing a hierarchy.
#' @return A named list containing only the supplied GraphQL criterion fields.
#' @details Criterion helpers return ordinary named lists. Use them as values
#'   inside a typed filter, for example `scene_filter(tags = includes(182))`.
#' Build an EQUALS criterion.
#'
#' @param value Criterion value.
#' @export
#' @examples
#' equals("4k")
#' includes(182, depth = -1)
#' not_null()
gql_criterion <- function(
  value = NULL,
  modifier,
  value2 = NULL,
  depth = NULL,
  excludes = NULL
) {
  result <- list()
  if (!is.null(value)) result$value <- value
  if (!is.null(value2)) result$value2 <- value2
  result$modifier <- modifier
  if (!is.null(depth)) result$depth <- depth
  if (!is.null(excludes)) result$excludes <- excludes
  result
}

#' Build an EQUALS criterion.
#'
#' @param value Criterion value.
#' @export
#' @examples
#' equals("4k")
equals <- function(value) gql_criterion(value, "EQUALS")

#' Build an INCLUDES criterion.
#'
#' @param value Criterion value.
#' @param depth Optional hierarchy depth. `-1` means unlimited depth.
#' @param excludes Optional IDs to exclude.
#' @export
#' @examples
#' includes(182, depth = -1)
includes <- function(value, depth = NULL, excludes = NULL) {
  gql_criterion(value, "INCLUDES", depth = depth, excludes = excludes)
}

#' Build an INCLUDES_ALL criterion.
#'
#' @param value Criterion values.
#' @param depth Optional hierarchy depth. `-1` means unlimited depth.
#' @param excludes Optional IDs to exclude.
#' @export
#' @examples
#' includes_all(c(84, 85))
includes_all <- function(value, depth = NULL, excludes = NULL) {
  gql_criterion(value, "INCLUDES_ALL", depth = depth, excludes = excludes)
}

#' Build an IS_NULL criterion.
#'
#' @param value Boolean null criterion value.
#' @export
#' @examples
#' is_null()
is_null <- function(value = TRUE) gql_criterion(value, "IS_NULL")

#' Build a NOT_NULL criterion.
#'
#' @param value Optional criterion value.
#' @export
#' @examples
#' not_null()
not_null <- function(value = NULL) gql_criterion(value, "NOT_NULL")

#' Build an EXCLUDES criterion.
#'
#' @param value IDs or values to exclude.
#' @param depth Optional hierarchy depth. `-1` means unlimited depth.
#' @export
#' @examples
#' excludes(182, depth = -1)
excludes <- function(value, depth = NULL) {
  gql_criterion(value, "EXCLUDES", depth = depth)
}

#' Build a NOT_EQUALS criterion.
#'
#' @param value Criterion value.
#' @export
#' @examples
#' not_equals("4k")
not_equals <- function(value) gql_criterion(value, "NOT_EQUALS")

#' Build a BETWEEN criterion.
#'
#' @param value Lower or first criterion value.
#' @param value2 Upper or second criterion value.
#' @export
#' @examples
#' between(1, 10)
between <- function(value, value2) {
  list(value = value, modifier = "BETWEEN", value2 = value2)
}

#' Build a greater-than criterion.
#'
#' The helper name matches the GraphQL schema modifier.
#'
#' @param value Criterion value.
#' @export
#' @examples
#' greater_than("FULL_HD")
greater_than <- function(value) gql_criterion(value, "GREATER_THAN")

#' Build a less-than criterion.
#'
#' @param value Criterion value.
#' @export
#' @examples
#' less_than(720)
less_than <- function(value) gql_criterion(value, "LESS_THAN")

#' Build a regular-expression match criterion.
#'
#' @param value Regular-expression pattern.
#' @export
#' @examples
#' matches_regex("^4k")
matches_regex <- function(value) gql_criterion(value, "MATCHES_REGEX")

#' Build a negated regular-expression match criterion.
#'
#' @param value Regular-expression pattern.
#' @export
#' @examples
#' not_matches_regex("sample")
not_matches_regex <- function(value) gql_criterion(value, "NOT_MATCHES_REGEX")

validate_input_fields <- function(values, allowed_fields, type_name, strict = TRUE) {
  unknown_fields <- setdiff(names(values), allowed_fields)
  if (isTRUE(strict) && length(unknown_fields) > 0L) {
    stop("unknown fields for ", type_name, ": ", paste(unknown_fields, collapse = ", "), call. = FALSE)
  }
  values
}

#' @export
scene_filter <- function(..., .strict = TRUE) {
  validate_input_fields(
    list(...),
    c(
      "AND", "OR", "NOT", "id", "title", "code", "details", "director",
      "oshash", "checksum", "phash", "phash_distance", "path", "file_count",
      "rating100", "organized", "o_counter", "duplicated", "resolution",
      "orientation", "framerate", "bitrate", "video_codec", "audio_codec",
      "duration", "has_markers", "is_missing", "studios", "movies", "groups",
      "galleries", "tags", "tag_count", "performer_tags", "performer_favorite",
      "performer_age", "performers", "performer_count", "stash_id_endpoint",
      "stash_ids_endpoint", "stash_id_count", "url", "interactive",
      "interactive_speed", "captions", "resume_time", "play_count", "play_duration",
      "last_played_at", "date", "created_at", "updated_at", "galleries_filter",
      "performers_filter", "studios_filter", "tags_filter", "movies_filter",
      "groups_filter", "markers_filter", "files_filter", "custom_fields"
    ),
    "SceneFilterType",
    .strict
  )
}

#' @export
tag_filter <- function(..., .strict = TRUE) {
  validate_input_fields(
    list(...),
    c(
      "AND", "OR", "NOT", "name", "sort_name", "aliases", "favorite", "description",
      "is_missing", "scene_count", "image_count", "gallery_count", "performer_count",
      "studio_count", "movie_count", "group_count", "marker_count", "parents", "children",
      "parent_count", "child_count", "ignore_auto_tag", "stash_id_endpoint",
      "stash_ids_endpoint", "scenes_filter", "images_filter", "galleries_filter",
      "groups_filter", "performers_filter", "studios_filter", "markers_filter",
      "created_at", "updated_at", "custom_fields"
    ),
    "TagFilterType",
    .strict
  )
}

#' @export
performer_filter <- function(..., .strict = TRUE) {
  validate_input_fields(
    list(...),
    c(
      "AND", "OR", "NOT", "name", "disambiguation", "details", "filter_favorites",
      "birth_year", "age", "ethnicity", "country", "eye_color", "height_cm",
      "measurements", "fake_tits", "penis_length", "circumcised", "career_length",
      "career_start", "career_end", "tattoos", "piercings", "aliases", "gender",
      "is_missing", "tags", "tag_count", "scene_count", "marker_count", "image_count",
      "gallery_count", "play_count", "o_counter", "stash_id_endpoint", "stash_ids_endpoint",
      "rating100", "url", "hair_color", "weight", "death_year", "death_date", "studios",
      "groups", "performers", "ignore_auto_tag", "birthdate", "scenes_filter",
      "images_filter", "galleries_filter", "tags_filter", "markers_filter", "created_at",
      "updated_at", "custom_fields"
    ),
    "PerformerFilterType",
    .strict
  )
}

#' @export
find_filter <- function(..., .strict = TRUE) {
  validate_input_fields(list(...), c("q", "page", "per_page", "sort", "direction"), "FindFilterType", .strict)
}

#' Build a Stash ID criterion.
#'
#' @param endpoint Stash endpoint URL.
#' @param stash_id Endpoint-specific Stash ID.
#' @param modifier GraphQL criterion modifier.
#' @return A named Stash ID criterion list.
#' @details The returned list contains `endpoint`, `stash_id`, and `modifier`.
#' @examples
#' stash_id("https://stashdb.org", "abc123")
#' @export
stash_id <- function(endpoint, stash_id, modifier = "EQUALS") {
  list(endpoint = endpoint, stash_id = stash_id, modifier = modifier)
}

#' Build a multiple Stash ID criterion.
#'
#' @param endpoint Stash endpoint URL.
#' @param stash_ids Endpoint-specific Stash IDs.
#' @param modifier GraphQL criterion modifier.
#' @return A named multiple Stash ID criterion list.
#' @details The returned list contains `endpoint`, `stash_ids`, and `modifier`.
#' @examples
#' stash_ids("https://stashdb.org", c("abc123", "def456"))
#' @export
stash_ids <- function(endpoint, stash_ids, modifier = "EQUALS") {
  list(endpoint = endpoint, stash_ids = stash_ids, modifier = modifier)
}

#' @export
image_filter <- function(..., .strict = TRUE) {
  validate_input_fields(
    list(...),
    c(
      "AND", "OR", "NOT", "title", "details", "id", "checksum", "phash_distance",
      "path", "file_count", "rating100", "date", "url", "organized", "o_counter",
      "resolution", "orientation", "is_missing", "studios", "tags", "tag_count",
      "performer_tags", "performers", "performer_count", "performer_favorite",
      "performer_age", "galleries", "created_at", "updated_at", "code", "photographer",
      "galleries_filter", "performers_filter", "studios_filter", "tags_filter", "files_filter",
      "custom_fields"
    ),
    "ImageFilterType",
    .strict
  )
}

#' @export
studio_filter <- function(..., .strict = TRUE) {
  values <- list(...)
  if ("stash_id" %in% names(values)) {
    if ("stash_id_endpoint" %in% names(values)) {
      stop("use either stash_id or stash_id_endpoint, not both", call. = FALSE)
    }
    values$stash_id_endpoint <- values$stash_id
    values$stash_id <- NULL
  }
  validate_input_fields(
    values,
    c(
      "AND", "OR", "NOT", "name", "details", "parents", "stash_id_endpoint",
      "stash_ids_endpoint", "tags", "is_missing", "rating100", "favorite", "scene_count",
      "image_count", "gallery_count", "group_count", "tag_count", "url", "aliases",
      "child_count", "ignore_auto_tag", "organized", "scenes_filter", "images_filter",
      "galleries_filter", "groups_filter", "created_at", "updated_at", "custom_fields"
    ),
    "StudioFilterType",
    .strict
  )
}

#' @export
gallery_filter <- function(..., .strict = TRUE) {
  validate_input_fields(
    list(...),
    c(
      "AND", "OR", "NOT", "id", "title", "details", "checksum", "path", "file_count",
      "is_missing", "is_zip", "rating100", "organized", "average_resolution", "has_chapters",
      "scenes", "studios", "tags", "tag_count", "performer_tags", "performers", "performer_count",
      "performer_favorite", "performer_age", "image_count", "url", "date", "created_at", "updated_at",
      "code", "photographer", "scenes_filter", "images_filter", "performers_filter", "studios_filter",
      "tags_filter", "files_filter", "folders_filter", "parent_folder", "custom_fields"
    ),
    "GalleryFilterType",
    .strict
  )
}

#' @export
group_filter <- function(..., .strict = TRUE) {
  validate_input_fields(
    list(...),
    c(
      "AND", "OR", "NOT", "name", "director", "synopsis", "duration", "rating100", "studios",
      "is_missing", "url", "performers", "tags", "tag_count", "date", "created_at", "updated_at",
      "o_counter", "containing_groups", "sub_groups", "containing_group_count", "sub_group_count",
      "scene_count", "scenes_filter", "studios_filter", "custom_fields"
    ),
    "GroupFilterType",
    .strict
  )
}

#' @export
marker_filter <- function(..., .strict = TRUE) {
  validate_input_fields(
    list(...),
    c(
      "tags", "scene_tags", "performers", "scenes", "duration", "created_at", "updated_at",
      "scene_date", "scene_created_at", "scene_updated_at", "scene_filter"
    ),
    "SceneMarkerFilterType",
    .strict
  )
}
