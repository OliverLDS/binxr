# Get Binance Spot open orders

Get Binance Spot open orders

## Usage

``` r
spot_get_open_orders(symbol = NULL, json_list = FALSE, config = config_spot())
```

## Arguments

- symbol:

  Optional trading pair symbol. If `NULL`, returns all open orders.

- json_list:

  If `TRUE`, return the parsed list instead of a `data.table`.

- config:

  A spot configuration created by
  [`config_spot()`](https://oliverlds.github.io/binxr/reference/config_spot.md).

## Value

A `data.table` by default, or a parsed list when `json_list = TRUE`.
