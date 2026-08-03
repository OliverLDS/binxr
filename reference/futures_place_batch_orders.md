# Place multiple Binance Futures orders

Place multiple Binance Futures orders

## Usage

``` r
futures_place_batch_orders(orders, config = config_futures())
```

## Arguments

- orders:

  A non-empty list of order parameter lists. Each element uses Binance
  REST parameter names, for example `symbol`, `side`, `type`, and
  `quantity`.

- config:

  A futures configuration created by
  [`config_futures()`](https://oliverlds.github.io/binxr/reference/config_futures.md).

## Value

A parsed list.
