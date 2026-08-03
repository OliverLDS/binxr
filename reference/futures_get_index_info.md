# Get Binance Futures composite index information

Get Binance Futures composite index information

## Usage

``` r
futures_get_index_info(
  symbol = NULL,
  json_list = FALSE,
  config = config_futures()
)
```

## Arguments

- symbol:

  Optional composite-index symbol.

- json_list:

  If `TRUE`, return the parsed list instead of a `data.table`.

- config:

  A futures configuration created by
  [`config_futures()`](https://oliverlds.github.io/binxr/reference/config_futures.md).

## Value

A `data.table` by default, or a parsed list when `json_list = TRUE`.
