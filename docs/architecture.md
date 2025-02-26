# Architecture

## Overview

The system is implemented as modular R scripts with a small Shiny frontend. Components are separated to keep logic testable and reusable.

### High-level flow

- UI (`app.R`) — gathers user inputs (symbols, dates, strategy), triggers data fetch, runs indicators/strategies/backtest, shows visualizations and exports.
- Data (`R/data_fetch.R`) — fetches historical OHLC data using `quantmod::getSymbols`.
- Indicators (`R/indicators.R`) — computes SMA20, SMA50, RSI14 and MACD.
- Strategies (`R/strategies.R`) — implements SMA crossover and RSI-based signals.
- Backtest (`R/backtest.R`) — simulates trades using signals, computes strategy returns and equity curve.
- Portfolio (`R/portfolio.R`, `R/portfolio_optimizer.R`) — calculates performance metrics and an optimizer for weights.
- Visualization (`R/visualization.R`) — candlesticks, equity curve, correlation heatmap.
- Export (`R/export.R`) — CSV export and RMarkdown-based reports.
- Tests (`tests/`) — `testthat` unit tests covering core logic.

### Data model

- Time series objects are represented as `xts` objects produced by `quantmod`.
- Returns use `PerformanceAnalytics::dailyReturn` and align by index when building multi-asset matrices.

### Deployment

- Local: run `shiny::runApp()` from project root.
- CI: run `testthat::test_dir('tests')` and `R CMD check` on packaged modules if packaged.
