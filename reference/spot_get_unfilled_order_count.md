# Get Binance Spot unfilled order counts

Get Binance Spot unfilled order counts

## Usage

``` r
spot_get_unfilled_order_count(json_list = FALSE, config = config_spot())
```

## Arguments

- json_list:

  If `TRUE`, return the parsed list instead of a `data.table`.

- config:

  A spot configuration created by
  [`config_spot()`](https://oliverlds.github.io/binxr/reference/config_spot.md).

## Value

A `data.table` by default, or a parsed list when `json_list = TRUE`.
