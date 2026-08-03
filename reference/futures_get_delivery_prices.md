# Get Binance Futures delivery prices

Get Binance Futures delivery prices

## Usage

``` r
futures_get_delivery_prices(
  pair,
  startTime = NULL,
  endTime = NULL,
  limit = 30,
  json_list = FALSE,
  config = config_futures()
)
```

## Arguments

- pair:

  Futures pair, for example `"BTCUSDT"`.

- startTime:

  Optional start time in milliseconds since Unix epoch.

- endTime:

  Optional end time in milliseconds since Unix epoch.

- limit:

  Maximum number of rows to return. Must not exceed `100`.

- json_list:

  If `TRUE`, return the parsed list instead of a `data.table`.

- config:

  A futures configuration created by
  [`config_futures()`](https://oliverlds.github.io/binxr/reference/config_futures.md).

## Value

A `data.table` by default, or a parsed list when `json_list = TRUE`.
