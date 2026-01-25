library(testthat)
source("R/export.R")

set.seed(1)
metrics <- list(a=1, b=2)
equity <- xts::xts(cumsum(rnorm(10)), order.by = Sys.Date() - 10:1)

test_that("Export CSV creates files", {
  res <- export_csv(metrics, equity, filepath = tempfile(fileext = ".csv"))
  expect_true(file.exists(res$metrics_file))
  expect_true(file.exists(res$equity_file))
})

# test report generation (html)
test_that("Export report renders html", {
  out <- export_report(metrics, equity, filepath = tempfile(fileext = ".html"), format = 'html')
  expect_true(file.exists(out$html))
})
