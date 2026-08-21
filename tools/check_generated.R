source("tools/generate_wrappers.R")

schema_source_root <- Sys.getenv("STASH_SOURCE_ROOT", unset = "")
if (!nzchar(schema_source_root) || !dir.exists(schema_source_root)) {
  stop("STASH_SOURCE_ROOT must identify a pinned SDL checkout", call. = FALSE)
}

check_schema_snapshot <- function() {
  schema_output <- tempfile(fileext = ".json")
  provenance_output <- tempfile(fileext = ".json")
  on.exit(unlink(c(schema_output, provenance_output)), add = TRUE)
  package_version <- sub(
    "^Version: *",
    "",
    grep("^Version:", readLines("DESCRIPTION"), value = TRUE)
  )
  status <- system2(
    Sys.getenv("PYTHON", unset = "python3"),
    c(
      "tools/schema_from_sdl.py",
      "--source-root", normalizePath(schema_source_root, winslash = "/", mustWork = TRUE),
      "--output", schema_output,
      "--provenance-output", provenance_output,
      "--ref", Sys.getenv("STASH_SCHEMA_TAG", unset = ""),
      "--commit", Sys.getenv("STASH_SCHEMA_COMMIT", unset = ""),
      "--package-version", package_version,
      "--artifact", "inst/extdata/schema.json"
    )
  )
  if (!identical(status, 0L)) stop("SDL snapshot generation failed", call. = FALSE)
  if (!identical(readLines(schema_output, warn = FALSE), readLines("inst/extdata/schema.json", warn = FALSE))) {
    stop("Generated schema snapshot differs from inst/extdata/schema.json", call. = FALSE)
  }
  if (!identical(readLines(provenance_output, warn = FALSE), readLines("inst/extdata/schema.provenance.json", warn = FALSE))) {
    stop("Generated schema provenance differs from inst/extdata/schema.provenance.json", call. = FALSE)
  }
}

check_schema_snapshot()
cat("Schema snapshot and provenance match the pinned SDL\n")

check_generated <- function() {
  output_path <- tempfile(fileext = ".R")
  on.exit(unlink(output_path), add = TRUE)
  generator <- get("build_wrappers", mode = "function")
  writeLines(generator(source_root = schema_source_root), output_path)

  expected <- readLines("R/stashapi_functions.R", warn = FALSE)
  actual <- readLines(output_path, warn = FALSE)

  if (!identical(actual, expected)) {
    stop("Generated wrappers differ from R/stashapi_functions.R", call. = FALSE)
  }
}

check_generated()
cat("Generated wrappers match R/stashapi_functions.R\n")

check_generated_input_docs <- function() {
  generator_environment <- new.env(parent = globalenv())
  sys.source("tools/generate_input_helper_docs.R", envir = generator_environment)
  output_dir <- tempfile("stashapi-input-docs-")
  dir.create(output_dir)
  on.exit(unlink(output_dir, recursive = TRUE), add = TRUE)
  generator_environment$generate_input_helper_docs(
    schema_path = NULL,
    output_dir = output_dir,
    source_root = schema_source_root
  )

  for (type_name in names(generator_environment$curated_types)) {
    builder <- generator_environment$build_input_builder_ir(
      generator_environment$normalize_schema_registry(
        generator_environment$read_schema_types(source_root = schema_source_root)
      )
    )[[type_name]]
    expected_path <- file.path("man", paste0(
      generator_environment$helper_name(type_name, builder), ".Rd"
    ))
    actual_path <- file.path(output_dir, basename(expected_path))
    if (!identical(readLines(actual_path, warn = FALSE), readLines(expected_path, warn = FALSE))) {
      stop("Generated input documentation differs from ", expected_path, call. = FALSE)
    }
  }
}

check_generated_input_docs()
cat("Generated input documentation matches man/\n")
