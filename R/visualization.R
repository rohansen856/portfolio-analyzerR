# Visualization helpers

plot_candles_signals <- function(prices_xts, signals = NULL, title = NULL){
  if(!requireNamespace("quantmod", quietly = TRUE)) stop("quantmod required")
  op <- graphics::par(no.readonly = TRUE)
  on.exit(graphics::par(op))
  quantmod::chartSeries(prices_xts, name = title, theme = quantmod::chartTheme('white'))
  if(!is.null(signals)){
    sig_long <- which(as.numeric(signals) == 1)
    if(length(sig_long)) addTA(rep(NA, NROW(prices_xts)), on = 1)
  }
}

plot_equity_curve <- function(equity_xts){
  if(!requireNamespace("ggplot2", quietly = TRUE)) stop("ggplot2 required")
  df <- data.frame(date = zoo::index(equity_xts), equity = as.numeric(equity_xts))
  p <- ggplot2::ggplot(df, ggplot2::aes(x = date, y = equity)) +
    ggplot2::geom_line() + ggplot2::theme_minimal() + ggplot2::ylab('Equity')
  print(p)
}

plot_correlation_heatmap <- function(returns_df){
  if(!requireNamespace("ggplot2", quietly = TRUE)) stop("ggplot2 required")
  M <- stats::cor(returns_df, use = "pairwise.complete.obs")
  library(reshape2)
  d <- reshape2::melt(M)
  p <- ggplot2::ggplot(d, ggplot2::aes(Var1, Var2, fill = value)) +
    ggplot2::geom_tile() + ggplot2::scale_fill_gradient2(low = "blue", mid = "white", high = "red", midpoint = 0) +
    ggplot2::theme_minimal() + ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 45, hjust = 1))
  print(p)
}
