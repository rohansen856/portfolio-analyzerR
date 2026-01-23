# Smart Portfolio Analyzer & Backtesting System (R)

Overview
- Downloads stock data, computes indicators, backtests strategies, and analyzes portfolios.

Install

Install required packages:

```r
install.packages(c("quantmod","tidyquant","TTR","PerformanceAnalytics","ggplot2","shiny","testthat","xts","zoo","reshape2"))
```

Run app:

```r
# from project root
shiny::runApp()
```

Run tests:

```r
testthat::test_dir("tests")
```
