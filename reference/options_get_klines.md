# Get Binance Options klines

Get Binance Options klines

## Usage

``` r
options_get_klines(
  symbol,
  interval,
  startTime = NULL,
  endTime = NULL,
  limit = 500,
  json_list = FALSE,
  config = config_options()
)
```

## Arguments

- symbol:

  Option symbol, for example `"BTC-200730-9000-C"`.

- interval:

  Kline interval string.

- startTime:

  Optional start time in milliseconds since Unix epoch.

- endTime:

  Optional end time in milliseconds since Unix epoch.

- limit:

  Maximum number of rows to return. Must not exceed `1500`.

- json_list:

  If `TRUE`, return the parsed list instead of a `data.table`.

- config:

  An options configuration created by
  [`config_options()`](https://oliverlds.github.io/binxr/reference/config_options.md).

## Value

A `data.table` by default, or a parsed list when `json_list = TRUE`.
