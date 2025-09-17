# binxr

An R client for the **Binance REST API** (Spot and Futures).

## Overview
`binxr` provides lightweight helpers for:
- Public market data (mark price, klines, exchange info)
- Authenticated endpoints (account info, positions, order management)
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
cfg <- binxr_config_futures()

# Get server time
get_fapi_system_time(cfg)

# Fetch latest mark price for ETHUSDT
get_fapi_mark_price("ETHUSDT", cfg)

# Place a limit order (example)
place_fapi_trade_order(
  symbol = "ETHUSDT",
  side = "BUY",
  type = "LIMIT",
  quantity = 0.01,
  price = 1800,
  timeInForce = "GTC",
  config = cfg
)
```

## Requirements
- R >= 4.0
- Packages: `httr2`, `jsonlite`, `digest`, `data.table`, `rlang`

## License
MIT License (see [LICENSE](LICENSE) file).

---
Developed by **Oliver Lee**, 2025.