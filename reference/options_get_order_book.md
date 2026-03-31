# Get Binance Options order book

Get Binance Options order book

## Usage

``` r
options_get_order_book(symbol, limit = NULL, config = config_options())
```

## Arguments

- symbol:

  Option symbol, for example `"BTC-200730-9000-C"`.

- limit:

  Optional depth limit. One of `10`, `20`, `50`, `100`, `500`, or
  `1000`.

- config:

  An options configuration created by
  [`config_options()`](https://oliverlds.github.io/binxr/reference/config_options.md).

## Value

A parsed list.
