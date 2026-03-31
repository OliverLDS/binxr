# Cancel all open Binance Spot orders for a symbol

Cancel all open Binance Spot orders for a symbol

## Usage

``` r
spot_cancel_all_orders(symbol, config = config_spot())
```

## Arguments

- symbol:

  Trading pair symbol, for example `"BTCUSDT"`.

- config:

  A spot configuration created by
  [`config_spot()`](https://oliverlds.github.io/binxr/reference/config_spot.md).

## Value

A parsed list by default.
