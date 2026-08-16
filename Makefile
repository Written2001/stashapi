RSCRIPT ?= Rscript

.PHONY: setup test generate-check lint coverage build check docs roxygen ci

setup:
	Rscript -e 'renv::restore(prompt = FALSE)'

test:
	$(RSCRIPT) -e 'testthat::test_local()'

generate-check:
	$(RSCRIPT) tools/check_generated.R

lint:
	$(RSCRIPT) -e 'lintr::lint_package()'

coverage:
	$(RSCRIPT) -e 'coverage <- covr::package_coverage(); writeLines(capture.output(print(coverage)), "coverage.txt")'

build:
	R CMD build .

check:
	$(RSCRIPT) -e 'rcmdcheck::rcmdcheck(args = "--no-manual", error_on = "error")'

docs:
	$(RSCRIPT) -e 'pkgdown::build_site(preview = FALSE)'

roxygen:
	$(RSCRIPT) -e 'roxygen2::roxygenise()'
	$(RSCRIPT) tools/generate_input_helper_docs.R

ci: generate-check test lint check
