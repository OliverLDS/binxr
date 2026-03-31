# Place a Binance Spot OTO order list

Place a Binance Spot OTO order list

## Usage

``` r
spot_place_order_list_oto(
  symbol,
  list_client_order_id = NULL,
  new_order_resp_type = NULL,
  self_trade_prevention_mode = NULL,
  working_type = c("LIMIT", "LIMIT_MAKER"),
  working_side = c("BUY", "SELL"),
  working_client_order_id = NULL,
  working_price,
  working_quantity,
  working_iceberg_qty = NULL,
  working_time_in_force = NULL,
  working_strategy_id = NULL,
  working_strategy_type = NULL,
  working_peg_price_type = NULL,
  working_peg_offset_type = NULL,
  working_peg_offset_value = NULL,
  pending_type = c("LIMIT", "MARKET", "STOP_LOSS", "STOP_LOSS_LIMIT", "TAKE_PROFIT",
    "TAKE_PROFIT_LIMIT", "LIMIT_MAKER"),
  pending_side = c("BUY", "SELL"),
  pending_client_order_id = NULL,
  pending_price = NULL,
  pending_stop_price = NULL,
  pending_trailing_delta = NULL,
  pending_quantity,
  pending_iceberg_qty = NULL,
  pending_time_in_force = NULL,
  pending_strategy_id = NULL,
  pending_strategy_type = NULL,
  pending_peg_price_type = NULL,
  pending_peg_offset_type = NULL,
  pending_peg_offset_value = NULL,
  config = config_spot()
)
```

## Arguments

- symbol:

  Trading pair symbol, for example `"BTCUSDT"`.

- list_client_order_id:

  Optional order-list client ID.

- new_order_resp_type:

  Optional response type. One of `"ACK"`, `"RESULT"`, or `"FULL"`.

- self_trade_prevention_mode:

  Optional self-trade prevention mode.

- working_type:

  Working leg type. One of `"LIMIT"` or `"LIMIT_MAKER"`.

- working_side:

  Working leg side. One of `"BUY"` or `"SELL"`.

- working_client_order_id:

  Optional working-leg client ID.

- working_price:

  Working leg price.

- working_quantity:

  Working leg quantity.

- working_iceberg_qty:

  Optional working-leg iceberg quantity.

- working_time_in_force:

  Optional working-leg time-in-force.

- working_strategy_id:

  Optional working-leg strategy ID.

- working_strategy_type:

  Optional working-leg strategy type.

- working_peg_price_type:

  Optional working-leg peg price type.

- working_peg_offset_type:

  Optional working-leg peg offset type.

- working_peg_offset_value:

  Optional working-leg peg offset value.

- pending_type:

  Pending leg order type.

- pending_side:

  Pending leg side. One of `"BUY"` or `"SELL"`.

- pending_client_order_id:

  Optional pending-leg client ID.

- pending_price:

  Optional pending-leg price.

- pending_stop_price:

  Optional pending-leg stop price.

- pending_trailing_delta:

  Optional pending-leg trailing delta.

- pending_quantity:

  Pending leg quantity.

- pending_iceberg_qty:

  Optional pending-leg iceberg quantity.

- pending_time_in_force:

  Optional pending-leg time-in-force.

- pending_strategy_id:

  Optional pending-leg strategy ID.

- pending_strategy_type:

  Optional pending-leg strategy type.

- pending_peg_price_type:

  Optional pending-leg peg price type.

- pending_peg_offset_type:

  Optional pending-leg peg offset type.

- pending_peg_offset_value:

  Optional pending-leg peg offset value.

- config:

  A spot configuration created by
  [`config_spot()`](https://oliverlds.github.io/binxr/reference/config_spot.md).

## Value

A parsed list.
