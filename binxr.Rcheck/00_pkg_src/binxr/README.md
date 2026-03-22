# binxr

An R client for the **Binance REST API** (Spot, Futures, and Options).

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

# Create a config (keys pulled from environment vars by default)
cfg <- config_futures()

# Get server time
futures_get_server_time(cfg)

# Fetch latest mark price for ETHUSDT
futures_get_mark_price("ETHUSDT", cfg)

# Place a limit order (example)
futures_place_order(
  symbol = "ETHUSDT",
  side = "BUY",
  type = "LIMIT",
  quantity = 0.01,
  price = 1800,
  time_in_force = "GTC",
  config = cfg
)

# Spot market data
spot_get_ticker_price(symbol = "BTCUSDT", config = config_spot())

# Options market data
options_get_mark_price(config = config_options())
```

## Requirements
- R >= 4.1.0
- Packages: `httr2`, `jsonlite`, `digest`, `data.table`, `rlang`

## License
MIT License (see [LICENSE](LICENSE) file).

---
Developed by **Oliver Zhou**, 2025.
