# Contributing

## Getting Started

You need R, the package dependencies managed by `renv`, and a working R
package toolchain. A Stash server or credentials are not required for the
development checks.

From the repository root, restore the development environment before making
changes:

```sh
Rscript -e 'renv::restore()'
```

The usual contribution loop is:

1. Make a focused change.
2. Add or update a focused test.
3. Regenerate artifacts when the schema or generator behavior is involved.
4. Run `make ci`.
5. Review the generated changes and the compatibility impact before opening a
	PR.

## What To Edit

`inst/extdata/schema.json` is the source for generated GraphQL wrappers and
their manuals. The wrapper and input-helper documentation generated from it
must not be edited by hand. Change the relevant generator and
then run `make roxygen` to refresh the derived files.

Handwritten R helpers, tests, vignettes, and development scripts can be edited
directly. Keep generated changes in the same contribution as the source
change, and use `make generate-check` to catch drift.

Generated operation names retain the GraphQL spelling, such as
`findScenes()` and `sceneUpdate()`. User-facing helper functions use
snake_case, such as `scene_filter()`, `find_studio_id()`, and
`prepare_mutations()`. Preserve these conventions when adding APIs: generated
wrappers mirror the schema, while handwritten helpers describe higher-level R
workflows.

## Before a PR

```sh
make ci
```

This runs generated-artifact checks, tests, lint, and `R CMD check`. It does
not require Stash credentials or live data.

Run it from the repository root. A successful run should finish with zero
errors, warnings, and notes. Messages about an out-of-sync `renv` environment
mean dependencies should be restored; missing `pdflatex` only prevents PDF
manual generation and is not required by the documented `R CMD check`.

For documentation or site changes:

```sh
make docs
```

## Generated Files

Wrappers and manuals are generated from `inst/extdata/schema.json`.

```sh
make roxygen              # regenerate
make generate-check       # verify wrappers and input manuals
make documentation-check  # verify all generated documentation
```

Commit generated changes with the source change. Do not edit generated files
by hand. If a generated check fails, first run `make roxygen`, then rerun the
check. A remaining mismatch usually means the generator, schema, or checked-in
artifact needs to be updated together.

## Documentation Changes

Update the relevant vignette or README when a public workflow changes. Run:

```sh
make docs
```

This is in addition to `make ci` when the change affects package behavior.

Before opening a PR, confirm that examples do not require live credentials,
private URLs, or persistent local data. Use fake data and `eval=FALSE` for
examples that intentionally demonstrate live mutations.

## PR Guidelines

- Explain the change and its compatibility impact.
- Add focused tests for behavior or generator changes.
- Update user or development documentation when needed.
- Keep credentials, private URLs, and live data out of commits and CI.

## Releases

Update `DESCRIPTION` and `NEWS.md`, then push a matching semantic-version tag:

```sh
git tag vMAJOR.MINOR.PATCH
git push origin vMAJOR.MINOR.PATCH
```
