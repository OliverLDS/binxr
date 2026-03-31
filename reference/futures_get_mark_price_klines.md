# Get Binance Futures mark price klines

Get Binance Futures mark price klines

## Usage

``` r
futures_get_mark_price_klines(
  symbol,
  interval,
  startTime = NULL,
  endTime = NULL,
  limit = 500,
  json_list = FALSE,
  config = config_futures()
)
```

## Arguments

- symbol:

  Trading pair symbol, for example `"ETHUSDT"`.

- interval:

  Kline interval string.

- startTime:

  Optional start time in milliseconds since Unix epoch.

- endTime:

  Optional end time in milliseconds since Unix epoch.

- limit:

  Maximum number of rows to return.

- json_list:

  If `TRUE`, return the parsed list instead of a `data.table`.

- config:

  A futures configuration created by
  [`config_futures()`](https://oliverlds.github.io/binxr/reference/config_futures.md).

## Value

A `data.table` by default, or a parsed list when `json_list = TRUE`.
