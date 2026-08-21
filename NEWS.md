# stashapi 0.8.2

- Make the pinned Stash SDL the complete package-generation source. A single
	`make generate-sdl` run now regenerates the schema snapshot, provenance,
	wrappers, namespace, manuals, and input helpers.
- Document the Stash schema upgrade workflow and verify generated snapshots,
	wrappers, and documentation against the pinned tag and commit.
- Centralize the offline schema snapshot fixture used by schema contract tests.

# stashapi 0.8.1

- Document the Stash `v0.31.1` schema reference for this release. Generated
	operations follow the pinned schema, including upstream endpoint removals.
- Consolidate response, generated-artifact, and compatibility tests around
	strategic behavioral boundaries without changing package behavior.
- Remove redundant test fixtures and reorganize schema-driven artifact checks
	to reduce test-suite fragmentation while preserving coverage.
- update filters and helper functions documentation for improved clearity and consistency.

# stashapi 0.8.0

- Rename the maintainer-authored query execution implementation to
	`R/execute_query.R` and split its pagination, response decoding, and
	normalization responsibilities into snake_case internal helpers.
- Stabilize generated wrapper execution while preserving response modes,
	pagination, metadata, progress bars, and existing operation contracts.
- Bring the shared execution path to a clean repository lint baseline.
- Restore schema-derived roxygen documentation for generated operations and
	make `make roxygen` regenerate wrappers before manuals.
- Make the common generated-operation options documentation roxygen-owned and
	reproducible.

# stashapi 0.7.0

- Add `prepare_mutations()` for dry-run mutation planning with explicit missing-value policies.
- Add `execute_mutations()` with indexed results, stop/continue error handling, and dry-run defaults.
- Add `tag_descendants()` for server-side traversal of tag hierarchies.
- Replace `hasConnection()` with `is_stash_connected()` and remove the redundant `setStashCredentials()` wrapper.
- Add opt-in progress bars for paginated generated queries and mutation plans.

# stashapi 0.6.0

- Add `wait_for_job()` for polling asynchronous Stash jobs with timeout and terminal-status handling.
- Add snake_case exact-name ID helpers for studios, tags, and performers with explicit multiple-match behavior.
- Add offline tests for helper validation, job polling, and named lookup semantics.

# stashapi 0.5.0

- Remove the legacy GraphQL generator and old/new generator comparison layer.
- Keep the schema-driven generator and generated wrapper/documentation checks as the single source of truth.
- Remove tests that only covered legacy generator internals while retaining schema, artifact, wrapper, and documentation coverage.

# stashapi 0.4.4

- Add a reproducible development container with system libraries, renv-managed runtime and development dependencies, and automatic `languageserver` setup.
- Align Makefile setup and checks with the activated renv project library.
- Clean up schema-driven documentation generator lint issues and keep generated documentation checks deterministic.

# stashapi 0.4.3

- Improve generated filter help examples by selecting meaningful schema fields instead of arbitrary IDs.
- Add readable R input hints alongside GraphQL field types in generated filter documentation.
- Clarify relationship matching semantics for `includes()`, `includes_all()`, and all-membership workflows in the filters vignette.

# stashapi 0.4.2

- Generate curated filter help pages directly from the GraphQL schema, including categorized allowed fields, GraphQL types, and deterministic examples.

# stashapi 0.4.1

- Replace the real StashDB URL in vignette examples with an `endpoint_url` placeholder.

# stashapi 0.4.0

- Make `stash_connect()` discover `.stash_credentials` by default and auto-connect generated API calls when no connection is active.

# stashapi 0.3.0

- Add `stash_connect()` with explicit, credentials-file, and environment-based authentication configuration.
- Add secure TLS verification defaults, custom CA support, and an opt-in `verify_ssl = FALSE` mode for local or self-signed endpoints.
- Replace the exposed global connection environment with private connection state and add `stash_disconnect()`.
- Fix `hasConnection()` to validate the GraphQL `__typename` response and always return a logical value.
- Add `data`, `object`, and `raw` response modes while preserving default tibble/list results and pagination behavior.
- Add structured GraphQL, transport, and response parsing errors.
- Preserve `setStashCredentials()` as a compatibility wrapper.

# stashapi 0.2.0

- Replace the GraphQL wrapper generator with a schema-driven pipeline that preserves legacy operation names and calls.
- Add typed filter helpers for scenes, images, groups, markers, galleries, performers, studios, and tags.
- Add criterion helpers for nullability, comparisons, regular expressions, hierarchy depth, exclusions, and Stash IDs.
- Add recursion-safe fragment generation, required-value validation, schema contract tests, and pkgdown workflow documentation.

# stashapi 0.1.3

- Adopt three-part semantic versioning for package releases.
- Add automated GitHub Release publishing for matching version tags.
