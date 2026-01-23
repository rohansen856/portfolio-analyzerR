library(testthat)
source("R/indicators.R")

# synthetic price series
set.seed(123)
vals <- cumsum(rnorm(200, 0.1, 1)) + 100
dates <- seq.Date(Sys.Date()-200, by = "days", length.out = 200)
xts <- xts::xts(cbind(Open=vals, High=vals+1, Low=vals-1, Close=vals, Volume=1000, Adjusted=vals), order.by = dates)

test_that("SMA and RSI are computed", {
  out <- add_indicators(xts)
  expect_true("SMA20" %in% colnames(out))
  expect_true("RSI14" %in% colnames(out))
})
