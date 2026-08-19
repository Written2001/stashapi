RSCRIPT ?= Rscript

.PHONY: setup test generate-check documentation-check lint coverage build check check-package docs roxygen ci

setup:
	Rscript -e 'renv::activate(); renv::restore(prompt = FALSE)'

test:
	$(RSCRIPT) -e 'testthat::test_local()'

generate-check:
	$(RSCRIPT) tools/check_generated.R

documentation-check:
	$(RSCRIPT) tools/check_documentation.R

lint:
	$(RSCRIPT) -e 'lintr::lint_package()'

coverage:
	$(RSCRIPT) -e 'coverage <- covr::package_coverage(); writeLines(capture.output(print(coverage)), "coverage.txt")'

build: generate-check documentation-check
	$(RSCRIPT) -e 'status <- system2("R", c("CMD", "build", ".")); quit(status = status)'

check-package:
	$(RSCRIPT) -e 'rcmdcheck::rcmdcheck(args = "--no-manual", error_on = "error")'

check: generate-check documentation-check check-package

docs: documentation-check
	$(RSCRIPT) -e 'pkgdown::build_site(preview = FALSE)'

roxygen:
	$(RSCRIPT) tools/generate_wrappers.R R/stashapi_functions.R
	$(RSCRIPT) -e 'roxygen2::roxygenise()'
	$(RSCRIPT) tools/generate_input_helper_docs.R

ci: generate-check documentation-check test lint check-package
