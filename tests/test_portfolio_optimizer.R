library(testthat)
source("R/portfolio_optimizer.R")

set.seed(1)
# create synthetic returns for 3 assets
r1 <- rnorm(100, 0.0005, 0.01)
r2 <- rnorm(100, 0.0007, 0.012)
r3 <- rnorm(100, 0.0002, 0.008)
mat <- data.frame(A=r1, B=r2, C=r3)

test_that("Optimize returns weights summing to 1", {
  w <- optimize_portfolio(mat, risk_free = 0, long_only = TRUE)
  expect_equal(round(sum(w), 6), 1)
  expect_true(all(w >= -1e-8))
})
