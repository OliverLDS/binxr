# Amend a Binance Spot order while keeping priority

Amend a Binance Spot order while keeping priority

## Usage

``` r
spot_amend_order_keep_priority(
  symbol,
  order_id = NULL,
  orig_client_order_id = NULL,
  new_client_order_id = NULL,
  new_qty,
  config = config_spot()
)
```

## Arguments

- symbol:

  Trading pair symbol, for example `"BTCUSDT"`.

- order_id:

  Optional exchange order ID.

- orig_client_order_id:

  Optional client order ID.

- new_client_order_id:

  Optional new client order ID after amendment.

- new_qty:

  New order quantity. Must be positive.

- config:

  A spot configuration created by
  [`config_spot()`](https://oliverlds.github.io/binxr/reference/config_spot.md).

## Value

A parsed list.
