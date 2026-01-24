# Export helpers: CSV and simple RMarkdown report (HTML/PDF)
export_csv <- function(metrics, equity, filepath = "report.csv"){
  out <- list(metrics = metrics, equity = as.data.frame(equity))
  utils::write.csv(as.data.frame(metrics), file = paste0(tools::file_path_sans_ext(filepath), "_metrics.csv"))
  utils::write.csv(out$equity, file = paste0(tools::file_path_sans_ext(filepath), "_equity.csv"))
  return(list(metrics_file = paste0(tools::file_path_sans_ext(filepath), "_metrics.csv"), equity_file = paste0(tools::file_path_sans_ext(filepath), "_equity.csv")))
}

export_report <- function(metrics, equity, filepath = "report.html", format = c("html","pdf")){
  format <- match.arg(format)
  if(!requireNamespace("rmarkdown", quietly = TRUE)) stop("rmarkdown package required for report generation")
  tmp <- tempfile(fileext = ".Rmd")
  cat("---\n",
      "title: \"Backtest Report\"\n",
      "output: html_document\n",
      "---\n\n",
      file = tmp, sep = "")
  cat("## Metrics\n\n", file = tmp, append = TRUE)
  capture.output(print(metrics), file = tmp, append = TRUE)
  cat("\n\n## Equity (head)\n\n", file = tmp, append = TRUE)
  capture.output(print(utils::head(as.data.frame(equity), 20)), file = tmp, append = TRUE)
  # render
  out <- rmarkdown::render(tmp, output_file = filepath, quiet = TRUE)
  if(format == "pdf"){
    # try to convert to pdf if possible (may require pandoc/LaTeX)
    pdfpath <- sub("\\.html$", ".pdf", out)
    return(list(html = out, pdf = pdfpath))
  }
  return(list(html = out))
}
