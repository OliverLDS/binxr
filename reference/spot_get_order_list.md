# Get a Binance Spot order list

Get a Binance Spot order list

## Usage

``` r
spot_get_order_list(
  order_list_id = NULL,
  orig_client_order_id = NULL,
  config = config_spot()
)
```

## Arguments

- order_list_id:

  Optional exchange order-list ID.

- orig_client_order_id:

  Optional order-list client ID.

- config:

  A spot configuration created by
  [`config_spot()`](https://oliverlds.github.io/binxr/reference/config_spot.md).

## Value

A parsed list.
