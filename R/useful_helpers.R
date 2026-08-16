#' Wait for a Stash job to finish
#'
#' Poll a Stash job until it reaches a terminal state. Failed and cancelled
#' jobs are reported as errors, while a completed job is returned.
#'
#' @param job_id Stash job ID.
#' @param check_interval Number of seconds between status checks.
#' @param timeout Maximum number of seconds to wait. `NULL` waits indefinitely.
#' @param verbose Whether to report progress messages.
#' @return The final job object.
#' @export
#' @examples
#' \dontrun{
#' job_id <- metadataScan(input = list(paths = "/data/Images"))
#' wait_for_job(job_id)
#' }
wait_for_job <- function(job_id, check_interval = 60, timeout = NULL, verbose = TRUE) {
  validate_wait_for_job_input(job_id, check_interval, timeout, verbose)
  wait_for_job_impl(job_id, check_interval, timeout, verbose, findJob, Sys.sleep)
}

#' Find a studio ID by exact name
#'
#' @param name Exact studio name.
#' @param multiple How to handle multiple matches: `error`, `first`, or `all`.
#' @return A studio ID, or multiple IDs when `multiple = "all"`.
#' @export
#' @examples
#' \dontrun{
#' find_studio_id("Example Studio")
#' }
find_studio_id <- function(name, multiple = "error") {
  resolve_named_id(
    name,
    multiple,
    findStudios,
    studio_filter(name = equals(name)),
    "studio"
  )
}

#' Find a tag ID by exact name
#'
#' @param name Exact tag name.
#' @param multiple How to handle multiple matches: `error`, `first`, or `all`.
#' @return A tag ID, or multiple IDs when `multiple = "all"`.
#' @export
#' @examples
#' \dontrun{
#' find_tag_id("Example Tag")
#' }
find_tag_id <- function(name, multiple = "error") {
  resolve_named_id(
    name,
    multiple,
    findTags,
    tag_filter(name = equals(name)),
    "tag"
  )
}

#' Find a performer ID by exact name
#'
#' @param name Exact performer name.
#' @param multiple How to handle multiple matches: `error`, `first`, or `all`.
#' @return A performer ID, or multiple IDs when `multiple = "all"`.
#' @export
#' @examples
#' \dontrun{
#' find_performer_id("Example Performer")
#' }
find_performer_id <- function(name, multiple = "error") {
  resolve_named_id(
    name,
    multiple,
    findPerformers,
    performer_filter(name = equals(name)),
    "performer"
  )
}

wait_for_job_impl <- function(job_id, check_interval, timeout, verbose, find_job, sleep) {
  started_at <- Sys.time()
  job <- find_job(input = list(id = job_id))

  repeat {
    status <- toupper(as.character(job$status[[1]]))
    if (status %in% c("FINISHED", "COMPLETED")) return(job)
    if (status %in% c("FAILED", "CANCELLED", "CANCELED")) {
      stop("Stash job ", job_id, " ended with status ", status, call. = FALSE)
    }
    if (!status %in% c("WAITING", "PENDING", "RUNNING")) {
      stop("Stash job ", job_id, " returned unknown status: ", status, call. = FALSE)
    }

    elapsed <- as.numeric(difftime(Sys.time(), started_at, units = "secs"))
    if (!is.null(timeout) && elapsed >= timeout) {
      stop("Timed out waiting for Stash job ", job_id, call. = FALSE)
    }

    if (isTRUE(verbose)) {
      message("Stash job ", job_id, " is still ", status)
    }
    delay <- check_interval
    if (!is.null(timeout)) delay <- min(delay, max(0, timeout - elapsed))
    sleep(delay)
    job <- find_job(input = list(id = job_id))
  }
}

resolve_named_id <- function(name, multiple, finder, filter, entity) {
  if (!is.character(name) || length(name) != 1L || is.na(name) || !nzchar(name)) {
    stop("name must be a single non-empty character value", call. = FALSE)
  }
  valid_multiple <- is.character(multiple) && length(multiple) == 1L &&
    !is.na(multiple) && multiple %in% c("error", "first", "all")
  if (!isTRUE(valid_multiple)) {
    stop("multiple must be one of \"error\", \"first\", or \"all\"", call. = FALSE)
  }

  variables <- list(
    filter = list(per_page = -1),
    .field = c(paste0(entity, "s"), "id")
  )
  variables[[paste0(entity, "filter")]] <- filter
  ids <- do.call(finder, variables)
  ids <- as.character(ids)
  ids <- ids[!is.na(ids)]

  if (length(ids) == 0L) {
    stop("No ", entity, " matched the exact name: ", name, call. = FALSE)
  }
  if (length(ids) > 1L && multiple == "error") {
    stop("Multiple ", entity, "s matched the exact name: ", name, call. = FALSE)
  }
  if (multiple == "first") ids[[1]] else ids
}

validate_wait_for_job_input <- function(job_id, check_interval, timeout, verbose) {
  if (length(job_id) != 1L || is.na(job_id) || !nzchar(as.character(job_id))) {
    stop("job_id must be a single non-empty value", call. = FALSE)
  }
  if (!is.numeric(check_interval) || length(check_interval) != 1L ||
        is.na(check_interval) || check_interval < 0) {
    stop("check_interval must be a single non-negative number", call. = FALSE)
  }
  if (!is.null(timeout) && (!is.numeric(timeout) || length(timeout) != 1L ||
                              is.na(timeout) || timeout < 0)) {
    stop("timeout must be NULL or a single non-negative number", call. = FALSE)
  }
  if (!is.logical(verbose) || length(verbose) != 1L || is.na(verbose)) {
    stop("verbose must be a single TRUE or FALSE value", call. = FALSE)
  }
}
