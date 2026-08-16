#' Build an explicit response extraction policy for one operation.
#'
#' Paginated result objects default to their list-valued object field. Other
#' operations retain the existing whole-response behavior unless overridden.
#'
#' @param operation_name GraphQL operation name.
#' @param return_named_type Named return type.
#' @param registry A named schema registry.
#' @param overrides Optional named character vector of response fields.
#' @param named_type_fn Function that returns the leaf type name.
#' @param contains_type_fn Function that checks nested type wrappers.
#' @return A response policy record.
#' @noRd
build_response_policy <- function(
  operation_name,
  return_named_type,
  registry,
  overrides = character(),
  named_type_fn = get("type_ref_named_type", mode = "function"),
  contains_type_fn = get("type_ref_contains", mode = "function")
) {
  if (operation_name %in% names(overrides)) {
    return(list(default_field = unname(overrides[[operation_name]]), source = "override"))
  }

  return_definition <- registry[[return_named_type]]
  if (is.null(return_definition) || !identical(return_definition$kind, "OBJECT")) {
    return(list(default_field = NA_character_, source = "none"))
  }
  field_names <- vapply(return_definition$fields, function(field) field$name, character(1))
  if (!"count" %in% field_names) {
    return(list(default_field = NA_character_, source = "none"))
  }

  candidate_fields <- Filter(function(field) {
    if (isTRUE(field$is_deprecated) || !contains_type_fn(field$type, "LIST")) return(FALSE)
    field_definition <- registry[[named_type_fn(field$type)]]
    !is.null(field_definition) && field_definition$kind %in% c("OBJECT", "UNION", "INTERFACE")
  }, return_definition$fields)

  if (length(candidate_fields) == 0L) {
    return(list(default_field = NA_character_, source = "none"))
  }

  list(default_field = candidate_fields[[1]]$name, source = "schema")
}

#' Choose a field selection policy for nested object fields.
#'
#' Compact selections prevent common object relationships from recursively
#' expanding their full fragments. The policy is keyed by the referenced type.
#'
#' @param parent_type Parent GraphQL object type.
#' @param field_name GraphQL field name.
#' @param referenced_type Referenced named type.
#' @param fragment_overrides Named compact selection strings.
#' @param field_overrides Named field selections; `NA` omits a field.
#' @return A selection policy record.
#' @noRd
build_selection_policy <- function(
  parent_type,
  field_name,
  referenced_type,
  fragment_overrides = default_fragment_overrides(),
  field_overrides = default_field_overrides()
) {
  if (field_name %in% names(field_overrides)) {
    return(list(selection = unname(field_overrides[[field_name]]), reference = NULL, source = "field"))
  }
  if (referenced_type %in% names(fragment_overrides)) {
    return(list(selection = unname(fragment_overrides[[referenced_type]]), reference = NULL, source = "type"))
  }
  list(selection = NULL, reference = referenced_type, source = "recursive")
}

#' Default compact selections for common nested Stash objects.
#'
#' @return Named compact selection strings.
#' @noRd
default_fragment_overrides <- function() {
  c(
    Scene = "{ id title }",
    Studio = "{ id name }",
    Performer = "{ id name gender }",
    Image = "{ id }",
    Gallery = "{ id title }",
    Tag = "{ id name }",
    Group = "{ id name }",
    ScrapedStudio = "{ stored_id name }",
    StashID = "{ endpoint stash_id }",
    Folder = "{ id path basename }",
    BasicFile = "{ id path basename }",
    ScrapedTag = "{ stored_id name description alias_list remote_site_id }"
  )
}

#' Default fields omitted from generated selections.
#'
#' @return Named field overrides.
#' @noRd
default_field_overrides <- function() {
  c(sceneStreams = NA_character_, fingerprint = NA_character_, image = NA_character_)
}

#' Build response policies for an operation IR.
#'
#' @param operations Named operation IR records.
#' @param registry A named schema registry.
#' @param overrides Optional named character vector of response fields.
#' @return Operations with explicit response policies.
#' @noRd
apply_response_policies <- function(operations, registry, overrides = character()) {
  lapply(operations, function(operation) {
    operation$response_policy <- build_response_policy(
      operation$name,
      operation$return_named_type,
      registry,
      overrides = overrides
    )
    operation
  }) |> structure(names = names(operations))
}
