# Get Binance Futures order history

Get Binance Futures order history

## Usage

``` r
futures_get_orders(
  symbol,
  limit = 500,
  json_list = FALSE,
  config = config_futures()
)

get_fapi_trade_orders(symbol, limit = 500, config = binxr_config_futures())
```

## Arguments

- symbol:

  Trading pair symbol, for example `"ETHUSDT"`.

- limit:

  Maximum number of orders to return.

- json_list:

  If `TRUE`, return the parsed list instead of a `data.table`.

- config:

  A futures configuration created by
  [`config_futures()`](https://oliverlds.github.io/binxr/reference/config_futures.md).

## Value

A `data.table` by default, or a parsed list when `json_list = TRUE`.
