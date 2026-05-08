## R CMD check results

0 errors | 0 warnings | 0 notes

## Test environments

- Local macOS, R 4.2.3
- GitHub Actions, ubuntu-latest, R release, `R CMD check --as-cran`

## Submission notes

This is the first CRAN submission.

Network calls to the Binance API are not made during examples or tests.
Endpoint tests use mocked request helpers only.

Authenticated trading helpers require an explicit user-created configuration
with API credentials and are not exercised against the live Binance service
during checks.
