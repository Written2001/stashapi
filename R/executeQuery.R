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
executeQuery <- function(query, variables, connection, return_default = NA, field = NA) {

  if(return_default == field[1] && purrr::pluck_exists(variables, "filter", "per_page") && purrr::pluck(variables, "filter", "per_page") == -1){

    rows_per_batch <- 5000
    variables <- purrr::assign_in(variables, list("filter", "per_page"), rows_per_batch)
    res <- fetch(query = query, variables = variables, connection = connection, return_default, field = NA_character_)

    count <- purrr::pluck(res, "count")
    first_page <- purrr::pluck(res, !!!field)

    if(count < rows_per_batch)
      return(purrr::pluck(res, !!!field))

    message(paste("Collecting", count, "items"))
    npages <- seq(ceiling(count / purrr::pluck(variables, "filter", "per_page")))[-1]
    other_pages <- purrr::map(npages, function(page){
      variables <- purrr::assign_in(variables, list("filter", "page"), page)
      res_2 <- fetch(query = query, variables = variables, connection = connection, return_default = return_default, field = field)
      return(res_2)
    }, .progress = TRUE)

    all_pages <- c(list(first_page), other_pages)

    if (all(purrr::map_lgl(all_pages, is.character))){
      return(unlist(all_pages))
    } else if (all(purrr::map_lgl(all_pages, tibble::is_tibble))){
      return(dplyr::bind_rows(first_page, other_pages))
    } else if (all(purrr::map_lgl(all_pages, is.list))){
      return(purrr::flatten(all_pages))
    }

  }

  res <- fetch(query = query, variables = variables, connection = connection, return_default = return_default, field = field)

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
fetch <- function(query, variables, connection, return_default, field){
  res_raw <- connection$exec(query, variables = variables)
  res <-jsonlite::fromJSON(res_raw, flatten = FALSE)
  if('errors' %in% names(res)) stop(res$errors)
  if(purrr::pluck_depth(res) <= 1) return(res)
  if(purrr::pluck_exists(res$data, 1)) {
    res <- clean_list(purrr::pluck(res$data, 1))
  }

  if(tibble::is_tibble(res) | all(purrr::map_lgl(res, tibble::is_tibble)))
    if(all(is.na(field)))
      return(res)

  if(all(!is.na(field)))
    return(purrr::pluck(res, !!!field))

  if(is.na(field) && !is.na(return_default))
    return(res)

  if(is.na(field) && length(res) > 1){
    res <- purrr::map(res, ~ if(length(.x) > 1 | is.data.frame(.x)) {list(.x)} else .x)
    return(tibble::as_tibble(res))
  }

  return(res)
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
