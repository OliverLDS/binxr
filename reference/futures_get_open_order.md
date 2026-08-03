# Get a current open Binance Futures order

Get a current open Binance Futures order

## Usage

``` r
futures_get_open_order(
  symbol,
  order_id = NULL,
  orig_client_order_id = NULL,
  config = config_futures()
)
```

## Arguments

- symbol:

  Trading pair symbol, for example `"ETHUSDT"`.

- order_id:

  Optional exchange order ID.

- orig_client_order_id:

  Optional client order ID.

- config:

  A futures configuration created by
  [`config_futures()`](https://oliverlds.github.io/binxr/reference/config_futures.md).

## Value

A parsed list.
