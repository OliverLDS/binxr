# Get Binance Spot order history

Get Binance Spot order history

## Usage

``` r
spot_get_orders(
  symbol,
  order_id = NULL,
  start_time = NULL,
  end_time = NULL,
  limit = 500,
  json_list = FALSE,
  config = config_spot()
)
```

## Arguments

- symbol:

  Trading pair symbol, for example `"BTCUSDT"`.

- order_id:

  Optional exchange order ID to start from.

- start_time:

  Optional start time in milliseconds.

- end_time:

  Optional end time in milliseconds.

- limit:

  Maximum number of orders to return. Must not exceed `1000`.

- json_list:

  If `TRUE`, return the parsed list instead of a `data.table`.

- config:

  A spot configuration created by
  [`config_spot()`](https://oliverlds.github.io/binxr/reference/config_spot.md).

## Value

A `data.table` by default, or a parsed list when `json_list = TRUE`.
