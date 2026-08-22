read_schema_types <- function(schema_path = NULL, source_root = NULL, source_ref = NULL) {
  if (!xor(is.null(schema_path), is.null(source_root))) {
    stop("provide exactly one of schema_path or source_root", call. = FALSE)
  }

  if (!is.null(schema_path)) {
    if (!is.character(schema_path) || length(schema_path) != 1L || !file.exists(schema_path)) {
      stop("schema_path must identify an existing file", call. = FALSE)
    }
    return(jsonlite::fromJSON(schema_path, flatten = FALSE)$data$`__schema`$types)
  }

  if (!is.character(source_root) || length(source_root) != 1L || !dir.exists(source_root)) {
    stop("source_root must identify an existing directory", call. = FALSE)
  }

  python <- Sys.getenv("PYTHON", unset = "python3")
  script <- file.path("tools", "schema_from_sdl.py")
  if (!file.exists(script)) {
    stop("SDL parser script is missing: ", script, call. = FALSE)
  }

  output_path <- tempfile("stashapi-schema-", fileext = ".json")
  on.exit(unlink(output_path), add = TRUE)
  result <- system2(
    python,
    c(
      script,
      "--source-root", normalizePath(source_root, winslash = "/", mustWork = TRUE),
      "--output", output_path,
      if (is.null(source_ref)) character() else c("--ref", source_ref)
    ),
    stdout = TRUE,
    stderr = TRUE
  )
  status <- attr(result, "status")
  if (is.null(status)) status <- 0L
  if (!identical(status, 0L)) {
    stop("SDL parser failed: ", paste(result, collapse = "\n"), call. = FALSE)
  }

  jsonlite::fromJSON(output_path, flatten = FALSE)$data$`__schema`$types
}
