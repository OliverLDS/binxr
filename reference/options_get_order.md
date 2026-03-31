# Get a Binance Options order

Get a Binance Options order

## Usage

``` r
options_get_order(
  symbol,
  order_id = NULL,
  client_order_id = NULL,
  config = config_options()
)
```

## Arguments

- symbol:

  Option symbol, for example `"BTC-200730-9000-C"`.

- order_id:

  Optional exchange order ID.

- client_order_id:

  Optional client order ID.

- config:

  An options configuration created by
  [`config_options()`](https://oliverlds.github.io/binxr/reference/config_options.md).

## Value

A parsed list.
