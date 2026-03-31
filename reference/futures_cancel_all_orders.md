# Cancel all open Binance Futures orders for a symbol

Cancel all open Binance Futures orders for a symbol

## Usage

``` r
futures_cancel_all_orders(symbol, config = config_futures())

cancel_fapi_trade_orders_all(symbol, config = binxr_config_futures())
```

## Arguments

- symbol:

  Trading pair symbol, for example `"ETHUSDT"`.

- config:

  A futures configuration created by
  [`config_futures()`](https://oliverlds.github.io/binxr/reference/config_futures.md).

## Value

A parsed list.
