# Place a Binance Options block trade order

This endpoint is intended for eligible Options market-maker accounts.
Binance currently supports one leg per block trade order.

## Usage

``` r
options_place_block_trade_order(
  legs,
  liquidity = c("MAKER", "TAKER"),
  config = config_options()
)
```

## Arguments

- legs:

  A single-element list of block-order leg parameters using Binance REST
  names, such as `symbol`, `side`, `type`, `quantity`, and `price`.

- liquidity:

  One of `"MAKER"` or `"TAKER"`.

- config:

  An options configuration created by
  [`config_options()`](https://oliverlds.github.io/binxr/reference/config_options.md).

## Value

A parsed list.
