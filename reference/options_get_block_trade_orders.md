# Get Binance Options block trade orders

This endpoint is intended for eligible Options market-maker accounts.

## Usage

``` r
options_get_block_trade_orders(
  block_order_matching_key = NULL,
  underlying = NULL,
  startTime = NULL,
  endTime = NULL,
  json_list = FALSE,
  config = config_options()
)
```

## Arguments

- block_order_matching_key:

  Optional block trade matching key.

- underlying:

  Optional underlying symbol, for example `"BTCUSDT"`.

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
