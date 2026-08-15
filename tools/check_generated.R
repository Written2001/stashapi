source("tools/build_functions.R")

check_generated <- function() {
  output_path <- tempfile(fileext = ".R")
  on.exit(unlink(output_path), add = TRUE)
  generate_functions(output_path)

  expected <- readLines("R/stashapi_functions.R", warn = FALSE)
  actual <- readLines(output_path, warn = FALSE)

  if (!identical(actual, expected)) {
    stop("Generated wrappers differ from R/stashapi_functions.R", call. = FALSE)
  }
}

check_generated()
cat("Generated wrappers match R/stashapi_functions.R\n")
