# Modify multiple Binance Futures orders

Modify multiple Binance Futures orders

## Usage

``` r
futures_modify_batch_orders(orders, config = config_futures())
```

## Arguments

- orders:

  A non-empty list of order modification parameter lists. Each element
  uses Binance REST parameter names.

- config:

  A futures configuration created by
  [`config_futures()`](https://oliverlds.github.io/binxr/reference/config_futures.md).

## Value

A parsed list.
