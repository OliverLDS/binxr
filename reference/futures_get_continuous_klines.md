# Get Binance Futures continuous contract klines

Get Binance Futures continuous contract klines

## Usage

``` r
futures_get_continuous_klines(
  pair,
  contract_type = c("PERPETUAL", "CURRENT_MONTH", "NEXT_MONTH", "CURRENT_QUARTER",
    "NEXT_QUARTER"),
  interval,
  startTime = NULL,
  endTime = NULL,
  limit = 500,
  json_list = FALSE,
  config = config_futures()
)
```

## Arguments

- pair:

  Futures pair, for example `"BTCUSDT"`.

- contract_type:

  One of `"PERPETUAL"`, `"CURRENT_MONTH"`, `"NEXT_MONTH"`,
  `"CURRENT_QUARTER"`, or `"NEXT_QUARTER"`.

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

  A futures configuration created by
  [`config_futures()`](https://oliverlds.github.io/binxr/reference/config_futures.md).

## Value

A `data.table` by default, or a parsed list when `json_list = TRUE`.
