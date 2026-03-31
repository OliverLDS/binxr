# Get Binance Options open orders

Get Binance Options open orders

## Usage

``` r
options_get_open_orders(
  symbol = NULL,
  order_id = NULL,
  startTime = NULL,
  endTime = NULL,
  json_list = FALSE,
  config = config_options()
)
```

## Arguments

- symbol:

  Optional option symbol.

- order_id:

  Optional order ID to start from.

- startTime:

  Optional start time in milliseconds since Unix epoch.

- endTime:

  Optional end time in milliseconds since Unix epoch.

- json_list:

  If `TRUE`, return the parsed list instead of a `data.table`.

- config:

  An options configuration created by
  [`config_options()`](https://oliverlds.github.io/binxr/reference/config_options.md).

## Value

A `data.table` by default, or a parsed list when `json_list = TRUE`.
