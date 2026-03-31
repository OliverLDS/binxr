# Get Binance Spot prevented matches

Get Binance Spot prevented matches

## Usage

``` r
spot_get_prevented_matches(
  symbol,
  prevented_match_id = NULL,
  order_id = NULL,
  from_prevented_match_id = NULL,
  limit = 500,
  json_list = FALSE,
  config = config_spot()
)
```

## Arguments

- symbol:

  Trading pair symbol, for example `"BTCUSDT"`.

- prevented_match_id:

  Optional prevented-match ID.

- order_id:

  Optional exchange order ID.

- from_prevented_match_id:

  Optional prevented-match ID to start from.

- limit:

  Maximum number of records to return. Must not exceed `1000`.

- json_list:

  If `TRUE`, return the parsed list instead of a `data.table`.

- config:

  A spot configuration created by
  [`config_spot()`](https://oliverlds.github.io/binxr/reference/config_spot.md).

## Value

A `data.table` by default, or a parsed list when `json_list = TRUE`.
