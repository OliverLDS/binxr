# Get Binance Spot aggregate trades

Get Binance Spot aggregate trades

## Usage

``` r
spot_get_aggregate_trades(
  symbol,
  fromId = NULL,
  startTime = NULL,
  endTime = NULL,
  limit = 500,
  json_list = FALSE,
  config = config_spot()
)
```

## Arguments

- symbol:

  Trading pair symbol, for example `"BTCUSDT"`.

- fromId:

  Optional aggregate trade identifier to fetch from, inclusive.

- startTime:

  Optional start time in milliseconds since Unix epoch, inclusive.

- endTime:

  Optional end time in milliseconds since Unix epoch, inclusive.

- limit:

  Maximum number of rows to return.

- json_list:

  If `TRUE`, return the parsed list instead of a `data.table`.

- config:

  A spot configuration created by
  [`config_spot()`](https://oliverlds.github.io/binxr/reference/config_spot.md).

## Value

A `data.table` by default, or a parsed list when `json_list = TRUE`.
