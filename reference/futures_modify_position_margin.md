# Change Binance Futures position margin

Change Binance Futures position margin

## Usage

``` r
futures_modify_position_margin(
  symbol,
  amount,
  type = c("ADD", "REDUCE"),
  position_side = c("BOTH", "LONG", "SHORT"),
  config = config_futures()
)
```

## Arguments

- symbol:

  Trading pair symbol.

- amount:

  Margin amount to add or reduce.

- type:

  Either `"ADD"` or `"REDUCE"`.

- position_side:

  One of `"BOTH"`, `"LONG"`, or `"SHORT"`.

- config:

  A futures configuration created by
  [`config_futures()`](https://oliverlds.github.io/binxr/reference/config_futures.md).

## Value

A parsed list.
