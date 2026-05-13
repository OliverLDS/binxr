## R CMD check results

0 errors | 0 warnings | 1 note

## Test environments

- Local macOS, R 4.2.3
- GitHub Actions, ubuntu-latest, R release, `R CMD check --as-cran`
- win-builder, R-devel, Windows Server 2022
- win-builder, R-release, Windows Server 2022
- R-hub, GitHub Actions

## Submission notes

This is a resubmission.

In this version I have:

- removed the redundant "for R" from the package title
- wrapped software and API names in single quotes in the Title and Description

The remaining NOTE is the expected CRAN incoming feasibility note for a new
submission. It also reports `Binance` as a possibly misspelled word; this is the
proper name of the cryptocurrency exchange whose public API is wrapped by this
package.

The CRAN incoming check reports `https://www.binance.com/` with HTTP status
202 Accepted. The URL is valid, but Binance returns HTTP 202 for this request in
the win-builder checking environment.

Network calls to the Binance API are not made during examples or tests.
Endpoint tests use mocked request helpers only.

Authenticated trading helpers require an explicit user-created configuration
with API credentials and are not exercised against the live Binance service
during checks.
