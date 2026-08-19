new_stash_progress <- function(enabled, total) {
  if (!isTRUE(enabled)) return(NULL)
  utils::txtProgressBar(min = 0, max = total, style = 3)
}

update_stash_progress <- function(progress, value) {
  if (!is.null(progress)) utils::setTxtProgressBar(progress, value)
}

close_stash_progress <- function(progress) {
  if (!is.null(progress)) close(progress)
}

validate_progress_bar <- function(progress_bar) {
  if (!is.logical(progress_bar) || length(progress_bar) != 1L || is.na(progress_bar)) {
    stop(".progress_bar must be a single TRUE or FALSE value", call. = FALSE)
  }
  invisible(progress_bar)
}

prepare_stash_query_options <- function(dotargs, return_default) {
  field_supplied <- ".field" %in% names(dotargs)
  if (!field_supplied) dotargs$.field <- return_default

  response <- if (".response" %in% names(dotargs)) dotargs$.response else "data"
  validate_response_mode(response)
  progress_bar <- if (".progress_bar" %in% names(dotargs)) dotargs$.progress_bar else FALSE
  validate_progress_bar(progress_bar)
  if (identical(response, "raw") && field_supplied) {
    stop("`.field` cannot be used with `.response = \"raw\"`", call. = FALSE)
  }

  list(
    field = if (identical(response, "raw")) NA_character_ else dotargs$.field,
    response = response,
    progress_bar = progress_bar
  )
}
