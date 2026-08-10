# Reset Binance Options market maker protection

This endpoint is available only to eligible Options market-maker
accounts.

## Usage

``` r
options_reset_market_maker_protection(underlying, config = config_options())
```

## Arguments

- underlying:

  Underlying symbol, for example `"BTCUSDT"`.

- config:

  An options configuration created by
  [`config_options()`](https://oliverlds.github.io/binxr/reference/config_options.md).

## Value

A parsed list.
