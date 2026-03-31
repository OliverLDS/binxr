# Get Binance Futures exchange info

Get Binance Futures exchange info

## Usage

``` r
futures_get_exchange_info(config = config_futures())

get_fapi_exchange_info(config = binxr_config_futures())
```

## Arguments

- config:

  A futures configuration created by
  [`config_futures()`](https://oliverlds.github.io/binxr/reference/config_futures.md).

## Value

A parsed list. Symbol and asset lists are named when present.
