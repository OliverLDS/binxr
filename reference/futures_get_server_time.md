# Get Binance Futures server time

Get Binance Futures server time

## Usage

``` r
futures_get_server_time(config = config_futures())

get_fapi_system_time(config = binxr_config_futures())
```

## Arguments

- config:

  A futures configuration created by
  [`config_futures()`](https://oliverlds.github.io/binxr/reference/config_futures.md).

## Value

A `POSIXct` timestamp.
