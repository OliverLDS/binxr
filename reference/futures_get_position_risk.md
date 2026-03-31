# Get Binance Futures position risk

Get Binance Futures position risk

## Usage

``` r
futures_get_position_risk(json_list = FALSE, config = config_futures())

get_fapi_account_position_risk(config = binxr_config_futures())
```

## Arguments

- json_list:

  If `TRUE`, return the parsed list instead of a `data.table`.

- config:

  A futures configuration created by
  [`config_futures()`](https://oliverlds.github.io/binxr/reference/config_futures.md).

## Value

A `data.table` by default, or a parsed list when `json_list = TRUE`.
