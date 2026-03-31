# Get Binance Options exercise records

Get Binance Options exercise records

## Usage

``` r
options_get_exercise_records(
  symbol = NULL,
  startTime = NULL,
  endTime = NULL,
  limit = 1000,
  json_list = FALSE,
  config = config_options()
)
```

## Arguments

- symbol:

  Optional option symbol.

- startTime:

  Optional start time in milliseconds since Unix epoch.

- endTime:

  Optional end time in milliseconds since Unix epoch.

- limit:

  Maximum number of rows to return. Must not exceed `1000`.

- json_list:

  If `TRUE`, return the parsed list instead of a `data.table`.

- config:

  An options configuration created by
  [`config_options()`](https://oliverlds.github.io/binxr/reference/config_options.md).

## Value

A `data.table` by default, or a parsed list when `json_list = TRUE`.
