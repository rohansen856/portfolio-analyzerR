# Portfolio metrics using PerformanceAnalytics
calc_metrics <- function(returns_xts){
  if(!requireNamespace("PerformanceAnalytics", quietly = TRUE)) stop("PerformanceAnalytics required")
  r <- zoo::na.trim(returns_xts)
  metrics <- list(
    sharpe = as.numeric(PerformanceAnalytics::SharpeRatio.annualized(r)),
    volatility = as.numeric(PerformanceAnalytics::StdDev.annualized(r)),
    cagr = as.numeric(PerformanceAnalytics::Return.annualized(r))
  )
  return(metrics)
}
