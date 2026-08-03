# Cancel multiple Binance Futures orders

Cancel multiple Binance Futures orders

## Usage

``` r
futures_cancel_batch_orders(
  symbol,
  order_ids = NULL,
  orig_client_order_ids = NULL,
  config = config_futures()
)
```

## Arguments

- symbol:

  Trading pair symbol.

- order_ids:

  Optional numeric vector of exchange order IDs.

- orig_client_order_ids:

  Optional character vector of client order IDs.

- config:

  A futures configuration created by
  [`config_futures()`](https://oliverlds.github.io/binxr/reference/config_futures.md).

## Value

A parsed list.
