# Get Binance Options recent trades

Get Binance Options recent trades

## Usage

``` r
options_get_recent_trades(
  symbol,
  limit = 100,
  json_list = FALSE,
  config = config_options()
)
```

## Arguments

- symbol:

  Option symbol, for example `"BTC-200730-9000-C"`.

- limit:

  Maximum number of trades to return. Must not exceed `500`.

- json_list:

  If `TRUE`, return the parsed list instead of a `data.table`.

- config:

  An options configuration created by
  [`config_options()`](https://oliverlds.github.io/binxr/reference/config_options.md).

## Value

A `data.table` by default, or a parsed list when `json_list = TRUE`.
