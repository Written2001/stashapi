## Summary

<!-- What changed, and why is it needed? Keep this focused on the user or
	maintainer problem being solved. -->

## Change Type

- [ ] Bug fix
- [ ] Public API change
- [ ] Generated schema/API update
- [ ] Documentation or development workflow
- [ ] Internal maintenance/refactor

## Scope and Compatibility

<!-- Describe affected operations, helpers, response modes, generated files,
	or development workflows. Call out compatibility risk explicitly. -->

- Public API impact: <!-- none / additive / changed / removed -->
- Compatibility notes:
- Known limitations or follow-up work:

## Generated Artifacts

- [ ] No generated artifacts are affected.
- [ ] Generated wrappers and documentation were regenerated with `make roxygen`.
- [ ] Generated changes are included in this pull request.
- [ ] No generated file was edited by hand.

## Documentation

- [ ] User documentation is updated where behavior or public API changed.
- [ ] Contributor/development documentation is updated where workflow changed.
- [ ] `NEWS.md` is updated when the change belongs in a release.

## Validation

- [ ] `make reproducibility-check`
- [ ] `make test`
- [ ] `make schema-source-check`
- [ ] `make lint` (package code and `tools/` R scripts)
- [ ] `make check-package` (package checks via `rcmdcheck`)
- [ ] CI does not require credentials, live Stash data, or network access beyond dependency installation.

## Security and Data

- [ ] No credentials, API keys, private URLs, or live Stash data are included.
- [ ] Any mutation or destructive behavior is covered by explicit tests and documented safety semantics.

## Reviewer Notes

<!-- Add migration guidance, screenshots, sample output, or specific review
	questions when they would make this change easier to evaluate. -->
