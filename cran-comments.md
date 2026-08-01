## R CMD check results

0 errors | 0 warnings | 1 note

## Test environments

- Local macOS, R 4.2.3
- Local macOS, R 4.2.3, `R CMD check --as-cran --no-manual`

## Submission notes

In this version I have:

- added USD-M Futures Algo Service helpers for conditional orders
- added USD-M Futures order modification and modification-history helpers
- added USD-M Futures market-data and account helpers for current API endpoints
- clarified the package's USD-M REST scope

The CRAN incoming check reports `https://www.binance.com/` with HTTP status
202 Accepted. The URL is valid, but Binance returns HTTP 202 for this request.

Network calls to the Binance API are not made during examples or tests.
Endpoint tests use mocked request helpers only.

Authenticated trading helpers require an explicit user-created configuration
with API credentials and are not exercised against the live Binance service
during checks.
