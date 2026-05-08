# binxr

[![Documentation](https://img.shields.io/badge/docs-pkgdown-blue.svg)](https://oliverlds.github.io/binxr/)

An R client for the **Binance REST API** (Spot, Futures, and Options).

Documentation site: <https://oliverlds.github.io/binxr/>

## Overview
`binxr` provides lightweight helpers for:
- Public market data (ticker prices, klines, exchange info)
- Authenticated endpoints (account info, positions, and order management)
- Spot, USD-M futures, and options product areas
- Data returned as `data.table` for easy downstream analysis

## Installation
```r
# From GitHub (using remotes or devtools)
remotes::install_github("OliverLDS/binxr")
```

## Quick Start
```r
library(binxr)

# Create a public config without credentials.
cfg <- config_futures(api_key = NULL, secret_key = NULL)

# Prepare values using local helper logic, without making a network request.
exchange_info <- list(
  symbols = list(
    ETHUSDT = list(
      filters = list(
        list(filterType = "PRICE_FILTER", tickSize = "0.01"),
        list(filterType = "LOT_SIZE", stepSize = "0.001")
      )
    )
  )
)

round_price_qty(exchange_info, "ETHUSDT", price = 1800.123, quantity = 0.12345)
```

Live API requests require network access. Authenticated trading endpoints also
require Binance API credentials supplied explicitly or via `BINX_API_KEY` and
`BINX_SECRET_KEY`.

```r
library(binxr)

cfg <- config_futures()

# Public futures market data.
futures_get_server_time(config = cfg)
futures_get_mark_price(symbol = "ETHUSDT", config = cfg)

# Public spot and options market data.
spot_get_ticker_price(symbol = "BTCUSDT", config = config_spot())
options_get_mark_price(config = config_options())
```

Order-management helpers such as `futures_place_order()` and
`spot_place_order()` are intentionally not shown as copy-paste quick-start code:
review Binance permissions, testnet settings, and order parameters before using
them with real credentials.

## Requirements
- R >= 4.1.0
- Packages: `httr2`, `jsonlite`, `digest`, `data.table`, `rlang`

## License
MIT License (see [LICENSE](LICENSE) file).

---
Developed by **Oliver Zhou**, 2025.
