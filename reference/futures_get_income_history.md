# Get Binance Futures income history

Get Binance Futures income history

## Usage

``` r
futures_get_income_history(
  symbol = NULL,
  income_type = NULL,
  start_time = NULL,
  end_time = NULL,
  limit = 100,
  json_list = FALSE,
  config = config_futures()
)
```

## Arguments

- symbol:

  Optional trading pair symbol.

- income_type:

  Optional Binance income type.

- start_time:

  Optional start time in milliseconds since Unix epoch.

- end_time:

  Optional end time in milliseconds since Unix epoch.

- limit:

  Maximum number of rows to return. Must not exceed `1000`.

- json_list:

  If `TRUE`, return the parsed list instead of a `data.table`.

- config:

  A futures configuration created by
  [`config_futures()`](https://oliverlds.github.io/binxr/reference/config_futures.md).

## Value

A `data.table` by default, or a parsed list when `json_list = TRUE`.
