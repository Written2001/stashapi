# Contributing

## Local checks

Before opening a pull request, run the package tests, generated-wrapper check, lint, and `R CMD check` locally. The required CI checks do not need a Stash instance, credentials, or network access.

On systems with `make`, the common checks are available through the Makefile:

```sh
make ci
make coverage
make docs
```

The Makefile is a convenience layer; the underlying R commands remain the source of truth and are also usable directly on Windows.

```r
testthat::test_local()
```

```sh
Rscript --vanilla tools/check_generated.R
R CMD check --no-manual .
```

## Generated wrappers

The public GraphQL wrappers in `R/stashapi_functions.R` are generated from `inst/extdata/schema.json` by `tools/build_functions.R`. Update the schema fixture and generator inputs deliberately, regenerate the wrappers, and include the generated changes in the same pull request.

Do not hand-edit generated wrapper functions or their generated man pages.

## Pull requests

- Explain the behavior or infrastructure change.
- Add or update tests, especially schema-to-wrapper contract tests for generator changes.
- Update documentation when the public API or development workflow changes.
- Keep credentials and live Stash data out of commits and CI logs.

This project is distributed from GitHub and is not intended for CRAN publication.

## Releases

Use three-part semantic versions in `DESCRIPTION` and matching tags in the `vMAJOR.MINOR.PATCH` format. Update `NEWS.md` with the release changes, then push the matching tag to start the release workflow.

For example:

```sh
git tag v0.1.3
git push origin v0.1.3
```
