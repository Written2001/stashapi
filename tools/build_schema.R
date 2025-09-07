introspection <- function(){

  introspection_query <- ghql::Query$new()
  introspection_query$query("fragIntrospection", '{
    __schema {
      types {
        ...FullType
      }
    }
  }

  fragment FullType on __Type {
    kind
    name
    description
    fields(includeDeprecated: true) {
      name
      description
      args {
        ...InputValue
      }
      type {
        ...TypeRef
      }
      isDeprecated
      deprecationReason
    }
    inputFields {
      ...InputValue
    }
    interfaces {
      ...TypeRef
    }
    enumValues(includeDeprecated: true) {
      name
      description
      isDeprecated
      deprecationReason
    }
    possibleTypes {
      ...TypeRef
    }
  }

  fragment InputValue on __InputValue {
    name
    description
    type {
      ...TypeRef
    }
    defaultValue
  }

  fragment TypeRef on __Type {
    kind
    name
    ofType {
      kind
      name
      ofType {
        kind
        name
        ofType {
          kind
          name
          ofType {
            kind
            name
            ofType {
              kind
              name
              ofType {
                kind
                name
              }
            }
          }
        }
      }
    }
  }'
  )

  stash_schema <- execute_query(query = introspection_query$queries$fragIntrospection, variables = list(), connection = the$connection, return_default = NA, field = NA)
  schema_types <- stash_schema$types
  return(schema_types)
}

flatten_field_type <- function(type){
  kinds <- c(); names <- c()
  while(is.data.frame(type)) {
    if ("kind" %in% names(type)) kinds <- c(kinds, as.character(type$kind))
    if ("name" %in% names(type)) names <- c(names, as.character(type$name))
    type <- if ("ofType" %in% names(type)) type$ofType else NULL
  }
  list(tibble::tibble(kinds = kinds, name = names))
}

flatten_args <- function(args){
  purrr::map(args, function(arg_df){
    if(!is.data.frame(arg_df)) return(tibble::tibble())
    if(nrow(arg_df) == 0) return(tibble::tibble())
    arg_df %>%
      dplyr::rowwise() %>%
      dplyr::mutate(arg_types = flatten_field_type(type), .keep = "unused") %>%
      dplyr::ungroup() %>%
      dplyr::mutate(san_name = gsub("_", "", name),
                    is_list = purrr::map_lgl(arg_types, ~ "LIST" %in% .x$kinds),
                    is_input_object = purrr::map_lgl(arg_types, ~ "INPUT_OBJECT" %in% .x$kinds),
                    is_scalar = purrr::map_lgl(arg_types, ~ "SCALAR" %in% .x$kinds),
                    is_non_null = purrr::map_lgl(arg_types, ~ "NON_NULL" %in% .x$kinds),
                    is_multiple_non_null = purrr::map_lgl(arg_types, ~ sum(.x$kinds == "NON_NULL") > 1),
                    arg_type = purrr::map_chr(arg_types, ~ purrr::discard(.x$name, is.na)),
                    description = as.character(description),
                    defaultValue = as.character(defaultValue),
                    .keep = "all")
  })
}

extract_fields <- function(fields){
  purrr::map(fields, function(field_df){
    tibble::tibble(field_df) %>%
      dplyr::mutate(arg_types = flatten_args(args), .keep = "unused", .before = "type") %>%
      dplyr::rowwise() %>%
      dplyr::mutate(field_types = flatten_field_type(type), .keep = "unused", .before = "isDeprecated") %>%
      dplyr::ungroup() %>%
      dplyr::mutate(is_list = purrr::map_lgl(field_types, ~ "LIST" %in% .x$kinds),
                    is_object = purrr::map_lgl(field_types, ~ "OBJECT" %in% .x$kinds),
                    is_union = purrr::map_lgl(field_types, ~ "UNION" %in% .x$kinds),
                    type_name = purrr::map_chr(field_types, ~ purrr::discard(.x$name, is.na)),
                    use_alias = dplyr::if_else(any(grepl("Scraped", type_name)), TRUE, FALSE),
                    use_alias = dplyr::if_else(is_object, FALSE, use_alias),
                    alias = glue::glue("{object_name}_{name}"),
                    .keep = "all",
                    .after = field_types)
  })
}

extract_return_field <- function(fields){
  purrr::map_chr(fields, function(field_df){
    if(nrow(field_df) == 0) return(NA_character_)
    if(sum(field_df$is_object) == 0) return(NA_character_)
    if(grepl("ResultType", unique(field_df$object_name)) == FALSE) return(NA_character_)
    dplyr::filter(field_df, is_object) %>%
      dplyr::pull(name)
  })
}

