# Contributing

## Getting Started

You need R, the package dependencies managed by `renv`, and a working R
package toolchain. A Stash server or credentials are not required for the
development checks.

From the repository root, restore the development environment before making
changes:

```sh
make setup
```

This runs `renv::restore(prompt = FALSE)` and is also the command used when
the development container is created. If `make` is unavailable, the
equivalent R command is:

```sh
Rscript -e 'renv::restore(prompt = FALSE)'
```

The usual contribution loop is:

1. Make a focused change.
2. Add or update a focused test.
3. Regenerate artifacts when the schema or generator behavior is involved.
4. Run `make ci`.
5. Review the generated changes and the compatibility impact before opening a
	PR.

Schema compatibility is an opt-in release review. Supply an explicit baseline
to `make schema-compatibility-check` when changing the pinned Stash schema.

## What To Edit

The pinned Stash SDL checkout is the source for generated GraphQL wrappers and
their manuals. `inst/extdata/schema.json` is a generated introspection snapshot
from that same checkout. Generated wrapper, snapshot, and input-helper
documentation must not be edited by hand. Change the relevant generator or
pinned schema source and then run `make generate-sdl` to refresh all derived
files. See [`tools/README.md`](../tools/README.md) for the responsibility of
each generator component.

Handwritten R helpers, tests, vignettes, and development scripts can be edited
directly. Keep generated changes in the same contribution as the source
change, and use `make reproducibility-check` to catch drift.

Generated operation names retain the GraphQL spelling, such as
`findScenes()` and `sceneUpdate()`. User-facing helper functions use
snake_case, such as `scene_filter()`, `find_studio_id()`, and
`prepare_mutations()`. Preserve these conventions when adding APIs: generated
wrappers mirror the schema, while handwritten helpers describe higher-level R
workflows.

## Updating the Stash schema

To update the package to a new Stash release, change both
`STASH_SCHEMA_TAG` and `STASH_SCHEMA_COMMIT` in the Makefile, then run:

```sh
make generate-sdl
```

This fetches the exact commit, regenerates `schema.json` and its provenance,
and regenerates wrappers, the namespace, manuals, and input-helper
documentation. `make reproducibility-check` rejects stale generated files; it
does not reject a new Stash version when all artifacts have been regenerated.

The Makefile owns the pinned Stash checkout. GitHub Actions only installs the
Python SDL parser before invoking Make. The parser and checkout are separate:
test and coverage jobs install the parser without fetching Stash, while build
and release jobs let `make reproducibility-check` fetch or reuse the pinned
checkout. Generation and reproducibility checks need network access when that
checkout is not already available; neither requires a Stash server or API
credentials.

Review the resulting diff and run `make schema-compatibility-check` with an
explicit baseline before releasing when the package changes its pinned schema.
Upstream additions and deprecations are reflected in the generated API. An
upstream removal is also reflected by removing the corresponding generated
wrapper and manual, and must be treated as a release compatibility change.

## Before a PR

```sh
make ci
```

This runs the generated-artifact and documentation reproducibility check,
tests, lint, and `R CMD check`. It does
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

Wrappers and manuals are generated from the pinned SDL checkout identified by
`STASH_SCHEMA_TAG` and `STASH_SCHEMA_COMMIT` in the Makefile.

```sh
make generate-sdl         # regenerate from the pinned Stash checkout
make reproducibility-check # verify all generated artifacts and documentation
```

`make generate-sdl` and `make reproducibility-check` both fetch or reuse the
checkout identified by `STASH_SCHEMA_TAG` and `STASH_SCHEMA_COMMIT`. The
reproducibility check writes regenerated artifacts to temporary locations and
does not modify the working tree.

The reproducibility check is also run by `make ci`, and can be run locally
whenever you want to verify a clean generated state. Commit generated changes
with the source change. Do not edit generated files by hand. If the check
fails, first run `make generate-sdl`, then rerun the check. A remaining
mismatch usually means the generator, schema, or checked-in artifact needs to
be updated together.

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
