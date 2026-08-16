sys.source("tools/schema_types.R", envir = environment())
sys.source("tools/schema_inputs.R", envir = environment())

normalize_registry <- get("normalize_schema_registry", mode = "function")
contains_type <- get("type_ref_contains", mode = "function")
build_input_builders <- get("build_input_builder_ir", mode = "function")
type_to_string <- get("type_ref_to_string", mode = "function")
named_type <- get("type_ref_named_type", mode = "function")
builder_name <- get("input_builder_name", mode = "function")

curated_types <- c(
  FindFilterType = "generated find functions",
  SceneFilterType = "findScenes(scenefilter = ...)",
  ImageFilterType = "findImages(imagefilter = ...)",
  GalleryFilterType = "findGalleries(galleryfilter = ...)",
  GroupFilterType = "findGroups(groupfilter = ...)",
  SceneMarkerFilterType = "findSceneMarkers(scenemarkerfilter = ...)",
  PerformerFilterType = "findPerformers(performerfilter = ...)",
  StudioFilterType = "findStudios(studiofilter = ...)",
  TagFilterType = "findTags(tagfilter = ...)"
)

example_fields <- c(
  SceneFilterType = "title",
  ImageFilterType = "title",
  GalleryFilterType = "title",
  GroupFilterType = "name",
  SceneMarkerFilterType = "tags",
  PerformerFilterType = "name",
  StudioFilterType = "name",
  TagFilterType = "name",
  FindFilterType = "q"
)

helper_name <- function(type_name, builder) {
  if (identical(type_name, "SceneMarkerFilterType")) return("marker_filter")
  builder$function_name
}

escape_rd <- function(value) {
  gsub("([\\\\{}%])", "\\\\\\1", as.character(value))
}

field_type <- function(field) {
  type_to_string(field$type)
}

field_named_type <- function(field) {
  named_type(field$type)
}

field_category <- function(field) {
  if (field$name %in% c("AND", "OR", "NOT")) return("Boolean composition")
  named_type <- field_named_type(field)
  if (grepl("FilterType$", named_type) || grepl("_filter$", field$name)) {
    return("Nested filters")
  }
  if (grepl("CriterionInput$", named_type) || grepl("CriterionInput", named_type)) {
    return("Criteria")
  }
  if (grepl("ID|Int|Float|String|Boolean|Date", named_type)) return("Scalar fields")
  "Other schema fields"
}

example_value <- function(field) {
  named_type <- field_named_type(field)
  if (grepl("MultiCriterionInput$", named_type)) return("1")
  if (grepl("StashIDsCriterionInput$", named_type)) return("c(1, 2)")
  if (grepl("StashIDCriterionInput$", named_type)) return("1")
  if (grepl("String", named_type)) return('"example"')
  if (grepl("Int|ID", named_type)) return("1")
  if (grepl("Float", named_type)) return("1")
  if (grepl("Boolean", named_type)) return("TRUE")
  if (grepl("Date", named_type)) return('"2020-01-01"')
  "list()"
}

example_helper <- function(field) {
  named_type <- field_named_type(field)
  if (grepl("MultiCriterionInput$", named_type) || grepl("StringCriterionInput$", named_type)) {
    return("includes")
  }
  if (grepl("CriterionInput$", named_type)) return("equals")
  "equals"
}

example_expression <- function(builder, function_name = builder$function_name) {
  if (identical(builder$type_name, "FindFilterType")) {
    return("find_filter(q = \"example\", per_page = 25)")
  }
  candidates <- Filter(function(field) {
    !field$name %in% c("AND", "OR", "NOT") && grepl("CriterionInput$", field_named_type(field))
  }, builder$fields)
  if (length(candidates) == 0L) return(paste0(function_name, "()"))
  preferred <- unname(example_fields[[builder$type_name]])
  preferred_index <- match(preferred, vapply(candidates, `[[`, character(1), "name"))
  field <- if (!is.na(preferred_index)) candidates[[preferred_index]] else candidates[[1]]
  paste0(function_name, "(", field$name, " = ", example_helper(field), "(", example_value(field), "))")
}

