# Get all Binance Spot order lists

Get all Binance Spot order lists

## Usage

``` r
spot_get_all_order_lists(
  from_id = NULL,
  start_time = NULL,
  end_time = NULL,
  limit = 500,
  json_list = FALSE,
  config = config_spot()
)
```

## Arguments

- from_id:

  Optional order-list ID to start from.

- start_time:

  Optional start time in milliseconds.

- end_time:

  Optional end time in milliseconds.

- limit:

  Maximum number of order lists to return. Must not exceed `1000`.

- json_list:

  If `TRUE`, return the parsed list instead of a `data.table`.

- config:

  A spot configuration created by
  [`config_spot()`](https://oliverlds.github.io/binxr/reference/config_spot.md).

## Value

A `data.table` by default, or a parsed list when `json_list = TRUE`.
