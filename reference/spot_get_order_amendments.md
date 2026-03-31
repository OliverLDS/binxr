# Get Binance Spot order amendments

Get Binance Spot order amendments

## Usage

``` r
spot_get_order_amendments(
  symbol,
  order_id,
  from_execution_id = NULL,
  limit = 500,
  json_list = FALSE,
  config = config_spot()
)
```

## Arguments

- symbol:

  Trading pair symbol, for example `"BTCUSDT"`.

- order_id:

  Exchange order ID.

- from_execution_id:

  Optional execution ID to start from.

- limit:

  Maximum number of records to return. Must not exceed `1000`.

- json_list:

  If `TRUE`, return the parsed list instead of a `data.table`.

- config:

  A spot configuration created by
  [`config_spot()`](https://oliverlds.github.io/binxr/reference/config_spot.md).

## Value

A `data.table` by default, or a parsed list when `json_list = TRUE`.
