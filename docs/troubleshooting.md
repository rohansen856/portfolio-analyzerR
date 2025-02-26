# Troubleshooting

## Common issues and quick fixes

1. Package installation errors
   - Ensure a working internet connection and Rtools (on Windows) if compilation is needed.
   - Use `install.packages()` or `remotes::install_version()` to install specific package versions.

2. `getSymbols` fails to fetch data
   - Yahoo API may throttle; try again later.
   - Verify symbol correctness. Use `tryCatch` wrappers in code will show helpful messages.

3. `Rscript` not found in shell
   - Add R's `bin` directory to PATH or run tests from within R/RStudio. See `docs/setup.md` for PATH example.

4. GPG signing errors when committing with `-S`
   - Configure GPG on your system and set `user.signingkey` in git config, or remove `-S` from commit commands.

5. `rmarkdown::render` fails for PDF
   - Install TinyTeX via `tinytex::install_tinytex()` or a system LaTeX distribution.

6. Covariance matrix singular in optimizer
   - Occurs with collinear or constant series. Use regularization or drop problematic assets.

7. NA values in indicators/backtests
   - Indicators like SMA and RSI produce NAs in the warm-up period. Code uses `na.locf` and `na.trim` where appropriate; ensure you allow warm-up.

If a problem persists, open an issue with a minimal reproducible example including system info (R version, OS, package versions) and the failing stack trace.