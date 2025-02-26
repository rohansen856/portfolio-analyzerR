# Module Reference

This document lists the core R modules and their primary functions.

> R/data_fetch.R
- `get_stock_data(symbol, start, end)`
  - Fetches historical OHLC series from Yahoo via `quantmod::getSymbols`.
  - Returns an `xts` object or throws an informative error on failure.

> R/indicators.R
- `add_indicators(data)`
  - Adds `SMA20`, `SMA50`, `RSI14`, `MACD`, `MACDSignal` columns to the `xts` data.

> R/strategies.R
- `sma_strategy(data)`
  - Produces a numeric signal (`1` long, `0` flat) based on `SMA20 > SMA50`.
- `rsi_strategy(data, lower=30, upper=70)`
  - Produces `1` when RSI crosses below `lower` (buy), `0` when above `upper` (sell/flat).

> R/backtest.R
- `backtest(prices_xts, signals, init_cap = 10000)`
  - Calculates daily returns from `Cl(prices_xts)`, applies lagged signals to compute strategy returns, fills NAs, and returns a list with `returns` and `equity` (xts equity curve).

> R/portfolio.R
- `calc_metrics(returns_xts)`
  - Returns a list containing annualized Sharpe, volatility (StdDev), and CAGR using `PerformanceAnalytics` functions.

> R/portfolio_optimizer.R
- `optimize_portfolio(returns_xts, risk_free = 0, long_only = TRUE)`
  - Computes weights proportional to inv(Sigma)*(mu - rf). Applies long-only post-processing if requested.

> R/visualization.R
- `plot_candles_signals(prices_xts, signals, title)` — Quick candlestick chart with optional signal overlay
- `plot_equity_curve(equity_xts)` — ggplot2 equity curve
- `plot_correlation_heatmap(returns_df)` — correlation heatmap between asset returns

> R/export.R
- `export_csv(metrics, equity, filepath)` — Writes metrics and equity CSVs
- `export_report(metrics, equity, filepath, format)` — RMarkdown render (HTML/PDF) of a simple backtest report

> app.R
- Shiny application wiring UI to modules. Inputs: symbols, date range, strategy, optimize, downloads. Outputs: chart, equity, correlation, metrics, weights.

> Tests in `tests/`
- Unit tests use synthetic or deterministic series so they run offline and are fast.
