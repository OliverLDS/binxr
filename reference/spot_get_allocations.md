# Get Binance Spot allocations

Get Binance Spot allocations

## Usage

``` r
spot_get_allocations(
  symbol,
  start_time = NULL,
  end_time = NULL,
  from_allocation_id = NULL,
  limit = 500,
  order_id = NULL,
  json_list = FALSE,
  config = config_spot()
)
```

## Arguments

- symbol:

  Trading pair symbol, for example `"BTCUSDT"`.

- start_time:

  Optional start time in milliseconds.

- end_time:

  Optional end time in milliseconds.

- from_allocation_id:

  Optional allocation ID to start from.

- limit:

  Maximum number of records to return. Must not exceed `1000`.

- order_id:

  Optional exchange order ID.

- json_list:

  If `TRUE`, return the parsed list instead of a `data.table`.

- config:

  A spot configuration created by
  [`config_spot()`](https://oliverlds.github.io/binxr/reference/config_spot.md).

## Value

A `data.table` by default, or a parsed list when `json_list = TRUE`.
