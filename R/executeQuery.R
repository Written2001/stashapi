#' Execute a query
#' @description Internal function that determines if a request should be paginated or not. Executes a query or mutation
#'
#' @param query list.
#' @param variables list.
#' @param connection ghql connection object.
#' @param return_default the response field that is returned by default
#' @param field optional user defined field to be returned
#'
#' @importFrom purrr flatten pluck_exists pluck assign_in map map_lgl
#' @importFrom dplyr bind_rows
#' @importFrom tibble is_tibble
#'
#' @returns The results of the query
#' @noRd
executeQuery <- function(
  query,
  variables,
  connection,
  return_default = NA,
  field = NA,
  response = "data"
) {
  validate_response_mode(response)
  if (identical(response, "raw") && !all(is.na(field))) {
    stop("`.field` cannot be used with `.response = \"raw\"`", call. = FALSE)
  }

  if(return_default == field[1] && purrr::pluck_exists(variables, "filter", "per_page") && purrr::pluck(variables, "filter", "per_page") == -1){

    if (identical(response, "raw")) {
      stop("`.response = \"raw\"` cannot be combined with per_page = -1", call. = FALSE)
    }

    rows_per_batch <- 5000
    variables <- purrr::assign_in(variables, list("filter", "per_page"), rows_per_batch)
    res <- fetch(
      query = query,
      variables = variables,
      connection = connection,
      return_default = return_default,
      field = NA_character_,
      response = response
    )

    page_data <- if (identical(response, "object")) res$data else res
    count <- response_metadata(page_data)$count
    first_page <- purrr::pluck(page_data, !!!field)

    if(count < rows_per_batch)
      return(if (identical(response, "object")) {
        new_stashapi_response(first_page, res$meta, res$raw)
      } else {
        first_page
      })

    message(paste("Collecting", count, "items"))
    npages <- seq(ceiling(count / purrr::pluck(variables, "filter", "per_page")))[-1]
    other_pages <- purrr::map(npages, function(page){
      variables <- purrr::assign_in(variables, list("filter", "page"), page)
      res_2 <- fetch(
        query = query,
        variables = variables,
        connection = connection,
        return_default = return_default,
        field = field,
        response = response
      )
      return(res_2)
    }, .progress = TRUE)

    if (identical(response, "object")) {
      page_values <- c(list(first_page), purrr::map(other_pages, `[[`, "data"))
      combined <- combine_response_pages(page_values)
      return(new_stashapi_response(
        combined,
        modifyList(res$meta, list(pages = length(page_values))),
        res$raw
      ))
    }

    all_pages <- c(list(first_page), other_pages)

    if (all(purrr::map_lgl(all_pages, is.character))){
      return(unlist(all_pages))
    } else if (all(purrr::map_lgl(all_pages, tibble::is_tibble))){
      return(dplyr::bind_rows(first_page, other_pages))
    } else if (all(purrr::map_lgl(all_pages, is.list))){
      return(purrr::flatten(all_pages))
    }

  }

  res <- fetch(
    query = query,
    variables = variables,
    connection = connection,
    return_default = return_default,
    field = field,
    response = response
  )

  return(res)
}

