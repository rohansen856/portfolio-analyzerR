library(testthat)
source("R/backtest.R")

set.seed(2)
vals <- cumsum(rnorm(120, 0.1, 1)) + 20
dates <- seq.Date(Sys.Date()-119, by = "days", length.out = 120)
xxts <- xts::xts(cbind(Open=vals, High=vals+1, Low=vals-1, Close=vals, Volume=1, Adjusted=vals), order.by = dates)
signals <- rep(0, NROW(xxts))
signals[60:120] <- 1

# quick sanity test
res <- backtest(xxts, signals)

test_that("Backtest returns equity and returns", {
  expect_true(!is.null(res$equity))
  expect_true(!is.null(res$returns))
})
