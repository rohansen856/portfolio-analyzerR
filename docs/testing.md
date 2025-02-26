# Testing

## Run unit tests

From R:

```r
testthat::test_dir('tests')
```

From shell (requires `Rscript` on PATH):

```bash
Rscript -e "testthat::test_dir('tests', reporter='summary')"
```

## Test design

- Tests use synthetic `xts` data where possible to avoid network dependency.
- Add tests for any new modules under `tests/` following the pattern `test_*.R`.

## Continuous Integration

- Recommended to run tests on push via GitHub Actions or other CI.
- Example GH Action steps:
  - Setup R (uses r-lib/actions/setup-r)
  - Install dependencies via `remotes::install_deps()` or `install.packages()`
  - Run `Rscript -e "testthat::test_dir('tests', reporter='summary')"`

## Coverage

- Consider `covr` for coverage metrics and publishing coverage badges.
