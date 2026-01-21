# Data fetching with error handling
get_stock_data <- function(symbol, start, end){
  if(!requireNamespace("quantmod", quietly = TRUE)) stop("quantmod is required")
  tryCatch({
    df <- suppressWarnings(quantmod::getSymbols(symbol, src = "yahoo", from = start, to = end, auto.assign = FALSE))
    return(df)
  }, error = function(e){
    stop(sprintf("Failed to fetch '%s' (%s). Check symbol or internet: %s", symbol, Sys.time(), e$message))
  })
}
