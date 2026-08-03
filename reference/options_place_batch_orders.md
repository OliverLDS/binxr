# Place multiple Binance Options orders

Place multiple Binance Options orders

## Usage

``` r
options_place_batch_orders(orders, config = config_options())
```

## Arguments

- orders:

  A non-empty list of order parameter lists. Each element uses Binance
  REST parameter names, for example `symbol`, `side`, `quantity`, and
  `price`.

- config:

  An options configuration created by
  [`config_options()`](https://oliverlds.github.io/binxr/reference/config_options.md).

## Value

A parsed list.
