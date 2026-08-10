# Get Binance Options account block trades

This endpoint is intended for eligible Options market-maker accounts.

## Usage

``` r
options_get_account_block_trades(
  underlying = NULL,
  startTime = NULL,
  endTime = NULL,
  json_list = FALSE,
  config = config_options()
)
```

## Arguments

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
