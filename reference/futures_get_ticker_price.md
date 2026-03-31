# Get Binance Futures ticker price

Get Binance Futures ticker price

## Usage

``` r
futures_get_ticker_price(
  symbol = NULL,
  version = c("v2", "deprecated"),
  config = config_futures()
)
```

## Arguments

- symbol:

  Optional trading pair symbol.

- version:

  One of `"v2"` or `"deprecated"`.

- config:

  A futures configuration created by
  [`config_futures()`](https://oliverlds.github.io/binxr/reference/config_futures.md).

## Value

A parsed list.
