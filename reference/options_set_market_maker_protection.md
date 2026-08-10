# Set Binance Options market maker protection configuration

This endpoint is available only to eligible Options market-maker
accounts.

## Usage

``` r
options_set_market_maker_protection(
  underlying,
  window_time_ms,
  frozen_time_ms,
  quantity_limit,
  delta_limit,
  config = config_options()
)
```

## Arguments

- underlying:

  Underlying symbol, for example `"BTCUSDT"`.

- window_time_ms:

  MMP evaluation interval in milliseconds.

- frozen_time_ms:

  MMP freeze time in milliseconds. Set to `0` to require a manual reset
  after MMP triggers.

- quantity_limit:

  Maximum quantity within an MMP interval.

- delta_limit:

  Maximum net delta within an MMP interval.

- config:

  An options configuration created by
  [`config_options()`](https://oliverlds.github.io/binxr/reference/config_options.md).

## Value

A parsed list.
