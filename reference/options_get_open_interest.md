# Get Binance Options open interest

Get Binance Options open interest

## Usage

``` r
options_get_open_interest(
  underlying_asset,
  expiration,
  json_list = FALSE,
  config = config_options()
)
```

## Arguments

- underlying_asset:

  Underlying asset, for example `"BTCUSDT"`.

- expiration:

  Expiration date, for example `"221225"`.

- json_list:

  If `TRUE`, return the parsed list instead of a `data.table`.

- config:

  An options configuration created by
  [`config_options()`](https://oliverlds.github.io/binxr/reference/config_options.md).

## Value

A `data.table` by default, or a parsed list when `json_list = TRUE`.
