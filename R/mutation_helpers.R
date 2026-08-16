#' Prepare a safe mutation plan
#'
#' Build and normalize one GraphQL input per source row without contacting
#' Stash. The builder controls the mutation input and its field semantics.
#'
#' @param data A data frame or list of source rows.
#' @param build_input Function called as `build_input(row, index)`.
#' @param na Missing-value policy: `"omit"` or `"error"`.
#' @param null NULL-value policy: `"omit"` or `"error"`.
#' @param operation Optional label for the plan.
#' @return An object of class `stashapi_mutation_plan`.
#' @export
prepare_mutations <- function(
  data,
  build_input,
  na = "omit",
  null = "omit",
  operation = NULL
) {
  validate_mutation_plan_inputs(data, build_input, na, null, operation)
  rows <- mutation_source_rows(data)
  entries <- lapply(seq_along(rows), function(index) {
    input <- tryCatch(
      build_input(rows[[index]], index),
      error = function(error) {
        stop("Failed to build mutation input for row ", index, ": ", error$message, call. = FALSE)
      }
    )
    if (!is.list(input) || is.null(names(input)) || any(!nzchar(names(input)))) {
      stop("Mutation input for row ", index, " must be a named list", call. = FALSE)
    }
    normalized <- normalize_mutation_value(input, na, null)
    if (isTRUE(normalized$omitted)) {
      stop("Mutation input for row ", index, " is empty after normalization", call. = FALSE)
    }
    list(
      index = index,
      input = normalized$value,
      omitted = normalized$omitted_paths,
      target = mutation_target(normalized$value)
    )
  })
  structure(
    list(entries = entries, operation = operation, source_size = length(rows)),
    class = "stashapi_mutation_plan"
  )
}

#' Execute a mutation plan
#'
#' Execute one mutation call per prepared input. Dry-run is the default and
#' makes no API calls.
#'
#' @param plan A `stashapi_mutation_plan` from [prepare_mutations()].
#' @param mutate Function accepting `input = ...`, such as `galleryUpdate`.
#' @param dry_run Whether to skip mutation calls and return a preview.
#' @param on_error Error policy: `"stop"` or `"continue"`.
#' @param progress Whether to report each mutation.
#' @return An object of class `stashapi_mutation_result`.
#' @export
execute_mutations <- function(
  plan,
  mutate,
  dry_run = TRUE,
  on_error = "stop",
  progress = TRUE
) {
  validate_mutation_execution(plan, mutate, dry_run, on_error, progress)
  results <- vector("list", length(plan$entries))
  for (position in seq_along(plan$entries)) {
    entry <- plan$entries[[position]]
    if (isTRUE(progress)) message("Mutation row ", entry$index)
    if (isTRUE(dry_run)) {
      results[[position]] <- mutation_result_entry(entry, "planned", NULL, NULL)
      next
    }
    result <- tryCatch(
      list(value = mutate(input = entry$input), error = NULL),
      error = function(error) list(value = NULL, error = error)
    )
    if (!is.null(result$error)) {
      failure <- mutation_result_entry(entry, "failed", NULL, result$error)
      if (identical(on_error, "stop")) {
        stop_mutation_execution(entry, result$error, c(results[seq_len(position - 1L)], list(failure)))
      }
      results[[position]] <- failure
      next
    }
    results[[position]] <- mutation_result_entry(entry, "succeeded", result$value, NULL)
  }
  structure(
    list(results = results, dry_run = dry_run, operation = plan$operation),
    class = "stashapi_mutation_result"
  )
}

mutation_source_rows <- function(data) {
  if (is.data.frame(data)) {
    return(lapply(seq_len(nrow(data)), function(index) as.list(data[index, , drop = FALSE])))
  }
  if (is.list(data)) return(data)
  stop("data must be a data frame or list", call. = FALSE)
}

normalize_mutation_value <- function(value, na, null, path = NULL) {
  if (is.null(value)) {
    if (identical(null, "error")) stop_mutation_missing(path, "NULL")
    return(list(value = NULL, omitted = TRUE, omitted_paths = path))
  }
  if (is.atomic(value)) {
    missing <- is.na(value)
    if (any(missing)) {
      if (identical(na, "error")) stop_mutation_missing(path, "NA")
      if (length(value) == 1L) return(list(value = NULL, omitted = TRUE, omitted_paths = path))
      value <- value[!missing]
    }
    return(list(value = value, omitted = FALSE, omitted_paths = character()))
  }
  if (!is.list(value)) {
    stop("Mutation input contains an unsupported value at ", mutation_path(path), call. = FALSE)
  }
  if (length(value) > 0L && (is.null(names(value)) || any(!nzchar(names(value))))) {
    stop("Mutation input contains an unnamed list at ", mutation_path(path), call. = FALSE)
  }
  result <- list()
  omitted_paths <- character()
  for (name in names(value)) {
    child <- normalize_mutation_value(value[[name]], na, null, c(path, name))
    if (isTRUE(child$omitted)) {
      omitted_paths <- c(omitted_paths, child$omitted_paths)
    } else {
      result[[name]] <- child$value
      omitted_paths <- c(omitted_paths, child$omitted_paths)
    }
  }
  list(
    value = result,
    omitted = length(result) == 0L,
    omitted_paths = omitted_paths
  )
}

