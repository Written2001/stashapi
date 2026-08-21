# Stashapi
`stashapi` is an R client for the [Stash](https://github.com/stashapp/stash)
GraphQL API. It combines schema-generated Stash operations with typed R input
helpers for querying, filtering, and planning mutations against a local Stash
instance.

## Start here

- [Pkgdown documentation](https://written2001.github.io/stashapi) for the full
  function reference and user guides
- [Filters and input builders](vignettes/filters-and-input-builders.Rmd) for
  typed query filters
- [Mutation plans](vignettes/mutation-plans.Rmd) for previewing batch changes
- [News](NEWS.md) for release history

## Stash compatibility

Generated operations are tied to the pinned upstream schema. The `stashapi`
0.8.2 release is generated from Stash `v0.31.1`, commit
`4de2351e7cc990d7ccd7cb6c84c275cd53bf6e55`. A later Stash schema may add,
deprecate, or remove operations; regenerate and review the compatibility report
before assigning a new Stash reference to a `stashapi` release.

## Installation

Install the development version directly from GitHub:

```r
remotes::install_github("Written2001/stashapi")
# or
renv::install("https://github.com/Written2001/stashapi")
```

## Connect to Stash

Create a connection with explicit credentials:

```r
library(stashapi)

stash_connect(
  url = "http://localhost:9999/graphql",
  api_key = Sys.getenv("STASH_API_KEY")
)
```

For local development, `stash_connect()` can read a two-line
`.stash_credentials` file containing the GraphQL URL followed by the API key.
For CI or other managed environments, set `STASH_URL` and `STASH_API_KEY`.
Credential resolution is ordered as explicit arguments, credentials file,
then environment variables. Use `is_stash_connected()` to validate the active
connection and `stash_disconnect()` to clear it.

TLS verification is enabled by default. Disable it only for a trusted local
endpoint with a self-signed certificate.

## Examples

Generated operations retain the names used by Stash's GraphQL schema. Typed
helpers make common filters easier to read and validate:

```r
# Find scenes tagged with ID 182, returning up to 50 results.
scenes <- findScenes(
  scenefilter = scene_filter(tags = includes(182)),
  filter = find_filter(per_page = 50)
)

# Fetch only the count for a query before requesting all matching records.
findPerformers(
  performerfilter = performer_filter(name = includes("example")),
  .field = "count"
)
```

The response interface supports regular data, metadata-bearing objects, and
raw GraphQL envelopes:

```r
result <- findScenes(.response = "object")
result$data
result$meta
```

Mutations change the Stash database. Build and inspect a plan first; execution
is a dry run unless explicitly enabled:

```r
plan <- prepare_mutations(
  data = data.frame(id = c("41", "42"), organized = TRUE),
  build_input = function(row, index) {
    list(id = row$id, organized = row$organized)
  }
)

preview <- execute_mutations(plan, mutate = sceneUpdate)
```

Consult the [Stash GraphQL playground](http://localhost:9999/playground) for
the schema and operation-specific input fields available on your instance.

## Development

Development dependencies are managed with `renv`:

```sh
make setup
make test
make ci
```

See [CONTRIBUTING.md](.github/CONTRIBUTING.md) for generated-file rules,
release workflow, and additional development checks.
