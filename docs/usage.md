# Usage Guide

Quick start

1. Install R packages (see `docs/setup.md`).
2. From the project root run the Shiny app:

```r
shiny::runApp()
```

3. In the app UI enter symbol(s) (comma-separated), select date range and strategy, then click `Run`.

Optimizing a multi-asset portfolio

- Enter multiple symbols (e.g., `AAPL,MSFT,GOOG`) and `Run` to fetch data and compute returns.
- Click `Optimize Portfolio` to compute weights using the tangency-style optimizer (long-only by default).
- Weights will display in the `Weights` tab.

## Exports

- `Download CSVs` bundles metrics and equity CSVs into a zip.
- `Download Report (HTML)` renders a simple RMarkdown report with metrics and an equity head.

## Command-line backtest (example)

You can use the modular scripts directly from an R console. Example (pseudo):

```r
library(quantmod)
source('R/data_fetch.R'); source('R/indicators.R'); source('R/strategies.R'); source('R/backtest.R')
price <- get_stock_data('AAPL', Sys.Date()-365, Sys.Date())
price <- add_indicators(price)
sig <- sma_strategy(price)
res <- backtest(price, sig)
plot(res$equity)
```

## Notes

- The app uses the first fetched symbol for the candlestick chart and a combined return matrix for the optimizer.
- Export/HTML report generation requires `rmarkdown` and may require LaTeX for PDF output.
