stash_schema_patterns <- function() {
  c(
    "graphql/schema/types/*.graphql",
    "graphql/schema/*.graphql"
  )
}

resolve_stash_schema_files <- function(source_root, patterns = stash_schema_patterns()) {
  if (!is.character(source_root) || length(source_root) != 1L || !nzchar(source_root)) {
    stop("source_root must be a non-empty path", call. = FALSE)
  }
  if (!dir.exists(source_root)) {
    stop("source_root does not exist", call. = FALSE)
  }
  if (!is.character(patterns) || length(patterns) == 0L || any(!nzchar(patterns))) {
    stop("patterns must contain at least one non-empty path pattern", call. = FALSE)
  }

  source_root <- normalizePath(source_root, mustWork = TRUE)
  files <- unique(unlist(lapply(patterns, function(pattern) {
    Sys.glob(file.path(source_root, pattern))
  }), use.names = FALSE))
  files <- files[file.info(files)$isdir %in% FALSE]
  relative_files <- sort(unique(sub(
    paste0("^", gsub("/", "[/\\\\]", source_root), "[/\\\\]?"),
    "",
    normalizePath(files, winslash = "/", mustWork = TRUE)
  )))

  if (length(relative_files) == 0L) {
    stop("no Stash GraphQL schema files matched the configured patterns", call. = FALSE)
  }

  relative_files
}

read_stash_schema_source <- function(source_root, ref = NULL, patterns = stash_schema_patterns()) {
  files <- resolve_stash_schema_files(source_root, patterns)
  absolute_files <- file.path(normalizePath(source_root, mustWork = TRUE), files)

  list(
    source = "https://github.com/stashapp/stash",
    ref = ref,
    root = normalizePath(source_root, mustWork = TRUE),
    patterns = patterns,
    files = files,
    contents = lapply(absolute_files, readLines, warn = FALSE),
    fingerprints = unname(tools::md5sum(absolute_files))
  )
}