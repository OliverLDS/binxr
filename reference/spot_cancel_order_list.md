# Cancel a Binance Spot order list

Cancel a Binance Spot order list

## Usage

``` r
spot_cancel_order_list(
  symbol,
  order_list_id = NULL,
  list_client_order_id = NULL,
  new_client_order_id = NULL,
  config = config_spot()
)
```

## Arguments

- symbol:

  Trading pair symbol, for example `"BTCUSDT"`.

- order_list_id:

  Optional exchange order-list ID.

- list_client_order_id:

  Optional order-list client ID.

- new_client_order_id:

  Optional client order ID for the cancel request.

- config:

  A spot configuration created by
  [`config_spot()`](https://oliverlds.github.io/binxr/reference/config_spot.md).

## Value

A parsed list.
