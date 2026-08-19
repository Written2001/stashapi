stash_state <- local({
  connection <- NULL
  list(
    get = function() connection,
    set = function(value) connection <<- value,
    clear = function() connection <<- NULL
  )
})

get_stash_connection <- function() {
  connection <- stash_state$get()
  if (is.null(connection)) {
    connection <- stash_connect()
  }
  connection
}

set_stash_connection <- function(connection) {
  stash_state$set(connection)
  invisible(connection)
}

#' Check if the active Stash connection is valid
#'
#' @description Validates whether a connection to the GraphQL endpoint of Stash can be established and is functional.
#'
#' @return A logical value:
#' - `TRUE` if a valid connection exists
#' - `FALSE` if no connection is found or connection validation fails
#'
#' @export
#' @examples
#' \dontrun{
#' is_stash_connected()
#' }
#'
#' @importFrom ghql Query
#' @keywords connection validation
is_stash_connected <- function() {
  connection <- stash_state$get()
  if (is.null(connection)) return(FALSE)

  query <- ghql::Query$new()
  query$query("validate", "
  query {
    __typename
  }
")

  isTRUE(tryCatch({
    response <- connection$exec(query$queries$validate, variables = list())
    parsed <- jsonlite::fromJSON(response, simplifyVector = FALSE)
    is.list(parsed$data) && identical(parsed$data$`__typename`, "Query") && is.null(parsed$errors)
  }, error = function(error) FALSE))
}

#' Connect to a Stash GraphQL endpoint
#'
#' Credentials are resolved independently in this order: explicit arguments,
#' the credentials file, then environment variables.
#'
#' @param url GraphQL endpoint URL. Falls back to `STASH_URL`.
#' @param api_key Stash API key. Falls back to `STASH_API_KEY`.
#' @param credentials_file Optional two-line credentials file. Defaults to
#'   `.stash_credentials` and is ignored when that default file is absent.
#' @param verify_ssl Whether to verify TLS certificates and hostnames.
#' @param cainfo Optional path to a custom CA certificate bundle.
#' @return Invisibly, the configured connection.
#' @export
#' @examples
#' \dontrun{
#' stash_connect(url = "http://localhost:9999/graphql", api_key = "...")
#' stash_connect(credentials_file = ".stash_credentials", verify_ssl = FALSE)
#' }
#' @importFrom ghql GraphqlClient
#' @importFrom tools file_path_as_absolute
#' @keywords connection credentials
stash_connect <- function(
  url = NULL,
  api_key = NULL,
  credentials_file = ".stash_credentials",
  verify_ssl = TRUE,
  cainfo = NULL
) {
  credentials_file_default <- missing(credentials_file)
  validate_connection_input(url, "url")
  validate_connection_input(api_key, "api_key")
  validate_connection_input(credentials_file, "credentials_file")
  if (!is.logical(verify_ssl) || length(verify_ssl) != 1L || is.na(verify_ssl)) {
    stop("verify_ssl must be a single TRUE or FALSE value", call. = FALSE)
  }
  validate_connection_input(cainfo, "cainfo")

  file_credentials <- read_credentials_file(
    credentials_file,
    optional = credentials_file_default
  )
  url <- first_connection_value(url, file_credentials$url, Sys.getenv("STASH_URL"))
  api_key <- first_connection_value(api_key, file_credentials$api_key, Sys.getenv("STASH_API_KEY"))

  if (is.null(url) || !nzchar(url)) {
    stop("A Stash URL is required via url, credentials_file, or STASH_URL", call. = FALSE)
  }
  if (is.null(api_key) || !nzchar(api_key)) {
    stop("A Stash API key is required via api_key, credentials_file, or STASH_API_KEY", call. = FALSE)
  }

  curl_options <- build_tls_options(verify_ssl, cainfo)
  client <- tryCatch(
    ghql::GraphqlClient$new(url = url, headers = list(ApiKey = api_key)),
    error = function(error) stop("Failed to create GraphQL client: ", error$message, call. = FALSE)
  )
  connection <- new_stash_connection(client, curl_options)
  set_stash_connection(connection)
  invisible(connection)
}

#' Disconnect the active Stash connection
#'
#' @return Invisibly, `TRUE`.
#' @export
stash_disconnect <- function() {
  stash_state$clear()
  invisible(TRUE)
}

validate_connection_input <- function(value, name) {
  if (!is.null(value) && (!is.character(value) || length(value) != 1L || is.na(value))) {
    stop(name, " must be NULL or a single character value", call. = FALSE)
  }
  invisible(value)
}

first_connection_value <- function(...) {
  values <- list(...)
  for (value in values) {
    if (!is.null(value) && nzchar(value)) return(trimws(value))
  }
  NULL
}

read_credentials_file <- function(credentials_file, optional = FALSE) {
  if (is.null(credentials_file)) return(list(url = NULL, api_key = NULL))
  if (!file.exists(credentials_file)) {
    if (isTRUE(optional)) return(list(url = NULL, api_key = NULL))
    stop("Credentials file does not exist: ", credentials_file, call. = FALSE)
  }
  path <- tools::file_path_as_absolute(credentials_file)
  lines <- tryCatch(readLines(path, warn = FALSE), error = function(error) {
    stop("Error reading credentials file: ", error$message, call. = FALSE)
  })
  if (length(lines) < 2L) {
    stop("Credentials file must contain at least two lines (URL and API key)", call. = FALSE)
  }
  list(url = trimws(lines[[1]]), api_key = trimws(lines[[2]]))
}

build_tls_options <- function(verify_ssl, cainfo = NULL) {
  if (!is.null(cainfo) && !file.exists(cainfo)) {
    stop("CA certificate bundle does not exist: ", cainfo, call. = FALSE)
  }
  options <- if (verify_ssl) {
    list(ssl_verifypeer = TRUE, ssl_verifyhost = 2)
  } else {
    list(ssl_verifypeer = FALSE, ssl_verifyhost = 0)
  }
  if (!is.null(cainfo)) options$cainfo <- cainfo
  options
}

new_stash_connection <- function(client, curl_options) {
  structure(
    list(
      exec = function(query, variables = list(), ...) {
        request_options <- modifyList(curl_options, list(...))
        do.call(client$exec, c(list(query = query, variables = variables), request_options))
      }
    ),
    class = "stashapi_connection"
  )
}
