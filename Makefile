RSCRIPT ?= Rscript
PYTHON ?= python3
STASH_SCHEMA_TAG ?= v0.31.1
STASH_SCHEMA_COMMIT ?= 4de2351e7cc990d7ccd7cb6c84c275cd53bf6e55
STASH_SOURCE_ROOT ?= /tmp/stashapi-stash-$(STASH_SCHEMA_TAG)
STASH_SCHEMA_COMPATIBILITY_OUTPUT ?= /tmp/stashapi-schema-compatibility.json
STASHAPI_VERSION ?= $(shell sed -n 's/^Version: *//p' DESCRIPTION)

.PHONY: setup test schema-source-check schema-compatibility-check schema-environment fetch-stash-schema generate-sdl reproducibility-check generate-check documentation-check lint coverage build check check-package docs roxygen ci

setup:
	Rscript -e 'renv::activate(); renv::restore(prompt = FALSE)'

test:
	$(RSCRIPT) -e 'testthat::test_local()'

schema-source-check:
	$(PYTHON) -m unittest discover -s tests/python -p 'test_*.py'

schema-compatibility-check:
	@test -n "$(STASH_SCHEMA_BASELINE)" || (echo "STASH_SCHEMA_BASELINE is required"; exit 1)
	$(PYTHON) tools/schema_compatibility.py --baseline "$(STASH_SCHEMA_BASELINE)" --candidate inst/extdata/schema.json --output "$(STASH_SCHEMA_COMPATIBILITY_OUTPUT)"

# Print the effective schema settings when debugging a local generation run.
schema-environment:
	@printf 'STASH_SCHEMA_TAG=%s\n' '$(STASH_SCHEMA_TAG)'
	@printf 'STASH_SCHEMA_COMMIT=%s\n' '$(STASH_SCHEMA_COMMIT)'
	@printf 'STASH_SOURCE_ROOT=%s\n' '$(STASH_SOURCE_ROOT)'

fetch-stash-schema:
	@if test -d "$(STASH_SOURCE_ROOT)/.git" && test "$$(git -C "$(STASH_SOURCE_ROOT)" rev-parse HEAD 2>/dev/null)" = "$(STASH_SCHEMA_COMMIT)"; then \
		echo "Using pinned Stash checkout $(STASH_SCHEMA_COMMIT)"; \
	else \
		if test -d "$(STASH_SOURCE_ROOT)/.git"; then \
			git -C "$(STASH_SOURCE_ROOT)" fetch --quiet origin "$(STASH_SCHEMA_TAG)"; \
		else \
			git clone --quiet --filter=blob:none --no-checkout --branch "$(STASH_SCHEMA_TAG)" https://github.com/stashapp/stash.git "$(STASH_SOURCE_ROOT)"; \
		fi; \
		git -C "$(STASH_SOURCE_ROOT)" checkout --quiet "$(STASH_SCHEMA_COMMIT)"; \
	fi

generate-sdl: fetch-stash-schema
	@test -n "$(STASH_SOURCE_ROOT)" || (echo "STASH_SOURCE_ROOT is required"; exit 1)
	$(PYTHON) tools/schema_from_sdl.py --source-root "$(STASH_SOURCE_ROOT)" --output inst/extdata/schema.json --provenance-output inst/extdata/schema.provenance.json --ref "$(STASH_SCHEMA_TAG)" --commit "$(STASH_SCHEMA_COMMIT)" --package-version "$(STASHAPI_VERSION)" --artifact inst/extdata/schema.json
	$(RSCRIPT) tools/generate_wrappers.R R/stashapi_functions.R --schema inst/extdata/schema.json
	$(RSCRIPT) -e 'roxygen2::roxygenise()'
	$(RSCRIPT) tools/generate_input_helper_docs.R --schema inst/extdata/schema.json man

reproducibility-check: fetch-stash-schema
	PYTHON="$(PYTHON)" STASH_SOURCE_ROOT="$(STASH_SOURCE_ROOT)" STASH_SCHEMA_TAG="$(STASH_SCHEMA_TAG)" STASH_SCHEMA_COMMIT="$(STASH_SCHEMA_COMMIT)" $(RSCRIPT) tools/check_reproducibility.R

generate-check documentation-check: reproducibility-check

lint:
	$(RSCRIPT) -e 'lintr::lint_package()'

coverage:
	$(RSCRIPT) -e 'coverage <- covr::package_coverage(); writeLines(capture.output(print(coverage)), "coverage.txt")'

build: reproducibility-check
	$(RSCRIPT) -e 'status <- system2("R", c("CMD", "build", ".")); quit(status = status)'

check-package:
	$(RSCRIPT) -e 'rcmdcheck::rcmdcheck(args = "--no-manual", error_on = "error")'

check: reproducibility-check check-package

docs: reproducibility-check
	$(RSCRIPT) -e 'pkgdown::build_site(preview = FALSE)'

roxygen:
	$(MAKE) generate-sdl

ci: reproducibility-check test lint check-package
