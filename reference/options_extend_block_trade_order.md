# Extend a Binance Options block trade order

Extends the block-order expiry by 30 minutes from the current time.

## Usage

``` r
options_extend_block_trade_order(
  block_order_matching_key,
  config = config_options()
)
```

## Arguments

- block_order_matching_key:

  Block trade matching key.

- config:

  An options configuration created by
  [`config_options()`](https://oliverlds.github.io/binxr/reference/config_options.md).

## Value

A parsed list.
