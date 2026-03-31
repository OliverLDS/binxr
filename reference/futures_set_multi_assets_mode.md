# Set Binance Futures multi-assets mode

Set Binance Futures multi-assets mode

## Usage

``` r
futures_set_multi_assets_mode(
  multi_assets_margin = TRUE,
  config = config_futures()
)
```

## Arguments

- multi_assets_margin:

  `TRUE` to enable multi-assets mode, `FALSE` to disable it.

- config:

  A futures configuration created by
  [`config_futures()`](https://oliverlds.github.io/binxr/reference/config_futures.md).

## Value

A parsed list.
