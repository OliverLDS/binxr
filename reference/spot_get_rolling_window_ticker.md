# Get Binance Spot rolling window ticker statistics

Get Binance Spot rolling window ticker statistics

## Usage

``` r
spot_get_rolling_window_ticker(
  symbol = NULL,
  symbols = NULL,
  windowSize = NULL,
  type = c("FULL", "MINI"),
  symbol_status = NULL,
  json_list = FALSE,
  config = config_spot()
)
```

## Arguments

- symbol:

  Optional trading pair symbol.

- symbols:

  Optional character vector of trading pair symbols.

- windowSize:

  Optional rolling window size such as `"1m"`, `"4h"`, or `"7d"`.

- type:

  One of `"FULL"` or `"MINI"`.

- symbol_status:

  Optional trading status filter.

- json_list:

  If `TRUE`, return the parsed list instead of converting array
  responses to `data.table`.

- config:

  A spot configuration created by
  [`config_spot()`](https://oliverlds.github.io/binxr/reference/config_spot.md).

## Value

A parsed list for single-symbol requests, or a `data.table` for
multi-symbol requests unless `json_list = TRUE`.
