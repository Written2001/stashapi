type_wrapper_kinds <- c("LIST", "NON_NULL")

normalize_argument_table <- function(arguments, max_depth = 20L) {
  if (is.null(arguments) || !is.data.frame(arguments) || nrow(arguments) == 0L) return(list())

  lapply(seq_len(nrow(arguments)), function(index) {
    argument <- arguments[index, , drop = FALSE]
    list(
      name = as.character(argument$name[[1]]),
      description = as.character(argument$description[[1]]),
      type = normalize_type_ref(arguments$type[index, , drop = FALSE], max_depth),
      default_value = as.character(argument$defaultValue[[1]])
    )
  })
}

normalize_field_table <- function(fields, parent_type, field_kind, max_depth = 20L) {
  if (is.null(fields) || !is.data.frame(fields) || nrow(fields) == 0L) return(list())

  lapply(seq_len(nrow(fields)), function(index) {
    field <- fields[index, , drop = FALSE]
    arguments <- if (identical(field_kind, "output")) field$args[[1]] else NULL
    list(
      parent_type = parent_type,
      name = as.character(field$name[[1]]),
      description = as.character(field$description[[1]]),
      type = normalize_type_ref(fields$type[index, , drop = FALSE], max_depth),
      arguments = normalize_argument_table(arguments, max_depth),
      default_value = if (identical(field_kind, "input")) as.character(field$defaultValue[[1]]) else NULL,
      is_deprecated = if ("isDeprecated" %in% names(field)) isTRUE(field$isDeprecated[[1]]) else FALSE,
      deprecation_reason = if ("deprecationReason" %in% names(field)) {
        as.character(field$deprecationReason[[1]])
      } else {
        NA_character_
      },
      field_kind = field_kind
    )
  })
}

normalize_schema_registry <- function(schema_types, max_depth = 20L) {
  if (!is.data.frame(schema_types) || !all(c("kind", "name") %in% names(schema_types))) {
    stop("schema_types must contain kind and name columns", call. = FALSE)
  }

  type_names <- as.character(schema_types$name)
  if (anyNA(type_names) || any(!nzchar(type_names))) {
    stop("schema contains an unnamed type", call. = FALSE)
  }
  if (anyDuplicated(type_names)) {
    stop("schema contains duplicate type names", call. = FALSE)
  }

  registry <- lapply(seq_len(nrow(schema_types)), function(index) {
    schema_type <- schema_types[index, , drop = FALSE]
    type_name <- type_names[[index]]
    fields <- if ("fields" %in% names(schema_type)) schema_type$fields[[1]] else NULL
    input_fields <- if ("inputFields" %in% names(schema_type)) schema_type$inputFields[[1]] else NULL
    possible_types <- if ("possibleTypes" %in% names(schema_type)) schema_type$possibleTypes[[1]] else NULL

    list(
      name = type_name,
      kind = as.character(schema_type$kind[[1]]),
      description = as.character(schema_type$description[[1]]),
      fields = normalize_field_table(fields, type_name, "output", max_depth),
      input_fields = normalize_field_table(input_fields, type_name, "input", max_depth),
      possible_types = if (is.null(possible_types) || nrow(possible_types) == 0L) {
        character()
      } else {
        as.character(possible_types$name)
      },
      enum_values = if (is.null(schema_type$enumValues[[1]]) || nrow(schema_type$enumValues[[1]]) == 0L) {
        character()
      } else {
        as.character(schema_type$enumValues[[1]]$name)
      }
    )
  })

  names(registry) <- type_names
  registry
}

normalize_type_ref <- function(type_ref, max_depth = 20L) {
  normalize_node <- function(node, depth) {
    if (depth > max_depth) {
      stop("GraphQL type reference exceeds the maximum depth", call. = FALSE)
    }

    if (is.null(node) || length(node) == 0L) {
      stop("GraphQL type reference is incomplete", call. = FALSE)
    }

    if (!is.data.frame(node) || nrow(node) != 1L) {
      stop("GraphQL type reference must be a one-row data frame", call. = FALSE)
    }

    kind <- as.character(node$kind[[1]])
    name <- if ("name" %in% names(node)) as.character(node$name[[1]]) else NA_character_
    name <- if (is.na(name) || !nzchar(name)) NULL else name

    if (is.na(kind) || !nzchar(kind)) {
      stop("GraphQL type reference has no kind", call. = FALSE)
    }

    result <- list(kind = kind)
    if (!is.null(name)) result$name <- name

    if (kind %in% type_wrapper_kinds) {
      if (!"ofType" %in% names(node)) {
        stop("GraphQL wrapper type has no ofType", call. = FALSE)
      }
      nested_type <- node$ofType
      if (is.list(nested_type) && !is.data.frame(nested_type)) {
        nested_type <- nested_type[[1]]
      }
      result$of_type <- normalize_node(nested_type, depth + 1L)
    }

    result
  }

  normalize_node(type_ref, 1L)
}

type_ref_named_type <- function(type_ref) {
  if (!is.list(type_ref) || is.null(type_ref$kind)) {
    stop("type_ref must be a normalized GraphQL type", call. = FALSE)
  }

  if (!type_ref$kind %in% type_wrapper_kinds) {
    return(type_ref$name %||% NA_character_)
  }

  type_ref_named_type(type_ref$of_type)
}

type_ref_contains <- function(type_ref, kind) {
  if (!is.list(type_ref) || is.null(type_ref$kind)) {
    stop("type_ref must be a normalized GraphQL type", call. = FALSE)
  }

  if (identical(type_ref$kind, kind)) return(TRUE)
  if (type_ref$kind %in% type_wrapper_kinds) {
    return(type_ref_contains(type_ref$of_type, kind))
  }

  FALSE
}

type_ref_to_string <- function(type_ref) {
  if (!is.list(type_ref) || is.null(type_ref$kind)) {
    stop("type_ref must be a normalized GraphQL type", call. = FALSE)
  }

  if (identical(type_ref$kind, "NON_NULL")) {
    return(paste0(type_ref_to_string(type_ref$of_type), "!"))
  }
  if (identical(type_ref$kind, "LIST")) {
    return(paste0("[", type_ref_to_string(type_ref$of_type), "]"))
  }
  if (is.null(type_ref$name)) {
    stop("GraphQL leaf type has no name", call. = FALSE)
  }

  type_ref$name
}

`%||%` <- function(x, y) {
  if (is.null(x)) y else x
}
