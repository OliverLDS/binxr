# Get Binance Futures ADL quantiles

Get Binance Futures ADL quantiles

## Usage

``` r
futures_get_adl_quantile(
  symbol = NULL,
  json_list = FALSE,
  config = config_futures()
)
```

## Arguments

- symbol:

  Optional trading pair symbol.

- json_list:

  If `TRUE`, return the parsed list instead of a `data.table`.

- config:

  A futures configuration created by
  [`config_futures()`](https://oliverlds.github.io/binxr/reference/config_futures.md).

## Value

A `data.table` by default, or a parsed list when `json_list = TRUE`.
