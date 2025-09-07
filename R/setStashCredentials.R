the <- base::new.env(parent = base::emptyenv())

#' Check if a Valid Connection to Stash Exists
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
#' has_connection()
#' }
#'
#' @importFrom ghql Query
#' @keywords connection validation
hasConnection <- function(){

  if(!"connection" %in% names(the)){
    return(FALSE)
  }

  query <- ghql::Query$new()
  query$query("validate", "
  query {
    __typename
  }
")

  connection <- tryCatch({
    res <- executeQuery(query = query$queries$validate, variables = list(), connection = the$connection)

    if(names(res) == "value") {
      return(TRUE)
    } else {
      return(FALSE)
    }
  }, error = function(e){
    if(grepl("Unauthorized", e$message)) {
      message("Connection Unauthorized. Check you API key")
      return(FALSE)
    }
    if(grepl("Failed to connect", e$message)) {
      message("Failed to connect to server. Check the endpoint URL")
      return(FALSE)
    }
    if(grepl("lexical error", e$message)) {
      message("Failed to read endpoint. Check the endpoint URL")
      return(FALSE)
    }
  }
  )
  return(connection)
}

#' Set Stash API Credentials from a Credentials File
#'
#' @description Establishes a connection to the Stash GraphQL endpoint using credentials stored in a file.
#'
#' @param stash_credentials Path to the credentials file containing connection details.
#' Defaults to .stash_credentials
#' The file should be a plain text file with two lines: URL and API key.
#'
#' @return Invisibly returns the GraphQL client connection object. Stores the connection in the package environment.
#' @export
#' @examples
#' \dontrun{
#'   # Set credentials from a default or specified credentials file
#'   set_stash_credentials()
#'   set_stash_credentials("path/to/credentials")
#' }
#'
#' @importFrom ghql GraphqlClient
#' @importFrom tools file_path_as_absolute
#'
#' @seealso [has_connection()] for connection validation
#'
#' @keywords connection credentials
setStashCredentials <- function(stash_credentials = ".stash_credentials") {

  if (!is.character(stash_credentials)) {
    stop("stash_credentials must be a character string", call. = FALSE)
  }

  if (length(stash_credentials) != 1) {
    stop("stash_credentials must be a single file path", call. = FALSE)
  }

  if (!file.exists(stash_credentials)) {
    stop("Credentials file does not exist: ", stash_credentials, call. = FALSE)
  }

  path <- tools::file_path_as_absolute(stash_credentials)

  credentials <- tryCatch({
    lines <- readLines(path, warn = FALSE)
    if (length(lines) < 2) {
      stop("Credentials file must contain at least two lines (URL and API key)")
    }
    list(url = trimws(lines[1]), api_key = trimws(lines[2]))
  }, error = function(e) {
    stop("Error reading credentials file: ", e$message, call. = FALSE)
  })

  connection <- tryCatch({
    ghql::GraphqlClient$new(
      url = credentials$url,
      headers = list(ApiKey = credentials$api_key)
    )
  }, error = function(e) {
    stop("Failed to create GraphQL client: ", e$message, call. = FALSE)
  })
  assign("connection", connection, envir = the)
}
