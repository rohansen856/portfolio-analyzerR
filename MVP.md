
**Smart Portfolio Analyzer & Backtesting System (R)** 

A system that allows users to select multiple stocks, analyze performance, generate technical indicators, backtest trading strategies, and evaluate portfolio risk & returns.

---

# 🎯 Project Objective

Build a tool that:

✔ Downloads historical stock data
✔ Computes indicators (SMA, RSI, MACD)
✔ Generates Buy/Sell signals
✔ Backtests strategies
✔ Compares multiple stocks
✔ Builds optimized portfolio
✔ Visualizes results
✔ Produces performance report

---

# 🧱 Tech Stack

* R
* quantmod
* tidyquant
* TTR
* PerformanceAnalytics
* ggplot2
* shiny
* testthat

---

# 📂 Project Structure

```
root/ 
│
├── app.R
├── R/
│   ├── data_fetch.R
│   ├── indicators.R
│   ├── strategies.R
│   ├── backtest.R
│   ├── portfolio.R
│   └── visualization.R
│
├── tests/
│   ├── test_indicators.R
│   ├── test_strategies.R
│   └── test_backtest.R
│
├── data/
├── README.md
└── requirements.txt
```

---

# 🔹 Functional Requirements

### 1. Data Input

* User enters stock symbols (AAPL, MSFT, GOOG)
* Selects date range

### 2. Indicators

* SMA (20,50)
* RSI (14)
* MACD

### 3. Trading Strategy

* SMA crossover
* RSI oversold/overbought

### 4. Backtesting

* Simulate trades
* Track capital growth

### 5. Portfolio Analysis

* Expected return
* Volatility
* Sharpe Ratio

### 6. Visualization

* Candlestick chart
* Signals overlay
* Equity curve
* Correlation heatmap

### 7. Export

* CSV report
* PDF summary

---

# 📌 Non-Functional Requirements

* Must run offline
* Error handling for wrong symbols
* Modular code
* Tests for core logic

---

# ⚙️ Core Modules (What Each File Does)

### data_fetch.R

```r
get_stock_data <- function(symbol, start, end){
  getSymbols(symbol, src="yahoo", from=start, to=end, auto.assign=FALSE)
}
```

---

### indicators.R

```r
add_indicators <- function(data){
  data$SMA20 <- SMA(Cl(data),20)
  data$SMA50 <- SMA(Cl(data),50)
  data$RSI14 <- RSI(Cl(data),14)
  data
}
```

---

### strategies.R

```r
sma_strategy <- function(data){
  signal <- ifelse(data$SMA20 > data$SMA50,1,-1)
  diff(signal)
}
```

---

### backtest.R

```r
backtest <- function(returns, signals){
  strategy_returns <- returns * lag(signals)
  na.omit(strategy_returns)
}
```

---

### portfolio.R

```r
calc_metrics <- function(returns){
  list(
    sharpe = SharpeRatio.annualized(returns),
    volatility = sd(returns),
    cagr = Return.annualized(returns)
  )
}
```

---

# 🧪 Testing (Using testthat)

### tests/test_indicators.R

```r
library(testthat)

test_that("SMA is computed",{
  data <- getSymbols("AAPL",src="yahoo",auto.assign=FALSE)
  out <- add_indicators(data)
  expect_true("SMA20" %in% colnames(out))
})
```

Run tests:

```r
testthat::test_dir("tests")
```

---

# 📊 Expected Outputs

### User Interface

* Input: Symbols, Dates, Strategy
* Tabs:

  * Chart
  * Signals
  * Backtest Results
  * Portfolio Metrics

### Sample Output Metrics

```
CAGR: 18.4%
Sharpe Ratio: 1.32
Max Drawdown: -12.5%
Win Rate: 57%
```

---

# 🔐 Validations

| Case           | Validation      |
| -------------- | --------------- |
| Empty symbol   | Show error      |
| Invalid symbol | Show message    |
| No internet    | Fallback notice |
| NA values      | Auto remove     |

---

# 📄 README Template

Include:

* Project overview
* Architecture diagram
* Installation
* Usage
* Screenshots
* Example results