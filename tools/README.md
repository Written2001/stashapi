# Generator tools

The files in this directory are development tools for building and checking the
package. They are not part of the runtime API in `R/`.

## The short version

The pinned Stash source files are the source of truth. The generator reads those
GraphQL SDL files, builds an internal schema model, and writes R wrappers and
documentation. `inst/extdata/schema.json` is a generated introspection snapshot:
it is useful for reproducibility, compatibility review, and offline tests, but it
is not the original schema source.

The normal commands are:

```sh
make generate-sdl
make reproducibility-check
```

`generate-sdl` updates generated files. `reproducibility-check` repeats the
process in temporary directories and checks that the committed files match.
Make fetches or reuses the pinned Stash checkout. GitHub Actions installs the
Python parser when a workflow needs it; it does not own schema generation.

## Data flow

```text
pinned Stash SDL
      |
      | schema_from_sdl.py
      v
schema.json + provenance
      |
      | schema_loader.R
      v
normalized schema registry
      |
      +--> operation IR --> response policy --> GraphQL renderer
      |                                             |
      |                                             v
      |                                      R wrapper renderer
      |                                             |
      |                                             v
      |                                      R/stashapi_functions.R
      |
      +--> input-builder IR --> input-helper documentation
                                  |
                                  v
                         curated input-helper man/*.Rd

Roxygen reads the generated wrappers and handwritten package code separately
to produce `NAMESPACE` and the operation manuals in `man/`.
```

**SDL** means Schema Definition Language. It is the set of text files that
 describes the types, fields, arguments, and descriptions in Stash's GraphQL
 API.

An **introspection snapshot** is JSON in the shape returned by GraphQL schema
 introspection. It is a machine-readable copy of the schema used by the R
 generator and offline tests.

An **IR** means intermediate representation. It is a structured R record that
contains schema facts before they are rendered as GraphQL text or R source.
Keeping this stage separate lets both renderers use the same operation data.

## Responsibility map

### Source and schema input

| File | Responsibility |
| --- | --- |
| `schema_from_sdl.py` | Finds and reads the selected Stash SDL files with `graphql-core`, writes the introspection snapshot, and optionally writes provenance metadata. |
| `schema_loader.R` | Active generator boundary: accepts either an existing JSON snapshot or an SDL checkout. With an SDL checkout, it invokes `schema_from_sdl.py` and returns the parsed type data. Exactly one input mode is required. |

### Schema model and validation

| File | Responsibility |
| --- | --- |
| `schema_types.R` | Converts introspection types into a named registry and provides type-reference utilities. |
| `schema_validate.R` | Checks R values against GraphQL types, including required values, lists, and nested input objects. |
| `schema_inputs.R` | Builds input-helper metadata and the criterion values used by filter helpers such as `equals()` and `between()`. |

### Operation and query generation

| File | Responsibility |
| --- | --- |
| `schema_operations.R` | Converts Query and Mutation fields into operation IR records. |
| `schema_policy.R` | Chooses response extraction and compact nested selections. Response policy controls returned data; selection policy controls generated GraphQL fields. |
| `schema_selection.R` | Builds the symbolic fragment graph, orders dependencies, and records cycles. |
| `schema_render.R` | Converts an operation and its fragments into GraphQL text. |
| `render_r.R` | Converts the operation and GraphQL text into an R wrapper with documentation and validation. |
| `generate_wrappers.R` | Main wrapper entry point. It loads the schema, builds the registry and operation IR, and combines the renderers into `R/stashapi_functions.R`. |

A **fragment graph** is the set of reusable selections for object, union, and
interface types. Each fragment record contains a name, type condition, selected
fields, referenced fragments, and rendered selection text. Compact selections
avoid expanding common nested objects forever. The dependency resolver detects
cycles, and the renderer removes a cyclic spread edge so every generated query
stays finite.

`build_response_policy()` and `build_selection_policy()` solve different
problems:

- A response policy decides which field a wrapper extracts from a result object,
  such as the list inside a paginated response.
- A selection policy decides which fields a nested object includes in the
  generated GraphQL document.

### Input-helper output

| File | Responsibility |
| --- | --- |
| `render_input_helpers.R` | Renders schema-derived filter/helper functions as source text. It is a reusable renderer exercised by tests; the current Make pipeline uses the separate documentation generator for committed helper manuals. |
| `generate_input_helper_docs.R` | Builds curated input-helper documentation from the schema and writes the corresponding `.Rd` files in `man/`. |

### Verification and support

| File or target | Responsibility |
| --- | --- |
| `check_reproducibility.R` | Regenerates the schema, provenance, wrappers, input-helper manuals, `NAMESPACE`, and operation manuals in temporary locations, then compares them with committed files. |
| `schema_compatibility.py` | Optional comparison between a baseline and candidate introspection snapshot. Use it when reviewing a planned schema-pin change; set `STASH_SCHEMA_BASELINE`. |
| `development_dependencies.R` | Lists R packages used for development checks and documentation. |
| `make schema-environment` | Prints the effective schema tag, commit, and checkout path for debugging. |

## Execution order

1. `make fetch-stash-schema` fetches or reuses the exact Stash tag and commit.
2. `schema_from_sdl.py` parses the SDL once and writes `schema.json` and its provenance.
3. `generate_wrappers.R` loads the snapshot, normalizes the schema, builds operations and selections, and renders wrappers.
4. Roxygen generates the namespace and operation manuals.
5. `generate_input_helper_docs.R` writes the curated filter-helper manuals.
6. `check_reproducibility.R` repeats these operations in temporary locations when `make reproducibility-check` runs.

Most files in this directory are building blocks used by the generator scripts;
they are loaded by those scripts rather than run on their own. The main scripts
that are run directly are `schema_from_sdl.py`, `generate_wrappers.R`,
`generate_input_helper_docs.R`, and `check_reproducibility.R`.

These tools are used while developing the package. When the package is
installed, users run the generated code and documentation in `R/`, `NAMESPACE`,
and `man/`; they do not run the files in `tools/`.

## Schema upgrades

To move to a new Stash version, change both schema pin values in the
`Makefile`, run `make generate-sdl`, inspect the generated diff, and run
`make reproducibility-check`. For an explicit before-and-after compatibility
review, also run:

```sh
STASH_SCHEMA_BASELINE=path/to/baseline.json make schema-compatibility-check
```

The compatibility check is optional and is different from reproducibility: it
asks what changed between two schema versions, while reproducibility asks
whether committed generated files still match the pinned source.
