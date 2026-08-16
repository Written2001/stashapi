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
