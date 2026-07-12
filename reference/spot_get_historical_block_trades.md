# Get Binance Spot historical block trades

Get Binance Spot historical block trades

## Usage

``` r
spot_get_historical_block_trades(
  symbol,
  limit = 500,
  fromId = NULL,
  json_list = FALSE,
  config = config_spot()
)
```

## Arguments

- symbol:

  Trading pair symbol, for example `"BTCUSDT"`.

- limit:

  Maximum number of rows to return.

- fromId:

  Optional block trade identifier to fetch from.

- json_list:

  If `TRUE`, return the parsed list instead of a `data.table`.

- config:

  A spot configuration created by
  [`config_spot()`](https://oliverlds.github.io/binxr/reference/config_spot.md).

## Value

A `data.table` by default, or a parsed list when `json_list = TRUE`.
