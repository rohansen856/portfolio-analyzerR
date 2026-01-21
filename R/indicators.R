# Indicator calculations: SMA, RSI, MACD
add_indicators <- function(data){
  if(!requireNamespace("TTR", quietly = TRUE)) stop("TTR is required")
  close <- TTR::Cl(data)
  data$SMA20 <- TTR::SMA(close, n = 20)
  data$SMA50 <- TTR::SMA(close, n = 50)
  data$RSI14 <- TTR::RSI(close, n = 14)
  macd <- TTR::MACD(close, nFast = 12, nSlow = 26, nSig = 9)
  data$MACD <- macd[,1]
  data$MACDSignal <- macd[,2]
  return(data)
}
