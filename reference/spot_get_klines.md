# Get Binance Spot klines

Get Binance Spot klines

## Usage

``` r
spot_get_klines(
  symbol,
  interval,
  startTime = NULL,
  endTime = NULL,
  timeZone = NULL,
  limit = 500,
  json_list = FALSE,
  config = config_spot()
)
```

## Arguments

- symbol:

  Trading pair symbol, for example `"BTCUSDT"`.

- interval:

  Kline interval string.

- startTime:

  Optional start time in milliseconds since Unix epoch.

- endTime:

  Optional end time in milliseconds since Unix epoch.

- timeZone:

  Optional timezone string accepted by Binance.

- limit:

  Maximum number of rows to return.

- json_list:

  If `TRUE`, return the parsed list instead of a `data.table`.

- config:

  A spot configuration created by
  [`config_spot()`](https://oliverlds.github.io/binxr/reference/config_spot.md).

## Value

A `data.table` by default, or a parsed list when `json_list = TRUE`.
