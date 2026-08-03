# Changelog

## binxr (development version)

- Added USD-M Futures market-data wrappers for open-interest history,
  long-short ratios, taker buy-sell volume, basis, delivery prices,
  composite index information, and asset index prices. Added Futures
  API-key-only user data stream listen-key helpers.
- Fixed the USD-M Futures position-mode endpoint path.
- Added USD-M Futures batch orders, position margin, income history,
  account configuration, symbol configuration, API trading status,
  leverage brackets, ADL quantiles, and current open-order helpers.
- Added Options batch orders, stock-contract signing, and API-key-only
  user data stream listen-key helpers. Options block-trade and
  market-maker endpoints remain intentionally out of scope.

## binxr 0.1.2

CRAN release: 2026-08-02

- Added USD-M Futures Algo Service helpers for conditional orders,
  replacing order types no longer accepted by `/fapi/v1/order`.
- Added USD-M Futures order modification and modification-history
  helpers, including the optional `modify_id` request identifier.
- Added USD-M Futures helpers for trading schedules, insurance fund
  balances, index constituents, symbol-level ADL risk, RPI order books,
  and historical trades. Historical trades document Binance’s 500-row
  maximum, one-month availability, and high request weight.
- Clarified that Futures support is limited to USD-M REST (`/fapi`);
  COIN-M, Portfolio Margin, WebSocket, SBE, and FIX APIs remain out of
  scope.
- Added
  [`spot_get_historical_block_trades()`](https://oliverlds.github.io/binxr/reference/spot_get_historical_block_trades.md)
  for the Spot `/api/v3/historicalBlockTrades` endpoint added in
  Binance’s 2026 Spot API changelog.
- Added mocked regression coverage for `CANCEL_ONLY` `symbolStatus`
  passthrough and `expiryReason` preservation in Spot order responses.

## binxr 0.1.1

CRAN release: 2026-05-18

- Officially included Binance Options support in the documented package
  scope.
- Promoted the canonical `spot_*`, `futures_*`, and `options_*` APIs in
  docs.
- Deprecated legacy wrapper aliases such as `get_fapi_*` and
  `get_spot_*`.
- Updated package metadata, README, and pkgdown configuration for the
  0.1.1 release.

## binxr 0.1.0

- Added a shared core for configuration, validation, HTTP requests, and
  response shaping.
- Added lightweight release scaffolding with testthat, GitHub Actions
  CI, and pkgdown config.
- Updated package metadata for GitHub releases and future expansion
  across Binance product areas.
