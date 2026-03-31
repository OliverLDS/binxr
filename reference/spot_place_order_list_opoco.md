# Place a Binance Spot OPOCO order list

Place a Binance Spot OPOCO order list

## Usage

``` r
spot_place_order_list_opoco(
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
  pending_side = c("BUY", "SELL"),
  pending_above_type = c("STOP_LOSS_LIMIT", "STOP_LOSS", "LIMIT_MAKER", "TAKE_PROFIT",
    "TAKE_PROFIT_LIMIT"),
  pending_above_client_order_id = NULL,
  pending_above_price = NULL,
  pending_above_stop_price = NULL,
  pending_above_trailing_delta = NULL,
  pending_above_iceberg_qty = NULL,
  pending_above_time_in_force = NULL,
  pending_above_strategy_id = NULL,
  pending_above_strategy_type = NULL,
  pending_above_peg_price_type = NULL,
  pending_above_peg_offset_type = NULL,
  pending_above_peg_offset_value = NULL,
  pending_below_type = c("STOP_LOSS", "STOP_LOSS_LIMIT", "TAKE_PROFIT",
    "TAKE_PROFIT_LIMIT"),
  pending_below_client_order_id = NULL,
  pending_below_price = NULL,
  pending_below_stop_price = NULL,
  pending_below_trailing_delta = NULL,
  pending_below_iceberg_qty = NULL,
  pending_below_time_in_force = NULL,
  pending_below_strategy_id = NULL,
  pending_below_strategy_type = NULL,
  pending_below_peg_price_type = NULL,
  pending_below_peg_offset_type = NULL,
  pending_below_peg_offset_value = NULL,
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

- pending_side:

  Shared side for the pending OCO legs.

- pending_above_type:

  Type for the pending-above leg.

- pending_above_client_order_id:

  Optional pending-above client ID.

- pending_above_price:

  Optional pending-above price.

- pending_above_stop_price:

  Optional pending-above stop price.

- pending_above_trailing_delta:

  Optional pending-above trailing delta.

- pending_above_iceberg_qty:

  Optional pending-above iceberg quantity.

- pending_above_time_in_force:

  Optional pending-above time-in-force.

- pending_above_strategy_id:

  Optional pending-above strategy ID.

- pending_above_strategy_type:

  Optional pending-above strategy type.

- pending_above_peg_price_type:

  Optional pending-above peg price type.

- pending_above_peg_offset_type:

  Optional pending-above peg offset type.

- pending_above_peg_offset_value:

  Optional pending-above peg offset value.

- pending_below_type:

  Type for the pending-below leg.

- pending_below_client_order_id:

  Optional pending-below client ID.

- pending_below_price:

  Optional pending-below price.

- pending_below_stop_price:

  Optional pending-below stop price.

- pending_below_trailing_delta:

  Optional pending-below trailing delta.

- pending_below_iceberg_qty:

  Optional pending-below iceberg quantity.

- pending_below_time_in_force:

  Optional pending-below time-in-force.

- pending_below_strategy_id:

  Optional pending-below strategy ID.

- pending_below_strategy_type:

  Optional pending-below strategy type.

- pending_below_peg_price_type:

  Optional pending-below peg price type.

- pending_below_peg_offset_type:

  Optional pending-below peg offset type.

- pending_below_peg_offset_value:

  Optional pending-below peg offset value.

- config:

  A spot configuration created by
  [`config_spot()`](https://oliverlds.github.io/binxr/reference/config_spot.md).

## Value

A parsed list.
