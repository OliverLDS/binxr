# Place a Binance Spot SOR order

Place a Binance Spot SOR order

## Usage

``` r
spot_place_sor_order(
  symbol,
  side = c("BUY", "SELL"),
  type = c("LIMIT", "MARKET"),
  quantity,
  time_in_force = NULL,
  price = NULL,
  new_client_order_id = NULL,
  strategy_id = NULL,
  strategy_type = NULL,
  iceberg_qty = NULL,
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

- type:

  SOR order type. One of `"LIMIT"` or `"MARKET"`.

- quantity:

  Order quantity.

- time_in_force:

  Optional time-in-force value.

- price:

  Optional limit price.

- new_client_order_id:

  Optional client order identifier.

- strategy_id:

  Optional numeric strategy identifier.

- strategy_type:

  Optional numeric strategy type. Must be at least `1000000`.

- iceberg_qty:

  Optional iceberg quantity.

- new_order_resp_type:

  Optional response type. One of `"ACK"`, `"RESULT"`, or `"FULL"`.

- self_trade_prevention_mode:

  Optional self-trade prevention mode.

- config:

  A spot configuration created by
  [`config_spot()`](https://oliverlds.github.io/binxr/reference/config_spot.md).

## Value

A parsed list.
