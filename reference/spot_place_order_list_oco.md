# Place a Binance Spot OCO order list

Place a Binance Spot OCO order list

## Usage

``` r
spot_place_order_list_oco(
  symbol,
  side = c("BUY", "SELL"),
  quantity,
  above_type = c("STOP_LOSS_LIMIT", "STOP_LOSS", "LIMIT_MAKER", "TAKE_PROFIT",
    "TAKE_PROFIT_LIMIT"),
  above_client_order_id = NULL,
  above_iceberg_qty = NULL,
  above_price = NULL,
  above_stop_price = NULL,
  above_trailing_delta = NULL,
  above_time_in_force = NULL,
  above_strategy_id = NULL,
  above_strategy_type = NULL,
  above_peg_price_type = NULL,
  above_peg_offset_type = NULL,
  above_peg_offset_value = NULL,
  below_type = c("STOP_LOSS", "STOP_LOSS_LIMIT", "TAKE_PROFIT", "TAKE_PROFIT_LIMIT"),
  below_client_order_id = NULL,
  below_iceberg_qty = NULL,
  below_price = NULL,
  below_stop_price = NULL,
  below_trailing_delta = NULL,
  below_time_in_force = NULL,
  below_strategy_id = NULL,
  below_strategy_type = NULL,
  below_peg_price_type = NULL,
  below_peg_offset_type = NULL,
  below_peg_offset_value = NULL,
  list_client_order_id = NULL,
  new_order_resp_type = NULL,
  self_trade_prevention_mode = NULL,
  config = config_spot()
)
```

## Arguments

- symbol:

  Trading pair symbol, for example `"BTCUSDT"`.

- side:

  One of `"BUY"` or `"SELL"`.

- quantity:

  Order quantity shared by both legs.

- above_type:

  Type for the above leg.

- above_client_order_id:

  Optional above-leg client ID.

- above_iceberg_qty:

  Optional above-leg iceberg quantity.

- above_price:

  Optional above-leg limit price.

- above_stop_price:

  Optional above-leg stop price.

- above_trailing_delta:

  Optional above-leg trailing delta.

- above_time_in_force:

  Optional above-leg time-in-force.

- above_strategy_id:

  Optional above-leg strategy ID.

- above_strategy_type:

  Optional above-leg strategy type.

- above_peg_price_type:

  Optional above-leg peg price type.

- above_peg_offset_type:

  Optional above-leg peg offset type.

- above_peg_offset_value:

  Optional above-leg peg offset value.

- below_type:

  Type for the below leg.

- below_client_order_id:

  Optional below-leg client ID.

- below_iceberg_qty:

  Optional below-leg iceberg quantity.

- below_price:

  Optional below-leg limit price.

- below_stop_price:

  Optional below-leg stop price.

- below_trailing_delta:

  Optional below-leg trailing delta.

- below_time_in_force:

  Optional below-leg time-in-force.

- below_strategy_id:

  Optional below-leg strategy ID.

- below_strategy_type:

  Optional below-leg strategy type.

- below_peg_price_type:

  Optional below-leg peg price type.

- below_peg_offset_type:

  Optional below-leg peg offset type.

- below_peg_offset_value:

  Optional below-leg peg offset value.

- list_client_order_id:

  Optional order-list client ID.

- new_order_resp_type:

  Optional response type. One of `"ACK"`, `"RESULT"`, or `"FULL"`.

- self_trade_prevention_mode:

  Optional self-trade prevention mode.

- config:

  A spot configuration created by
  [`config_spot()`](https://oliverlds.github.io/binxr/reference/config_spot.md).

## Value

A parsed list.
