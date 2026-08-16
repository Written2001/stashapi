source("tools/generate_migrated.R")

check_generated <- function() {
  output_path <- tempfile(fileext = ".R")
  on.exit(unlink(output_path), add = TRUE)
  generator <- get("build_migrated_wrappers", mode = "function")
  writeLines(generator(), output_path)

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
    "inst/extdata/schema.json",
    output_dir
  )

  for (type_name in names(generator_environment$curated_types)) {
    builder <- generator_environment$build_input_builder_ir(
      generator_environment$normalize_schema_registry(
        jsonlite::fromJSON("inst/extdata/schema.json", flatten = FALSE)$data$`__schema`$types
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
