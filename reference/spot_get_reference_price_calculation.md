# Get Binance Spot reference price calculation metadata

Get Binance Spot reference price calculation metadata

## Usage

``` r
spot_get_reference_price_calculation(
  symbol,
  symbol_status = NULL,
  config = config_spot()
)
```

## Arguments

- symbol:

  Trading pair symbol, for example `"BTCUSDT"`.

- symbol_status:

  Optional trading status filter.

- config:

  A spot configuration created by
  [`config_spot()`](https://oliverlds.github.io/binxr/reference/config_spot.md).

## Value

A parsed list.
