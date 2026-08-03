# Get Binance Futures top-trader long-short position ratio

Get Binance Futures top-trader long-short position ratio

## Usage

``` r
futures_get_top_long_short_position_ratio(
  symbol,
  period = "5m",
  startTime = NULL,
  endTime = NULL,
  limit = 30,
  json_list = FALSE,
  config = config_futures()
)
```

## Arguments

- symbol:

  Trading pair symbol, for example `"ETHUSDT"`.

- period:

  Aggregation period. One of `"5m"`, `"15m"`, `"30m"`, `"1h"`, `"2h"`,
  `"4h"`, `"6h"`, `"12h"`, or `"1d"`.

- startTime:

  Optional start time in milliseconds since Unix epoch.

- endTime:

  Optional end time in milliseconds since Unix epoch.

- limit:

  Maximum number of rows to return. Must not exceed `500`.

- json_list:

  If `TRUE`, return the parsed list instead of a `data.table`.

- config:

  A futures configuration created by
  [`config_futures()`](https://oliverlds.github.io/binxr/reference/config_futures.md).

## Value

A `data.table` by default, or a parsed list when `json_list = TRUE`.
