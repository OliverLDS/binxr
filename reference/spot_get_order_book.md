# Get Binance Spot order book

Get Binance Spot order book

## Usage

``` r
spot_get_order_book(
  symbol,
  limit = NULL,
  symbol_status = NULL,
  config = config_spot()
)
```

## Arguments

- symbol:

  Trading pair symbol, for example `"BTCUSDT"`.

- limit:

  Optional order book depth limit.

- symbol_status:

  Optional trading status filter.

- config:

  A spot configuration created by
  [`config_spot()`](https://oliverlds.github.io/binxr/reference/config_spot.md).

## Value

A parsed list.
