library(shiny)
source("R/data_fetch.R")
source("R/indicators.R")
source("R/strategies.R")
source("R/backtest.R")
source("R/portfolio.R")
source("R/portfolio_optimizer.R")
source("R/visualization.R")
source("R/export.R")

ui <- fluidPage(
  titlePanel("Smart Portfolio Analyzer & Backtester"),
  sidebarLayout(
    sidebarPanel(
        textInput("symbols", "Symbols (comma separated)", value = "AAPL,MSFT,GOOG"),
        dateRangeInput("dates", "Date range", start = Sys.Date() - 365, end = Sys.Date()),
        selectInput("strategy", "Strategy", choices = c("SMA Crossover" = "sma", "RSI" = "rsi")),
        checkboxInput("long_only", "Long only optimizer", value = TRUE),
        actionButton("run", "Run"),
        hr(),
        actionButton("optimize", "Optimize Portfolio"),
        downloadButton("download_csv", "Download CSVs"),
        downloadButton("download_report", "Download Report (HTML)")
      ),
    mainPanel(
      tabsetPanel(
        tabPanel("Chart", plotOutput("chart")),
        tabPanel("Equity", plotOutput("equity")),
        tabPanel("Correlation", plotOutput("corr")),
        tabPanel("Metrics", verbatimTextOutput("metrics")),
        tabPanel("Weights", tableOutput("weights"))
      )
    )
  )
)

server <- function(input, output, session){
  v <- reactiveValues(data_list = NULL, merged_returns = NULL, last_bt = NULL, last_metrics = NULL, weights = NULL, last_equity = NULL)

  observeEvent(input$run, {
    symbols <- unlist(strsplit(gsub("\\s+", "", input$symbols), ","))
    start <- input$dates[1]; end <- input$dates[2]
    fetched <- list()
    returns_list <- list()
    for(sym in symbols){
      d <- tryCatch(get_stock_data(sym, start, end), error = function(e) { NULL })
      if(is.null(d)) next
      d <- add_indicators(d)
      fetched[[sym]] <- d
      returns_list[[sym]] <- PerformanceAnalytics::dailyReturn(quantmod::Cl(d))
    }
    if(length(fetched) == 0){
      showNotification("No symbols fetched successfully", type = "error")
      return()
    }
    v$data_list <- fetched
    returns_df <- do.call(merge, returns_list)
    colnames(returns_df) <- names(returns_list)
    v$merged_returns <- returns_df

    # For charting show first symbol
    first_sym <- names(fetched)[1]
    data <- fetched[[first_sym]]
    signals <- switch(input$strategy,
                      sma = sma_strategy(data),
                      rsi = rsi_strategy(data))
    bt <- backtest(data, signals)
    v$last_bt <- bt
    v$last_metrics <- calc_metrics(bt$returns)
    v$last_equity <- bt$equity

    output$chart <- renderPlot({ plot_candles_signals(data, signals, title = first_sym) })
    output$equity <- renderPlot({ plot_equity_curve(bt$equity) })
    output$corr <- renderPlot({ if(!is.null(v$merged_returns)) plot_correlation_heatmap(as.data.frame(v$merged_returns)) })
    output$metrics <- renderPrint({ print(v$last_metrics) })
    output$weights <- renderTable({ if(!is.null(v$weights)) as.data.frame(v$weights) else NULL })
  })

  observeEvent(input$optimize, {
    if(is.null(v$merged_returns)){
      showNotification("Run data fetch first", type = "warning")
      return()
    }
    # compute optimizer weights
    # convert xts to numeric matrix with aligned returns
    mat <- na.omit(as.data.frame(v$merged_returns))
    w <- tryCatch({ optimize_portfolio(mat, risk_free = 0, long_only = input$long_only) }, error = function(e){ NULL })
    if(is.null(w)){
      showNotification("Optimization failed", type = "error")
      return()
    }
    v$weights <- w
    output$weights <- renderTable({ data.frame(asset = names(w), weight = round(as.numeric(w), 4)) })
  })

  output$download_csv <- downloadHandler(
    filename = function(){ paste0('report_', Sys.Date(), '.zip') },
    content = function(file){
      # create temp dir with CSVs
      td <- tempdir()
      mfile <- file.path(td, 'metrics.csv')
      eqfile <- file.path(td, 'equity.csv')
      if(!is.null(v$last_metrics)) utils::write.csv(as.data.frame(v$last_metrics), mfile)
      if(!is.null(v$last_equity)) utils::write.csv(as.data.frame(v$last_equity), eqfile)
      zip::zipr(zipfile = file, files = c(mfile, eqfile))
    }
  )

  output$download_report <- downloadHandler(
    filename = function(){ paste0('report_', Sys.Date(), '.html') },
    content = function(file){
      if(is.null(v$last_metrics) || is.null(v$last_equity)) stop('Nothing to report')
      export_report(v$last_metrics, v$last_equity, filepath = file, format = 'html')
    }
  )
}

shinyApp(ui, server)
