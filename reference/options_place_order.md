# Place a Binance Options order

Place a Binance Options order

## Usage

``` r
options_place_order(
  symbol,
  side = c("BUY", "SELL"),
  type = c("LIMIT"),
  quantity,
  price,
  time_in_force = c("GTC", "IOC", "FOK"),
  reduce_only = FALSE,
  post_only = FALSE,
  new_order_resp_type = c("ACK", "RESULT"),
  client_order_id = NULL,
  is_mmp = FALSE,
  self_trade_prevention_mode = NULL,
  config = config_options()
)
```

## Arguments

- symbol:

  Option symbol, for example `"BTC-200730-9000-C"`.

- side:

  One of `"BUY"` or `"SELL"`.

- type:

  Order type. Only `"LIMIT"` is currently supported.

- quantity:

  Order quantity.

- price:

  Order price.

- time_in_force:

  Time in force. Default is `"GTC"`.

- reduce_only:

  Whether the order is reduce-only.

- post_only:

  Whether the order is post-only.

- new_order_resp_type:

  Response type. One of `"ACK"` or `"RESULT"`.

- client_order_id:

  Optional client order ID.

- is_mmp:

  Whether the order is an MMP order.

- self_trade_prevention_mode:

  Optional STP mode.

- config:

  An options configuration created by
  [`config_options()`](https://oliverlds.github.io/binxr/reference/config_options.md).

## Value

A parsed list.
