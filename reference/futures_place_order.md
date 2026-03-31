# Place a Binance Futures order

Place a Binance Futures order

## Usage

``` r
futures_place_order(
  symbol,
  side = c("BUY", "SELL"),
  type = c("LIMIT", "MARKET", "STOP", "STOP_MARKET", "TAKE_PROFIT", "TAKE_PROFIT_MARKET",
    "TRAILING_STOP_MARKET"),
  quantity,
  price = NULL,
  time_in_force = NULL,
  position_side = c("BOTH", "LONG", "SHORT"),
  reduce_only = FALSE,
  stop_price = NULL,
  working_type = NULL,
  new_client_order_id = NULL,
  config = config_futures()
)

place_fapi_trade_order(
  symbol,
  side = c("BUY", "SELL"),
  type = c("LIMIT", "MARKET", "STOP", "STOP_MARKET", "TAKE_PROFIT", "TAKE_PROFIT_MARKET",
    "TRAILING_STOP_MARKET"),
  quantity,
  price = NULL,
  timeInForce = c("GTC", "IOC", "FOK", "GTX"),
  positionSide = c("BOTH", "LONG", "SHORT"),
  reduceOnly = FALSE,
  stopPrice = NULL,
  workingType = c("CONTRACT_PRICE", "MARK_PRICE"),
  newClientOrderId = NULL,
  config = binxr_config_futures()
)
```

## Arguments

- symbol:

  Trading pair symbol, for example `"ETHUSDT"`.

- side:

  One of `"BUY"` or `"SELL"`.

- type:

  Order type.

- quantity:

  Order quantity.

- price:

  Optional limit price.

- time_in_force:

  Optional time-in-force value. Required for `LIMIT`.

- position_side:

  One of `"BOTH"`, `"LONG"`, or `"SHORT"`.

- reduce_only:

  Whether the order is reduce-only.

- stop_price:

  Optional trigger price for conditional orders.

- working_type:

  Optional trigger source. Must only be supplied with `stop_price`.

- new_client_order_id:

  Optional client order identifier.

- config:

  A futures configuration created by
  [`config_futures()`](https://oliverlds.github.io/binxr/reference/config_futures.md).

- timeInForce:

  Legacy alias for `time_in_force`.

- positionSide:

  Legacy alias for `position_side`.

- reduceOnly:

  Legacy alias for `reduce_only`.

- stopPrice:

  Legacy alias for `stop_price`.

- workingType:

  Legacy alias for `working_type`.

- newClientOrderId:

  Legacy alias for `new_client_order_id`.

## Value

A parsed list.
