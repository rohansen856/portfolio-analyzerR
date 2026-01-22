# Simple strategies producing signals (1 = long, 0 = flat)

sma_strategy <- function(data){
  if(!all(c("SMA20","SMA50") %in% colnames(data))) stop("SMA20 and SMA50 required")
  sig <- ifelse(data$SMA20 > data$SMA50, 1, 0)
  sig <- zoo::na.locf(sig, na.rm = FALSE)
  sig[is.na(sig)] <- 0
  return(sig)
}

rsi_strategy <- function(data, lower = 30, upper = 70){
  if(!"RSI14" %in% colnames(data)) stop("RSI14 required")
  sig <- rep(NA, NROW(data))
  sig[data$RSI14 < lower] <- 1
  sig[data$RSI14 > upper] <- 0
  sig <- zoo::na.locf(sig, na.rm = FALSE)
  sig[is.na(sig)] <- 0
  return(sig)
}
