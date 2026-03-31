# Get Binance Futures mark price

Get Binance Futures mark price

## Usage

``` r
futures_get_mark_price(symbol = NULL, config = config_futures())

get_fapi_mark_price(symbol = NULL, config = binxr_config_futures())
```

## Arguments

- symbol:

  Optional trading pair symbol such as `"ETHUSDT"`. If `NULL`, returns
  all symbols.

- config:

  A futures configuration created by
  [`config_futures()`](https://oliverlds.github.io/binxr/reference/config_futures.md).

## Value

A parsed list.
