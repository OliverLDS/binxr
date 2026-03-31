# Place a deprecated Binance Spot OCO order

Place a deprecated Binance Spot OCO order

## Usage

``` r
spot_place_oco_order(
  symbol,
  side = c("BUY", "SELL"),
  quantity,
  price,
  stop_price,
  list_client_order_id = NULL,
  limit_client_order_id = NULL,
  limit_strategy_id = NULL,
  limit_strategy_type = NULL,
  limit_iceberg_qty = NULL,
  trailing_delta = NULL,
  stop_client_order_id = NULL,
  stop_strategy_id = NULL,
  stop_strategy_type = NULL,
  stop_limit_price = NULL,
  stop_iceberg_qty = NULL,
  stop_limit_time_in_force = NULL,
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

- price:

  Limit price for the maker leg.

- stop_price:

  Stop trigger price.

- list_client_order_id:

  Optional order-list client ID.

- limit_client_order_id:

  Optional limit-leg client ID.

- limit_strategy_id:

  Optional limit-leg strategy ID.

- limit_strategy_type:

  Optional limit-leg strategy type.

- limit_iceberg_qty:

  Optional limit-leg iceberg quantity.

- trailing_delta:

  Optional shared trailing delta.

- stop_client_order_id:

  Optional stop-leg client ID.

- stop_strategy_id:

  Optional stop-leg strategy ID.

- stop_strategy_type:

  Optional stop-leg strategy type.

- stop_limit_price:

  Optional stop-limit price.

- stop_iceberg_qty:

  Optional stop-leg iceberg quantity.

- stop_limit_time_in_force:

  Optional stop-limit time-in-force.

- new_order_resp_type:

  Optional response type. One of `"ACK"`, `"RESULT"`, or `"FULL"`.

- self_trade_prevention_mode:

  Optional self-trade prevention mode.

- config:

  A spot configuration created by
  [`config_spot()`](https://oliverlds.github.io/binxr/reference/config_spot.md).

## Value

A parsed list.
