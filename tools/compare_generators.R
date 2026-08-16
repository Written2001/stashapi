#' Build a normalized contract from the legacy generator model.
#'
#' @param legacy_environment Environment after sourcing build_schema.R.
#' @return A named list of operation contracts.
#' @noRd
legacy_operation_contract <- function(legacy_environment) {
  requests <- legacy_environment$schema_requests
  contracts <- lapply(seq_len(nrow(requests)), function(index) {
    request <- requests[index, , drop = FALSE]
    arguments <- request$arg_types[[1]]
    list(
      name = request$name,
      operation_kind = tolower(request$object_name),
      arguments = if (nrow(arguments) == 0L) character() else as.character(arguments$name),
      r_arguments = if (nrow(arguments) == 0L) character() else as.character(arguments$san_name),
      return_class = if (isTRUE(request$is_object[[1]]) || isTRUE(request$is_union[[1]])) {
        "OBJECTLIKE"
      } else {
        "LEAF"
      },
      return_named_type = as.character(request$type_name),
      response_field = as.character(request$return_object),
      request = as.character(request$request)
    )
  })
  names(contracts) <- vapply(contracts, function(contract) contract$name, character(1))
  contracts
}

#' Build a normalized contract from the new operation IR.
#'
#' @param operations Named operation IR records.
#' @return A named list of operation contracts.
#' @noRd
new_operation_contract <- function(operations) {
  contracts <- lapply(operations, function(operation) {
    list(
      name = operation$name,
      operation_kind = operation$operation_kind,
      arguments = vapply(operation$arguments, function(argument) argument$name, character(1)),
      r_arguments = vapply(operation$arguments, function(argument) argument$r_name, character(1)),
      return_class = if (operation$selection_kind %in% c("OBJECT", "UNION", "INTERFACE")) {
        "OBJECTLIKE"
      } else {
        "LEAF"
      },
      return_named_type = operation$return_named_type,
      response_field = as.character(operation$response_policy$default_field)
    )
  })
  names(contracts) <- vapply(contracts, function(contract) contract$name, character(1))
  contracts
}

#' Compare two normalized operation-contract collections.
#'
#' @param legacy_contract Legacy operation contracts.
#' @param new_contract New operation contracts.
#' @return A list of missing, added, and field-level differences.
#' @noRd
compare_operation_contracts <- function(legacy_contract, new_contract) {
  legacy_names <- names(legacy_contract)
  new_names <- names(new_contract)
  common_names <- intersect(legacy_names, new_names)

  differences <- lapply(common_names, function(name) {
    old <- legacy_contract[[name]]
    new <- new_contract[[name]]
    fields <- c("operation_kind", "arguments", "r_arguments", "return_class", "return_named_type", "response_field")
    mismatches <- fields[!vapply(fields, function(field) identical(old[[field]], new[[field]]), logical(1))]
    if (length(mismatches) == 0L) return(NULL)
    list(name = name, fields = mismatches, legacy = old, new = new)
  })

  list(
    missing_from_new = setdiff(legacy_names, new_names),
    added_in_new = setdiff(new_names, legacy_names),
    differences = Filter(Negate(is.null), differences)
  )
}

#' Run the old/new generator contract comparison from the checked-in schema.
#'
#' @param package_root Repository root.
#' @return Comparison report containing both contracts and differences.
#' @noRd
compare_generators <- function(package_root = ".") {
  old_environment <- new.env(parent = globalenv())
  new_environment <- new.env(parent = globalenv())
  previous_directory <- setwd(package_root)
  on.exit(setwd(previous_directory), add = TRUE)

  sys.source("tools/build_schema.R", envir = old_environment)
  sys.source("tools/schema_types.R", envir = new_environment)
  sys.source("tools/schema_policy.R", envir = new_environment)
  sys.source("tools/schema_operations.R", envir = new_environment)

  raw_schema <- jsonlite::fromJSON("inst/extdata/schema.json", flatten = FALSE)$data$`__schema`$types
  registry <- new_environment$normalize_schema_registry(raw_schema)
  operations <- new_environment$build_operation_ir(registry)

  legacy_contract <- legacy_operation_contract(old_environment)
  new_contract <- new_operation_contract(operations)
  list(
    legacy = legacy_contract,
    new = new_contract,
    comparison = compare_operation_contracts(legacy_contract, new_contract)
  )
}
