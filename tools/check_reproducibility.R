source("tools/generate_wrappers.R")

schema_source_root <- Sys.getenv("STASH_SOURCE_ROOT", unset = "")
if (!nzchar(schema_source_root) || !dir.exists(schema_source_root)) {
  stop("STASH_SOURCE_ROOT must identify a pinned SDL checkout", call. = FALSE)
}

package_version <- sub(
  "^Version: *",
  "",
  grep("^Version:", readLines("DESCRIPTION"), value = TRUE)
)
schema_path <- tempfile(fileext = ".json")
provenance_path <- tempfile(fileext = ".json")
on.exit(unlink(c(schema_path, provenance_path)), add = TRUE)

status <- system2(
  Sys.getenv("PYTHON", unset = "python3"),
  c(
    "tools/schema_from_sdl.py",
    "--source-root", normalizePath(schema_source_root, winslash = "/", mustWork = TRUE),
    "--output", schema_path,
    "--provenance-output", provenance_path,
    "--ref", Sys.getenv("STASH_SCHEMA_TAG", unset = ""),
    "--commit", Sys.getenv("STASH_SCHEMA_COMMIT", unset = ""),
    "--package-version", package_version,
    "--artifact", "inst/extdata/schema.json"
  )
)
if (!identical(status, 0L)) stop("SDL snapshot generation failed", call. = FALSE)

compare_lines <- function(actual_path, expected_path, label) {
  if (!file.exists(expected_path)) stop("missing ", label, ": ", expected_path, call. = FALSE)
  if (!identical(readLines(actual_path, warn = FALSE), readLines(expected_path, warn = FALSE))) {
    stop(label, " differs from ", expected_path, call. = FALSE)
  }
}

compare_lines(schema_path, "inst/extdata/schema.json", "generated schema snapshot")
compare_lines(provenance_path, "inst/extdata/schema.provenance.json", "generated schema provenance")
cat("Schema snapshot and provenance match the pinned SDL\n")

wrapper_path <- tempfile(fileext = ".R")
on.exit(unlink(wrapper_path), add = TRUE)
writeLines(build_wrappers(schema_path = schema_path), wrapper_path)
compare_lines(wrapper_path, "R/stashapi_functions.R", "generated wrappers")
cat("Generated wrappers match R/stashapi_functions.R\n")

input_docs <- new.env(parent = globalenv())
sys.source("tools/generate_input_helper_docs.R", envir = input_docs)
input_doc_dir <- tempfile("stashapi-input-docs-")
dir.create(input_doc_dir)
on.exit(unlink(input_doc_dir, recursive = TRUE), add = TRUE)
input_docs$generate_input_helper_docs(schema_path, input_doc_dir)
input_registry <- input_docs$normalize_schema_registry(
  input_docs$read_schema_types(schema_path = schema_path)
)

for (type_name in names(input_docs$curated_types)) {
  builder <- input_docs$build_input_builder_ir(input_registry)[[type_name]]
  expected_path <- file.path("man", paste0(input_docs$helper_name(type_name, builder), ".Rd"))
  compare_lines(
    file.path(input_doc_dir, basename(expected_path)),
    expected_path,
    "generated input documentation"
  )
}
cat("Generated input documentation matches man/\n")

documentation_root <- normalizePath(".", mustWork = TRUE)
check_directory <- tempfile("stashapi-documentation-check-")
dir.create(check_directory)
on.exit(unlink(check_directory, recursive = TRUE), add = TRUE)

copy_sources <- function(path) {
  target <- file.path(check_directory, path)
  if (dir.exists(path)) {
    dir.create(check_directory, recursive = TRUE, showWarnings = FALSE)
    invisible(file.copy(path, check_directory, recursive = TRUE))
  } else {
    dir.create(dirname(target), recursive = TRUE, showWarnings = FALSE)
    invisible(file.copy(path, target, overwrite = TRUE))
  }
}

for (path in c("DESCRIPTION", "NAMESPACE", "R", "inst", "tools")) copy_sources(path)
dir.create(file.path(check_directory, "man"))
previous_directory <- setwd(check_directory)
on.exit(setwd(previous_directory), add = TRUE)
roxygen2::roxygenise()
setwd(previous_directory)

compare_documentation <- function(relative_path) {
  compare_lines(
    file.path(check_directory, relative_path),
    file.path(documentation_root, relative_path),
    "generated documentation"
  )
}

compare_documentation("NAMESPACE")
wrapper_lines <- readLines(file.path(documentation_root, "R", "stashapi_functions.R"), warn = FALSE)
operation_names <- sub(
  "^([A-Za-z][A-Za-z0-9]*) <- function.*$",
  "\\1",
  wrapper_lines[grepl("^[A-Za-z][A-Za-z0-9]* <- function", wrapper_lines)]
)
for (operation_name in operation_names) {
  compare_documentation(file.path("man", paste0(operation_name, ".Rd")))
}
cat("Generated Roxygen documentation matches man/ and NAMESPACE\n")