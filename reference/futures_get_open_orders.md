# Get Binance Futures open orders

Get Binance Futures open orders

## Usage

``` r
futures_get_open_orders(
  symbol = NULL,
  json_list = FALSE,
  config = config_futures()
)

get_fapi_trade_open_orders(symbol = NULL, config = binxr_config_futures())
```

## Arguments

- symbol:

  Optional trading pair symbol. If `NULL`, returns all open orders.

- json_list:

  If `TRUE`, return the parsed list instead of a `data.table`.

- config:

  A futures configuration created by
  [`config_futures()`](https://oliverlds.github.io/binxr/reference/config_futures.md).

## Value

A `data.table` by default, or a parsed list when `json_list = TRUE`.
