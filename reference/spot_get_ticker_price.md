# Get Binance Spot ticker price

Get Binance Spot ticker price

## Usage

``` r
spot_get_ticker_price(
  symbol = NULL,
  symbols = NULL,
  symbol_status = NULL,
  json_list = FALSE,
  config = config_spot()
)

get_spot_mark_price(symbol = NULL, config = binxr_config_spot())
```

## Arguments

- symbol:

  Optional trading pair symbol.

- symbols:

  Optional character vector of trading pair symbols.

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
multi-symbol/all-symbol requests unless `json_list = TRUE`.
