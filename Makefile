RSCRIPT ?= Rscript
PYTHON ?= python3
STASH_SCHEMA_TAG ?= v0.31.1
STASH_SCHEMA_COMMIT ?= 4de2351e7cc990d7ccd7cb6c84c275cd53bf6e55
STASH_SOURCE_ROOT ?= /tmp/stashapi-stash-$(STASH_SCHEMA_TAG)
STASH_SCHEMA_COMPATIBILITY_OUTPUT ?= /tmp/stashapi-schema-compatibility.json
STASHAPI_VERSION ?= $(shell sed -n 's/^Version: *//p' DESCRIPTION)

.PHONY: setup test schema-source-check schema-compatibility-check schema-environment fetch-stash-schema generate-sdl generate-check documentation-check lint coverage build check check-package docs roxygen ci

setup:
	Rscript -e 'renv::activate(); renv::restore(prompt = FALSE)'

test:
	$(RSCRIPT) -e 'testthat::test_local()'

schema-source-check:
	$(PYTHON) -m unittest discover -s tests/python -p 'test_*.py'

schema-compatibility-check:
	@test -n "$(STASH_SCHEMA_BASELINE)" || (echo "STASH_SCHEMA_BASELINE is required"; exit 1)
	$(PYTHON) tools/schema_compatibility.py --baseline "$(STASH_SCHEMA_BASELINE)" --candidate inst/extdata/schema.json --output "$(STASH_SCHEMA_COMPATIBILITY_OUTPUT)"

schema-environment:
	@printf 'STASH_SCHEMA_TAG=%s\n' '$(STASH_SCHEMA_TAG)'
	@printf 'STASH_SCHEMA_COMMIT=%s\n' '$(STASH_SCHEMA_COMMIT)'
	@printf 'STASH_SOURCE_ROOT=%s\n' '$(STASH_SOURCE_ROOT)'

fetch-stash-schema:
	rm -rf "$(STASH_SOURCE_ROOT)"
	git clone --quiet --filter=blob:none --no-checkout --branch "$(STASH_SCHEMA_TAG)" https://github.com/stashapp/stash.git "$(STASH_SOURCE_ROOT)"
	git -C "$(STASH_SOURCE_ROOT)" checkout --quiet "$(STASH_SCHEMA_COMMIT)"

generate-sdl: fetch-stash-schema
	@test -n "$(STASH_SOURCE_ROOT)" || (echo "STASH_SOURCE_ROOT is required"; exit 1)
	$(PYTHON) tools/schema_from_sdl.py --source-root "$(STASH_SOURCE_ROOT)" --output inst/extdata/schema.json --provenance-output inst/extdata/schema.provenance.json --ref "$(STASH_SCHEMA_TAG)" --commit "$(STASH_SCHEMA_COMMIT)" --package-version "$(STASHAPI_VERSION)" --artifact inst/extdata/schema.json
	$(RSCRIPT) tools/generate_wrappers.R R/stashapi_functions.R $(STASH_SOURCE_ROOT) $(STASH_SCHEMA_TAG)
	$(RSCRIPT) -e 'roxygen2::roxygenise()'
	$(RSCRIPT) tools/generate_input_helper_docs.R /dev/null man $(STASH_SOURCE_ROOT)

generate-check: fetch-stash-schema
	PYTHON="$(PYTHON)" STASH_SOURCE_ROOT="$(STASH_SOURCE_ROOT)" STASH_SCHEMA_TAG="$(STASH_SCHEMA_TAG)" STASH_SCHEMA_COMMIT="$(STASH_SCHEMA_COMMIT)" $(RSCRIPT) tools/check_generated.R

documentation-check: fetch-stash-schema
	PYTHON="$(PYTHON)" STASH_SOURCE_ROOT="$(STASH_SOURCE_ROOT)" $(RSCRIPT) tools/check_documentation.R

lint:
	$(RSCRIPT) -e 'lintr::lint_package()'

coverage:
	$(RSCRIPT) -e 'coverage <- covr::package_coverage(); writeLines(capture.output(print(coverage)), "coverage.txt")'

build: generate-check
	$(RSCRIPT) -e 'status <- system2("R", c("CMD", "build", ".")); quit(status = status)'

check-package:
	$(RSCRIPT) -e 'rcmdcheck::rcmdcheck(args = "--no-manual", error_on = "error")'

check: generate-check check-package

docs: generate-check
	$(RSCRIPT) -e 'pkgdown::build_site(preview = FALSE)'

roxygen:
	$(MAKE) generate-sdl

ci: generate-check test lint check-package
