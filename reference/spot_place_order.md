# Place a Binance Spot order

Place a Binance Spot order

## Usage

``` r
spot_place_order(
  symbol,
  side = c("BUY", "SELL"),
  type = c("LIMIT", "MARKET", "STOP_LOSS", "STOP_LOSS_LIMIT", "TAKE_PROFIT",
    "TAKE_PROFIT_LIMIT", "LIMIT_MAKER"),
  time_in_force = NULL,
  quantity = NULL,
  quote_order_qty = NULL,
  price = NULL,
  new_client_order_id = NULL,
  strategy_id = NULL,
  strategy_type = NULL,
  stop_price = NULL,
  trailing_delta = NULL,
  iceberg_qty = NULL,
  new_order_resp_type = NULL,
  self_trade_prevention_mode = NULL,
  peg_price_type = NULL,
  peg_offset_value = NULL,
  peg_offset_type = NULL,
  config = config_spot()
)
```

## Arguments

- symbol:

  Trading pair symbol, for example `"BTCUSDT"`.

- side:

  One of `"BUY"` or `"SELL"`.

- type:

  Order type.

- time_in_force:

  Optional time-in-force value.

- quantity:

  Optional order quantity.

- quote_order_qty:

  Optional quote-order quantity for `MARKET` orders.

- price:

  Optional limit price.

- new_client_order_id:

  Optional client order identifier.

- strategy_id:

  Optional numeric strategy identifier.

- strategy_type:

  Optional numeric strategy type. Must be at least `1000000`.

- stop_price:

  Optional trigger price.

- trailing_delta:

  Optional trailing delta value.

- iceberg_qty:

  Optional iceberg quantity.

- new_order_resp_type:

  Optional response type. One of `"ACK"`, `"RESULT"`, or `"FULL"`.

- self_trade_prevention_mode:

  Optional self-trade prevention mode.

- peg_price_type:

  Optional pegged price type. One of `"PRIMARY_PEG"` or `"MARKET_PEG"`.

- peg_offset_value:

  Optional peg offset value.

- peg_offset_type:

  Optional peg offset type. Only `"PRICE_LEVEL"` is supported.

- config:

  A spot configuration created by
  [`config_spot()`](https://oliverlds.github.io/binxr/reference/config_spot.md).

## Value

A parsed list.
