# Get a Binance Spot order

Get a Binance Spot order

## Usage

``` r
spot_get_order(
  symbol,
  order_id = NULL,
  orig_client_order_id = NULL,
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

- config:

  A spot configuration created by
  [`config_spot()`](https://oliverlds.github.io/binxr/reference/config_spot.md).

## Value

A parsed list.