mutation_target <- function(input) {
  if (!is.null(input$id)) return(input$id)
  if (!is.null(input$ids)) return(input$ids)
  NULL
}

mutation_result_entry <- function(entry, status, value, error) {
  list(
    index = entry$index,
    target = entry$target,
    status = status,
    result = value,
    error = error,
    input = entry$input,
    omitted = entry$omitted
  )
}

validate_mutation_plan_inputs <- function(data, build_input, na, null, operation) {
  if (!is.data.frame(data) && !is.list(data)) stop("data must be a data frame or list", call. = FALSE)
  if (!is.function(build_input)) stop("build_input must be a function", call. = FALSE)
  if (!is.character(na) || length(na) != 1L || !na %in% c("omit", "error")) {
    stop("na must be \"omit\" or \"error\"", call. = FALSE)
  }
  if (!is.character(null) || length(null) != 1L || !null %in% c("omit", "error")) {
    stop("null must be \"omit\" or \"error\"", call. = FALSE)
  }
  if (!is.null(operation) && (!is.character(operation) || length(operation) != 1L || is.na(operation))) {
    stop("operation must be NULL or a single character value", call. = FALSE)
  }
}

validate_mutation_execution <- function(plan, mutate, dry_run, on_error, progress) {
  if (!inherits(plan, "stashapi_mutation_plan")) stop("plan must come from prepare_mutations()", call. = FALSE)
  if (!is.function(mutate)) stop("mutate must be a function", call. = FALSE)
  if (!is.logical(dry_run) || length(dry_run) != 1L || is.na(dry_run)) {
    stop("dry_run must be a single TRUE or FALSE value", call. = FALSE)
  }
  if (!is.character(on_error) || length(on_error) != 1L || !on_error %in% c("stop", "continue")) {
    stop("on_error must be \"stop\" or \"continue\"", call. = FALSE)
  }
  if (!is.logical(progress) || length(progress) != 1L || is.na(progress)) {
    stop("progress must be a single TRUE or FALSE value", call. = FALSE)
  }
}

stop_mutation_missing <- function(path, value) {
  stop("Mutation input contains ", value, " at ", mutation_path(path), call. = FALSE)
}

mutation_path <- function(path) {
  if (length(path) == 0L) "the root input" else paste(path, collapse = ".")
}

stop_mutation_execution <- function(entry, error, results) {
  condition <- structure(
    list(
      message = paste0("Mutation failed for row ", entry$index, ": ", error$message),
      call = NULL,
      index = entry$index,
      partial_results = results,
      original_error = error
    ),
    class = c("stashapi_mutation_error", "error", "condition")
  )
  stop(condition)
}

print.stashapi_mutation_plan <- function(x, ...) {
  cat("stashapi mutation plan")
  if (!is.null(x$operation)) cat(" (", x$operation, ")", sep = "")
  cat("\n")
  print(mutation_plan_summary(x$entries), ...)
  invisible(x)
}

print.stashapi_mutation_result <- function(x, ...) {
  cat("stashapi mutation result (dry_run = ", x$dry_run, ")\n", sep = "")
  print(mutation_result_summary(x$results), ...)
  invisible(x)
}

mutation_plan_summary <- function(entries) {
  tibble::tibble(
    index = vapply(entries, `[[`, integer(1), "index"),
    target = vapply(entries, function(entry) compact_mutation_target(entry$target), character(1)),
    fields = vapply(entries, function(entry) paste(names(entry$input), collapse = ", "), character(1)),
    omitted = vapply(entries, function(entry) paste(entry$omitted, collapse = ", "), character(1))
  )
}

mutation_result_summary <- function(results) {
  tibble::tibble(
    index = vapply(results, `[[`, integer(1), "index"),
    target = vapply(results, function(entry) compact_mutation_target(entry$target), character(1)),
    status = vapply(results, `[[`, character(1), "status"),
    fields = vapply(results, function(entry) paste(names(entry$input), collapse = ", "), character(1)),
    error = vapply(results, function(entry) {
      if (is.null(entry$error)) "" else conditionMessage(entry$error)
    }, character(1))
  )
}

compact_mutation_target <- function(target) {
  if (is.null(target) || length(target) == 0L) return("")
  values <- paste(as.character(target), collapse = ", ")
  if (nchar(values) > 40L) paste0(substr(values, 1L, 37L), "...") else values
}
