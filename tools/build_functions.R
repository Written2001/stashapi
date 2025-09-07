make_arg_list <- function(args) {
  if(nrow(args) == 0) return("...")
  args <- dplyr::mutate(args, defaultValue = dplyr::if_else(is_scalar & is_non_null, " = list()", " = NA"))
  args <- paste0(args$san_name, args$defaultValue, collapse = ", ")
  paste0(args, ", ...")
}

make_arg_doc <- function(args) {
  if (nrow(args) == 0) return("@param ... additional parameters like .field to retrieve only a certain field from the response")
  args$description <- tidyr::replace_na(args$description, "See the Playground for further details.")
  args$description <- stringr::str_replace_all(args$description, "\n", "\n#' ")
  args_description <- paste("@param", args$san_name, " ", args$description, collapse = "\n#' ")
  paste0(args_description, "\n#' @param ... additional parameters like .field to retrieve only a certain field from the response")
}

serialize_vars_code <- function(args) {
  if (nrow(args) == 0) return('variables <- list()')
  lines <- paste0("variables[['", args$san_name, "']] <- ", args$san_name)
  paste(c("variables <- list()", lines), collapse = "\n  ")
}

make_description <- function(description){
  purrr::map_chr(description, function(x){
    if(is.na(x)) return("")
    stringr::str_replace_all(x, "\n", "\n#' ") %>%
      paste("@description", .)
  })
}

build_return_default <- function(request){
  if(request$is_object){
    if(length(request$return_object) == 1 && !is.na(request$return_object)){
      glue::glue('
      return_default <- "{request$return_object}"
        dotargs <- list(...)
        if(!".field" %in% names(dotargs)) {{
          dotargs$.field <- return_default
        }}
                 ')
    } else {
      glue::glue('
      return_default <- NA_character_
        dotargs <- list(...)
        if(!".field" %in% names(dotargs)) {{
          dotargs$.field <- return_default
        }}
                 ')

    }
  } else {
    glue::glue('
      return_default <- NA_character_
        dotargs <- list(...)
        if(!".field" %in% names(dotargs)) {{
          dotargs$.field <- return_default
        }}
                 ')

  }
}

build_function <- function(request){
  glue::glue("
  #' Call GraphQL operation: {request$name}
  #' {request$description}
  #' {request$variables_documentation}
  #' @importFrom ghql Query
  #' @return processed API response
  #' @export
  {request$name} <- function({request$fargs}) {{

    query <- ghql::Query$new()
    query$query('{request$name}', '
    {request$combined_request}
    ')

    {request$serialized_variables}

    {request$return_default}
    res <- executeQuery(query = query$queries${request$name}, variables = variables, connection = the$connection, return_default = return_default, field = dotargs$.field)

    return(res)
  }}

             ")
}

write_function <- function(schema_requests, outpath){

  schema_functions <- schema_requests %>%
    dplyr::mutate(description = make_description(description)) %>%
    dplyr::mutate(fargs = purrr::map_chr(arg_types, make_arg_list)) %>%
    dplyr::mutate(serialized_variables = purrr::map_chr(arg_types, serialize_vars_code)) %>%
    dplyr::mutate(variables_documentation = purrr::map_chr(arg_types, make_arg_doc)) %>%
    dplyr::rowwise() %>%
    dplyr::mutate(return_default = list(build_return_default(dplyr::across(dplyr::everything())))) %>%
    dplyr::mutate(function_content = list(build_function(dplyr::across(dplyr::everything()))))

  if(file.exists(outpath)) file.remove(outpath)

  writeLines(paste(schema_functions$function_content, collapse = "\n"), outpath)
}

source("tools/build_schema.R")
args <- commandArgs(trailingOnly = TRUE)
outpath <- args[1]
write_function(schema_requests = schema_requests, outpath = outpath)