extract_possibleTypes <- function(possibleTypes){
  purrr::map_chr(possibleTypes, function(possibleType){
    tibble::tibble(possibleType) %>%
      dplyr::rename(type_name = ofType) %>%
      dplyr::mutate(fields_string = glue::glue("...{name}")) %>%
      dplyr::summarise(
        object_name = unique(object_name),
        fields_string = paste(fields_string, collapse = " ")
      ) %>%
      glue::glue_data("fragment {object_name} on {object_name} {{ {fields_string} }}")
  })
}

# extract_inputFields <- function(inputFields){
#   purrr::map(inputFields, function(inputFields_df){
#     tibble::tibble(inputFields_df) %>%
#       dplyr::rowwise() %>%
#       dplyr::mutate(inputField_types = flatten_field_type(type), .keep = "unused", .before = type) %>%
#       dplyr::ungroup() %>%
#       dplyr::mutate(is_list = purrr::map_lgl(inputField_types, ~ "LIST" %in% .x$kinds),
#                     is_object = purrr::map_lgl(inputField_types, ~ "INPUT_OBJECT" %in% .x$kinds),
#                     type_name = purrr::map_chr(inputField_types, ~ purrr::discard(.x$name, is.na)),
#                     use_alias = FALSE,
#                     isDeprecated = FALSE,,
#                     alias = "",,
#                     is_union = FALSE,
#                     .keep = "all",
#                     .before = inputField_types)
#   })
# }

build_fragments <- function(fields){
  purrr::map_chr(fields, function(field_df){
    field_df %>%
      dplyr::mutate(use_overrides = !grepl("ResultType", object_name),
                    use_field_overrides = name %in% names(field_overrides),
                    use_fragment_overrides = type_name %in% names(fragment_overrides), .before = isDeprecated) %>%
      dplyr::mutate(fragment_string = dplyr::case_when(
        use_overrides & use_field_overrides ~ field_overrides[as.character(name)],
        use_overrides & use_fragment_overrides ~ glue::glue("{name} {fragment_overrides[type_name]}"),
        is_object ~ glue::glue("{name} {{ ...{type_name} }}"),
        is_union ~ glue::glue("{name} {{ ...{type_name} }}"),
        use_alias ~ glue::glue("{alias}: {name}"),
        !is_object ~ name
      ), .keep = "all") %>%
      dplyr::filter(isDeprecated == FALSE, !is.na(fragment_string)) %>%
      dplyr::summarise(
        object_name = unique(object_name),
        fields_string = paste(fragment_string, collapse = " ")
      ) %>%
      glue::glue_data("fragment {object_name} on {object_name} {{ {fields_string} }}")
  })
}

parse_variables <- function(args){
  purrr::map(args, function(args_df){
    if(nrow(args_df) == 0) return(tibble::tibble(variables_string = "", arguments_string = ""))
    args_df %>%
      dplyr::mutate(arg_type_string = dplyr::case_when(
        is_list & is_non_null & is_multiple_non_null ~ glue::glue("[{arg_type}!]!"),
        is_list & is_non_null ~ glue::glue("[{arg_type}!]"),
        is_list ~ glue::glue("[{arg_type}]"),
        is_non_null ~ glue::glue("{arg_type}!"),
        .default = arg_type
      )) %>%
      dplyr::mutate(variables_string = glue::glue("${san_name}: {arg_type_string}"),
                    arguments_string = glue::glue("{name}: ${san_name}"),
                    .keep = "used") %>%
      dplyr::summarise(
        variables_string = paste0("(", paste(variables_string, collapse = " "), ")"),
        arguments_string = paste0("(", paste(arguments_string, collapse = " "), ")")
      ) %>%
      dplyr::mutate(dplyr::across(dplyr::ends_with("string"), ~ tidyr::replace_na(.x, "")))
  })
}

build_requests <- function(fields, schema_objects){
  purrr::map(fields, function(field_df){
    field_df %>%
      dplyr::left_join(dplyr::select(schema_objects, name, return_object), by = dplyr::join_by(type_name == name)) %>%
      dplyr::filter(isDeprecated == FALSE) %>%
      dplyr::mutate(has_args = purrr::map_lgl(arg_types, ~ nrow(.x) > 0),
                    arg_strings = parse_variables(arg_types), .after = arg_types) %>%
      tidyr::unnest(arg_strings, keep_empty = TRUE) %>%
      dplyr::mutate(type_name_string = dplyr::if_else(is_object | is_union, glue::glue("{{ ...{type_name} }} "), ""), .after = type_name) %>%
      dplyr::mutate(request = glue::glue("{tolower(object_name)} {name}{variables_string} {{ {name}{arguments_string} {type_name_string}}}"),
                    frag_objects = stringr::str_extract_all(request, "(?<=\\.{3})\\s*(\\S+)"),
                    .keep = "all")
  })
}

