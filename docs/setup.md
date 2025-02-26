# Setup

## Prerequisites

- R (>= 4.0 recommended)
- Optional: RStudio for development and Shiny preview
- (Optional) GPG setup for signed commits if you use `-S` in git

## Install required R packages

### Run from an R console:

```r
install.packages(c(
  "quantmod",
  "tidyquant",
  "TTR",
  "PerformanceAnalytics",
  "ggplot2",
  "shiny",
  "testthat",
  "xts",
  "zoo",
  "reshape2",
  "quadprog",
  "rmarkdown",
  "knitr",
  "zip"
))
```

Note: `rmarkdown` rendering to PDF may require a LaTeX distribution (TinyTeX or TeXLive).

### Repository setup

From project root:

```powershell
# initialize git (if not already)
git init
# create main branch
git branch -M main
# (optionally) create remote
git remote add origin git@github.com:YOUR_USERNAME/YOUR_REPO.git
```

### Run app

```r
shiny::runApp()
```

### Run tests

```r
testthat::test_dir('tests')
# or from shell
Rscript -e "testthat::test_dir('tests', reporter='summary')"
```

### Notes for Windows

- If `Rscript` is not found in a Powershell/CMD session, add R's bin directory to PATH. Example PowerShell (adjust path):

```powershell
$env:PATH += ";C:\Program Files\R\R-4.2.2\bin"
```

- For signed git commits (`-S`) configure GPG and set `user.signingkey` in git config, or remove `-S` from commit commands.
