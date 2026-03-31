# Set Binance Futures leverage

Set Binance Futures leverage

## Usage

``` r
futures_set_leverage(symbol, leverage, config = config_futures())

set_fapi_account_leverage(symbol, leverage, config = binxr_config_futures())
```

## Arguments

- symbol:

  Trading pair symbol, for example `"ETHUSDT"`.

- leverage:

  Desired leverage.

- config:

  A futures configuration created by
  [`config_futures()`](https://oliverlds.github.io/binxr/reference/config_futures.md).

## Value

A parsed list.
