# Backtest simulation: uses adjusted close daily returns and signals
backtest <- function(prices_xts, signals, init_cap = 10000){
  if(!requireNamespace("PerformanceAnalytics", quietly = TRUE)) stop("PerformanceAnalytics required")
  returns <- PerformanceAnalytics::dailyReturn(quantmod::Cl(prices_xts))
  positions <- stats::lag(signals)
  strategy_ret <- returns * positions
  strategy_ret <- zoo::na.locf(strategy_ret, na.rm = FALSE)
  strategy_ret[is.na(strategy_ret)] <- 0
  equity <- cumprod(1 + strategy_ret) * init_cap
  list(returns = zoo::na.trim(strategy_ret), equity = equity)
}
