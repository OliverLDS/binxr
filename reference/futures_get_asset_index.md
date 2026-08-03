# Get Binance Futures asset index prices

Get Binance Futures asset index prices

## Usage

``` r
futures_get_asset_index(
  asset = NULL,
  json_list = FALSE,
  config = config_futures()
)
```

## Arguments

- asset:

  Optional asset symbol, for example `"USDT"`.

- json_list:

  If `TRUE`, return the parsed list instead of a `data.table`.

- config:

  A futures configuration created by
  [`config_futures()`](https://oliverlds.github.io/binxr/reference/config_futures.md).

## Value

A `data.table` by default, or a parsed list when `json_list = TRUE`.
