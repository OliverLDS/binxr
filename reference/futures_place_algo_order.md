# Place a Binance Futures algo order

Places a USD-M Futures conditional order through the Algo Service. Use
this function for stop-loss, take-profit, and trailing-stop order types.

## Usage

``` r
futures_place_algo_order(
  symbol,
  side = c("BUY", "SELL"),
  type = c("STOP", "STOP_MARKET", "TAKE_PROFIT", "TAKE_PROFIT_MARKET",
    "TRAILING_STOP_MARKET"),
  quantity = NULL,
  price = NULL,
  trigger_price = NULL,
  time_in_force = NULL,
  position_side = c("BOTH", "LONG", "SHORT"),
  reduce_only = FALSE,
  close_position = FALSE,
  working_type = c("CONTRACT_PRICE", "MARK_PRICE"),
  price_protect = FALSE,
  activation_price = NULL,
  callback_rate = NULL,
  new_client_algo_id = NULL,
  config = config_futures()
)
```

## Arguments

- symbol:

  Trading pair symbol, for example `"ETHUSDT"`.

- side:

  One of `"BUY"` or `"SELL"`.

- type:

  Conditional order type.

- quantity:

  Optional order quantity. Omit only when `close_position` is `TRUE`.

- price:

  Optional limit price for `"STOP"` and `"TAKE_PROFIT"`.

- trigger_price:

  Trigger price for non-trailing conditional orders.

- time_in_force:

  Optional time-in-force for limit conditional orders.

- position_side:

  One of `"BOTH"`, `"LONG"`, or `"SHORT"`.

- reduce_only:

  Whether the order is reduce-only.

- close_position:

  Whether to close the entire position when triggered.

- working_type:

  Trigger price source.

- price_protect:

  Whether to enable trigger price protection.

- activation_price:

  Optional activation price for a trailing stop.

- callback_rate:

  Required callback rate for a trailing stop.

- new_client_algo_id:

  Optional client algo-order identifier.

- config:

  A futures configuration created by
  [`config_futures()`](https://oliverlds.github.io/binxr/reference/config_futures.md).

## Value

A parsed list.
