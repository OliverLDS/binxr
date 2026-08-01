# Modify a Binance Futures limit order

Modify a Binance Futures limit order

## Usage

``` r
futures_modify_order(
  symbol,
  side = c("BUY", "SELL"),
  quantity,
  price,
  order_id = NULL,
  orig_client_order_id = NULL,
  modify_id = NULL,
  config = config_futures()
)
```

## Arguments

- symbol:

  Trading pair symbol.

- side:

  One of `"BUY"` or `"SELL"`.

- quantity:

  Replacement order quantity.

- price:

  Replacement limit price.

- order_id:

  Optional exchange order ID.

- orig_client_order_id:

  Optional client order ID.

- modify_id:

  Optional user-defined modification identifier.

- config:

  A futures configuration created by
  [`config_futures()`](https://oliverlds.github.io/binxr/reference/config_futures.md).

## Value

A parsed list.
