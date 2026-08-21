documentation_root <- normalizePath(".", mustWork = TRUE)
schema_source_root <- Sys.getenv("STASH_SOURCE_ROOT", unset = "")
if (!nzchar(schema_source_root) || !dir.exists(schema_source_root)) {
  stop("STASH_SOURCE_ROOT must identify a pinned SDL checkout", call. = FALSE)
}
required_artifacts <- c(
  "R/stashapi_functions.R",
  "NAMESPACE",
  "inst/extdata/schema.json"
)
missing_artifacts <- required_artifacts[!file.exists(required_artifacts)]
if (length(missing_artifacts) > 0L) {
  stop(
    "required generated/source artifacts are missing: ",
    paste(missing_artifacts, collapse = ", "),
    call. = FALSE
  )
}

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

copy_sources("DESCRIPTION")
copy_sources("NAMESPACE")
copy_sources("R")
copy_sources("inst")
copy_sources("tools")
dir.create(file.path(check_directory, "man"))

run_in_check_directory <- function(expression) {
  previous_directory <- setwd(check_directory)
  on.exit(setwd(previous_directory), add = TRUE)
  force(expression)
}

run_in_check_directory(
  roxygen2::roxygenise()
)

input_docs <- new.env(parent = globalenv())
sys.source(
  file.path(check_directory, "tools", "generate_input_helper_docs.R"),
  envir = input_docs
)
run_in_check_directory(
  input_docs$generate_input_helper_docs(
    schema_path = NULL,
    output_dir = file.path(check_directory, "man"),
    source_root = schema_source_root
  )
)

compare_file <- function(relative_path) {
  expected_path <- file.path(documentation_root, relative_path)
  actual_path <- file.path(check_directory, relative_path)
  if (!file.exists(expected_path)) {
    stop("tracked generated documentation is missing: ", relative_path, call. = FALSE)
  }
  if (!file.exists(actual_path)) {
    stop("documentation regeneration did not produce: ", relative_path, call. = FALSE)
  }
  expected <- readLines(expected_path, warn = FALSE)
  actual <- readLines(actual_path, warn = FALSE)
  if (!identical(expected, actual)) {
    stop("generated documentation differs from ", relative_path, call. = FALSE)
  }
}

compare_file("NAMESPACE")

wrapper_lines <- readLines(file.path(documentation_root, "R", "stashapi_functions.R"), warn = FALSE)
operation_names <- sub(
  "^([A-Za-z][A-Za-z0-9]*) <- function.*$",
  "\\1",
  wrapper_lines[grepl("^[A-Za-z][A-Za-z0-9]* <- function", wrapper_lines)]
)
for (operation_name in operation_names) {
  compare_file(file.path("man", paste0(operation_name, ".Rd")))
}

curated_types <- input_docs$curated_types
for (type_name in names(curated_types)) {
  builder <- input_docs$build_input_builder_ir(
    input_docs$normalize_schema_registry(
      input_docs$read_schema_types(source_root = schema_source_root)
    )
  )[[type_name]]
  compare_file(file.path("man", paste0(input_docs$helper_name(type_name, builder), ".Rd")))
}

cat("Generated namespace and operation/input documentation are reproducible\n")
