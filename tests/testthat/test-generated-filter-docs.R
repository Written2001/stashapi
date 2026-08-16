package_root <- normalizePath(testthat::test_path("..", ".."), mustWork = TRUE)
previous_directory <- setwd(package_root)
on.exit(setwd(previous_directory), add = TRUE)
doc_generator <- new.env(parent = globalenv())
sys.source(file.path(package_root, "tools", "generate_input_helper_docs.R"), envir = doc_generator)

raw_schema <- jsonlite::fromJSON(
  file.path(package_root, "inst", "extdata", "schema.json"),
  flatten = FALSE
)$data$`__schema`$types
registry <- doc_generator$normalize_schema_registry(raw_schema)
builders <- doc_generator$build_input_builder_ir(registry)

testthat::test_that("generated filter docs cover every schema field", {
  output_dir <- tempfile()
  dir.create(output_dir)
  on.exit(unlink(output_dir, recursive = TRUE), add = TRUE)
  doc_generator$generate_input_helper_docs(
    file.path(package_root, "inst", "extdata", "schema.json"),
    output_dir
  )

  for (type_name in names(doc_generator$curated_types)) {
    builder <- builders[[type_name]]
    path <- file.path(output_dir, paste0(doc_generator$helper_name(type_name, builder), ".Rd"))
    content <- paste(readLines(path, warn = FALSE), collapse = "\n")
    for (field_name in builder$field_names) {
      testthat::expect_true(
        grepl(paste0("\\code{", field_name, "}"), content, fixed = TRUE),
        info = paste(type_name, field_name)
      )
    }
  }
})

testthat::test_that("generated filter docs are deterministic and parseable", {
  first <- doc_generator$render_filter_doc(
    builders$SceneFilterType,
    doc_generator$curated_types[["SceneFilterType"]]
  )
  second <- doc_generator$render_filter_doc(
    builders$SceneFilterType,
    doc_generator$curated_types[["SceneFilterType"]]
  )
  testthat::expect_identical(first, second)

  path <- tempfile(fileext = ".Rd")
  writeLines(first, path)
  testthat::expect_silent(tools::parse_Rd(path))
  unlink(path)
  testthat::expect_match(first, "\\section{Allowed fields}", fixed = TRUE)
  testthat::expect_match(first, "\\examples{scene_filter(title = includes(\"example\"))}", fixed = TRUE)
  testthat::expect_match(first, "R input: `criterion, e.g. includes(\"text\")`", fixed = TRUE)
})
