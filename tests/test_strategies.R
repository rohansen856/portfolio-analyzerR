library(testthat)
source("R/strategies.R")

# small synthetic data
set.seed(1)
vals <- cumsum(rnorm(100)) + 50
dates <- Sys.Date() - 100:1
xts <- xts::xts(cbind(Open=vals, High=vals+1, Low=vals-1, Close=vals, Volume=1, Adjusted=vals), order.by = dates)
xts$SMA20 <- TTR::SMA(xts[,"Close"], 20)
xts$SMA50 <- TTR::SMA(xts[,"Close"], 50)
xts$RSI14 <- TTR::RSI(xts[,"Close"], 14)

test_that("SMA strategy returns vector of signals", {
  s <- sma_strategy(xts)
  expect_equal(length(s), NROW(xts))
})

test_that("RSI strategy returns vector of signals", {
  s2 <- rsi_strategy(xts)
  expect_equal(length(s2), NROW(xts))
})
