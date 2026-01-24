# Portfolio optimizer: approximate tangency (Sharpe) portfolio
# Returns weights summing to 1. If long_only=TRUE negative weights set to zero and re-normalized.
optimize_portfolio <- function(returns_xts, risk_free = 0, long_only = TRUE){
  if(NCOL(returns_xts) < 1) stop("Need at least one asset")
  mu <- colMeans(returns_xts, na.rm = TRUE)
  Sigma <- cov(returns_xts, use = "pairwise.complete.obs")
  ex <- as.numeric(mu - risk_free)
  names(ex) <- names(mu)
  # Solve for weights proportional to inv(Sigma) * (mu - rf)
  w_raw <- tryCatch({
    as.numeric(solve(Sigma, ex))
  }, error = function(e){
    stop("Covariance matrix singular or not invertible")
  })
  if(long_only){
    w_raw[w_raw < 0] <- 0
  }
  if(sum(w_raw) == 0){
    w <- rep(1/length(w_raw), length(w_raw))
  } else {
    w <- w_raw / sum(w_raw)
  }
  names(w) <- colnames(returns_xts)
  return(w)
}