get_dependent_fragments <- function(frag_objects, fragments_df, visited_frag_objects = character()){
  purrr::map(frag_objects, function(fragment){

    if(length(fragment) == 0) return(character())

    visited_frag_objects <- c(visited_frag_objects, fragment)

    direct <- fragments_df %>%
      dplyr::filter(name == fragment) %>%
      dplyr::pull(frag_objects) %>%
      purrr::pluck(1) %>%
      unique()

    if(length(direct) == 0){
      return(fragment)
    }

    cycles <- intersect(direct, visited_frag_objects)
    if(length(cycles)) direct <- setdiff(direct, visited_frag_objects)

    indirect <- get_dependent_fragments(frag_objects = direct, fragments_df = fragments_df, visited = visited_frag_objects) %>%
      purrr::flatten_chr()

    unique(c(fragment, direct, indirect))

  })

}

combine_fragments <- function(name, dependent_fragments, fragments_df){

  dependent_fragments <- c(name, dependent_fragments)
  combined <- dplyr::filter(fragments_df, name %in% dependent_fragments) %>%
    dplyr::arrange(match(name, dependent_fragments)) %>%
    dplyr::pull(fragment_string) %>% paste0("  ", ., collapse = "\n")

  return(combined)
}

fragment_overrides <- c(
    Scene = "{ id title }",
    Studio = "{ id name }",
    Performer = "{ id name gender }",
    Image = "{ id }",
    Gallery = "{ id title }",
    Tag = "{ id name }",
    Group = "{ id name }",
    ScrapedStudio = "{ stored_id name }",
    StashID = "{ endpoint stash_id }"
)

field_overrides <- c(
    sceneStreams = NA_character_,
    fingerprint = NA_character_,
    image = NA_character_
)

library(magrittr)
if(file.exists("inst/extdata/schema.json")) {
  schema_types <- jsonlite::fromJSON(jsonlite::read_json("inst/extdata/schema.json")[[1]], flatten = F)$data$'__schema'$types
} else {
  library(ghql)
  source("R/setStashCredentials.R")
  source("R/execute_query.R")
  setStashCredentials()
  schema_types <- introspection()
}


schema_objects <- schema_types %>%
  dplyr::filter(kind == "OBJECT") %>%
  dplyr::select(-c(inputFields, interfaces, enumValues, possibleTypes)) %>%
  dplyr::mutate(fields = purrr::map2(name, fields, ~ dplyr::mutate(.y, object_name = .x, .before = name))) %>%
  dplyr::mutate(fields = extract_fields(fields)) %>%
  dplyr::mutate(return_object = extract_return_field(fields)) %>%
  dplyr::mutate(fragment_string = build_fragments(fields),
                frag_objects = stringr::str_extract_all(fragment_string, "(?<=\\.{3})\\s*(\\S+)"))

schema_unions <- schema_types %>%
  dplyr::filter(kind == "UNION") %>%
  dplyr::select(-c(fields, inputFields, interfaces, enumValues)) %>%
  dplyr::mutate(possibleTypes = purrr::map2(name, possibleTypes, ~ dplyr::mutate(.y, object_name = .x, .before = kind))) %>%
  dplyr::mutate(fragment_string = extract_possibleTypes(possibleTypes),
                frag_objects = stringr::str_extract_all(fragment_string, "(?<=\\.{3})\\s*(\\S+)"))

# schema_input_objects <- schema_types %>%
#   dplyr::filter(kind == "INPUT_OBJECT") %>%
#   dplyr::select(-c(fields, interfaces, enumValues, possibleTypes)) %>%
#   dplyr::mutate(inputFields = purrr::map2(name, inputFields, ~ dplyr::mutate(.y, object_name = .x, .before = name))) %>%
#   dplyr::mutate(inputFields = extract_inputFields(inputFields)) %>%
#   dplyr::mutate(fragment_string = build_fragments(inputFields))

fragments_df <- dplyr::bind_rows(schema_objects, schema_unions) %>%
  dplyr::distinct(kind, name, frag_objects, fragment_string)

schema_requests <- schema_objects %>%
  dplyr::filter(name %in% c("Query", "Mutation")) %>%
  dplyr::select(-c(description, fragment_string)) %>%
  dplyr::mutate(reqests = build_requests(fields, schema_objects)) %>%
  dplyr::pull(reqests) %>%
  dplyr::bind_rows() %>%
  dplyr::mutate(dependent_fragments = get_dependent_fragments(frag_objects, fragments_df = fragments_df, visited_frag_objects = character())) %>%
  dplyr::mutate(combined_fragment = purrr::map2_chr(.x = name, .y = dependent_fragments, .f = combine_fragments, fragments = fragments_df)) %>%
  dplyr::mutate(combined_request = glue::glue("\n  {request}\n  {combined_fragment}"))