render_r_input_hint <- function(field, registry) {
  named_type <- field_named_type(field)
  if (field$name %in% c("AND", "OR", "NOT")) return("nested filter()")
  if (grepl("FilterType$", named_type)) return(paste0(builder_name(named_type), "(...)"))
  if (grepl("MultiCriterionInput$", named_type)) return("criterion, e.g. includes(1)")
  if (grepl("StringCriterionInput$", named_type)) return("criterion, e.g. includes(\"text\")")
  if (grepl("IntCriterionInput$|FloatCriterionInput$", named_type)) return("criterion, e.g. greater_than(1)")
  if (grepl("BooleanCriterionInput$", named_type)) return("criterion, e.g. equals(TRUE)")
  if (grepl("DateCriterionInput$|TimestampCriterionInput$", named_type)) {
    return("criterion, e.g. equals(\"2020-01-01\")")
  }
  if (grepl("StashIDsCriterionInput$", named_type)) return("stash_ids(endpoint_url, ids)")
  if (grepl("StashIDCriterionInput$", named_type)) return("stash_id(endpoint_url, id)")
  if (grepl("CriterionInput$", named_type)) return("criterion helper")
  if (identical(named_type, "Boolean")) return("TRUE or FALSE")
  if (identical(named_type, "String")) return("character string")
  if (identical(named_type, "Int")) return("integer or numeric")
  if (identical(named_type, "Float")) return("numeric")
  if (grepl("Enum$", named_type)) return("schema enum value")
  if (contains_type(field$type, "LIST")) return("vector or list")
  paste0("value of type ", named_type)
}

render_allowed_fields <- function(builder, registry) {
  groups <- split(builder$fields, vapply(builder$fields, field_category, character(1)))
  category_order <- c("Boolean composition", "Criteria", "Scalar fields", "Nested filters", "Other schema fields")
  groups <- groups[intersect(category_order, names(groups))]
  sections <- lapply(names(groups), function(category) {
    items <- vapply(groups[[category]], function(field) {
      paste0(
        "\\item{\\code{", escape_rd(field$name), "}}{",
        "GraphQL type: `", escape_rd(field_type(field)), "`. ",
        "R input: `", escape_rd(render_r_input_hint(field, registry)), "`.}",
        "\n"
      )
    }, character(1))
    paste0("\\subsection{", category, "}{\\describe{", paste(items, collapse = ""), "}}\n")
  })
  paste0("\\section{Allowed fields}{", paste(sections, collapse = ""), "}")
}

render_filter_doc <- function(builder, find_usage, function_name = builder$function_name, registry = NULL) {
  if (is.null(registry)) registry <- list()
  title <- paste0("Build a ", gsub("_", " ", sub("_filter$", " filter", function_name)), ".")
  description <- paste0(
    "Builds a validated GraphQL ",
    escape_rd(builder$type_name),
    " input for ",
    escape_rd(find_usage),
    "."
  )
  paste0(
    "% Generated by tools/generate_input_helper_docs.R; do not edit by hand\n",
    "\\name{", function_name, "}\n",
    "\\alias{", function_name, "}\n",
    "\\title{", title, "}\n",
    "\\usage{", function_name, "(..., .strict = TRUE)}\n",
    "\\arguments{\n",
    "\\item{...}{Named fields from the Stash `", builder$type_name, "` input.}\n",
    "\\item{.strict}{Whether unknown fields should cause an error.}\n",
    "}\n",
    "\\value{A named list suitable for `", escape_rd(find_usage), "`.}\n",
    "\\description{", description, "}\n",
    render_allowed_fields(builder, registry), "\n",
    "\\examples{", example_expression(builder, function_name), "}"
  )
}

generate_input_helper_docs <- function(
  schema_path = "inst/extdata/schema.json",
  output_dir = "man"
) {
  raw_schema <- jsonlite::fromJSON(schema_path, flatten = FALSE)$data$`__schema`$types
  registry <- normalize_registry(raw_schema)
  builders <- build_input_builders(registry)
  for (type_name in names(curated_types)) {
    builder <- builders[[type_name]]
    if (is.null(builder)) stop("schema input type not found: ", type_name, call. = FALSE)
    output_path <- file.path(output_dir, paste0(helper_name(type_name, builder), ".Rd"))
    writeLines(render_filter_doc(
      builder,
      curated_types[[type_name]],
      helper_name(type_name, builder),
      registry
    ), output_path)
  }
  invisible(TRUE)
}

args <- commandArgs(trailingOnly = TRUE)
if (identical(environment(), globalenv()) && !interactive()) {
  if (length(args) == 0L) generate_input_helper_docs() else generate_input_helper_docs(args[[1]], args[[2]] %||% "man")
}
