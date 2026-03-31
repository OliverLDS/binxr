# Get Binance Spot open order lists

Get Binance Spot open order lists

## Usage

``` r
spot_get_open_order_lists(json_list = FALSE, config = config_spot())
```

## Arguments

- json_list:

  If `TRUE`, return the parsed list instead of a `data.table`.

- config:

  A spot configuration created by
  [`config_spot()`](https://oliverlds.github.io/binxr/reference/config_spot.md).

## Value

A `data.table` by default, or a parsed list when `json_list = TRUE`.
