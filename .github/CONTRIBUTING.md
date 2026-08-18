# Contributing

## Before a PR

```sh
make ci
```

This runs generated-artifact checks, tests, lint, and `R CMD check`. It does
not require Stash credentials or live data.

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
by hand.

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
