## R CMD check results

Local package checks pass with no package-level errors or warnings.

`R CMD check --as-cran --no-manual` currently reports one environment NOTE:

- `unable to verify current time`

Full `--as-cran` with manual PDF generation was not completed locally because
`pdflatex` is not available on this machine. CRAN incoming URL/version checks
also require stable network access.

## Test environments

- Local macOS, R 4.2.3
- GitHub Actions, ubuntu-latest, R release

## Submission notes

This is the first CRAN submission.

Network calls to the Binance API are not made during examples or tests.
Endpoint tests use mocked request helpers only.

Authenticated trading helpers require an explicit user-created configuration
with API credentials and are not exercised against the live Binance service
during checks.