#' Execute a query
#' @description Internal function that executes a query and processes the response
#'
#' @param query list.
#' @param variables list.
#' @param connection ghql connection object.
#' @param return_default the response field that is returned by default
#' @param field optional user defined field to be returned
#'
#' @importFrom tibble is_tibble as_tibble
#' @importFrom purrr pluck_depth pluck_exists pluck map map_lgl
#' @importFrom jsonlite fromJSON
#'
#' @returns The results of the query
#' @noRd
fetch <- function(query, variables, connection, return_default, field, response = "data"){
  validate_response_mode(response)
  res_raw <- tryCatch(
    connection$exec(query, variables = variables),
    error = function(error) stop(new_stashapi_error(
      "stashapi_transport_error",
      paste("Stash request failed:", error$message)
    ))
  )
  parsed <- tryCatch(
    jsonlite::fromJSON(res_raw, flatten = FALSE),
    error = function(error) stop(new_stashapi_error(
      "stashapi_parse_error",
      paste("Unable to parse the Stash response:", error$message)
    ))
  )
  if ("errors" %in% names(parsed) && length(parsed$errors) > 0L) {
    stop(new_stashapi_error(
      "stashapi_graphql_error",
      paste("Stash GraphQL request failed:", format_graphql_errors(parsed$errors)),
      details = parsed$errors
    ))
  }
  if (identical(response, "raw")) return(parsed)
  if(purrr::pluck_depth(parsed) <= 1) return(parsed)
  data <- parsed$data
  if (purrr::pluck_exists(data, 1)) {
    data <- clean_list(purrr::pluck(data, 1))
  }

  if(tibble::is_tibble(data) || all(purrr::map_lgl(data, tibble::is_tibble)))
    if(all(is.na(field)))
      return(if (identical(response, "object")) {
        new_stashapi_response(data, response_metadata(data), parsed)
      } else data)

  if(all(!is.na(field)))
    selected <- purrr::pluck(data, !!!field)
  else if(is.na(field) && !is.na(return_default))
    selected <- data
  else if(is.na(field) && length(data) > 1){
    data <- purrr::map(data, ~ if(length(.x) > 1 | is.data.frame(.x)) {list(.x)} else .x)
    selected <- tibble::as_tibble(data)
  }
  else
    selected <- data

  if (identical(response, "object")) {
    new_stashapi_response(selected, response_metadata(data), parsed)
  } else selected
}

validate_response_mode <- function(response) {
  if (!is.character(response) || length(response) != 1L ||
      !response %in% c("data", "object", "raw")) {
    stop("`.response` must be one of \"data\", \"object\", or \"raw\"", call. = FALSE)
  }
  invisible(response)
}

new_stashapi_response <- function(data, meta = list(), raw = NULL) {
  structure(list(data = data, meta = meta, raw = raw), class = "stashapi_response")
}

response_metadata <- function(data) {
  fields <- intersect(c("count", "duration", "filesize"), names(data))
  lapply(data[fields], function(value) if (length(value) > 0L) value[[1]] else NULL)
}

combine_response_pages <- function(pages) {
  if (all(purrr::map_lgl(pages, is.data.frame))) {
    return(dplyr::bind_rows(pages))
  }
  if (all(purrr::map_lgl(pages, is.character))) return(unlist(pages))
  if (all(purrr::map_lgl(pages, is.list))) return(purrr::flatten(pages))
  stop("Unable to combine paginated Stash responses", call. = FALSE)
}

new_stashapi_error <- function(class, message, details = NULL) {
  structure(
    list(message = message, details = details),
    class = c(class, "stashapi_error", "error", "condition")
  )
}

format_graphql_errors <- function(errors) {
  messages <- vapply(errors, function(error) {
    if (is.list(error) && !is.null(error$message)) error$message else as.character(error)
  }, character(1))
  paste(messages, collapse = "; ")
}


#' Clean response
#' @description Internal function recurses through a response list and converts dataframes to tibbles, NULL and empty lists to NA
#'
#' @param x list.
#'
#' @importFrom dplyr mutate across where
#' @importFrom purrr map map_int map_lgl
#' @importFrom tibble as_tibble is_tibble
#'
#' @returns The cleaned input list
#' @noRd
clean_list <- function(x){
  if(is.data.frame(x)){
    x <- dplyr::mutate(x, dplyr::across(dplyr::where(~ is.list(.x) || is.data.frame(.x)), ~ {
      col <- .x
      if (is.data.frame(col)) {
        tibble::as_tibble(col)
      } else if (all(ncol(col) > 0, purrr::map_lgl(col, ~ is.null(.x) || is.data.frame(.x)))) {
        purrr::map(col, ~ if (is.null(.x)) {NA} else tibble::as_tibble(.x))
      } else {
        col
      }
    }))
    return(tibble::as_tibble(x))
  }
  else if(is.list(x)){
    x <- purrr::map(x, ~ if (is.null(.x) || length(.x) == 0) {NA} else .x)
    x <- if(max(purrr::map_int(x, length)) <= 1) tibble::as_tibble(x) else x
    if(tibble::is_tibble(x)){
      return(x)
    } else {
      return(purrr::map(x, clean_list))
    }
  } else {
    return(x)
  }
}
