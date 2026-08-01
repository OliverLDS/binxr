# Get Binance Futures historical trades

This endpoint returns trades from only the previous month and has
request weight 200. Use it sparingly.

## Usage

``` r
futures_get_historical_trades(
  symbol,
  limit = 100,
  fromId = NULL,
  json_list = FALSE,
  config = config_futures()
)
```

## Arguments

- symbol:

  Trading pair symbol, for example `"ETHUSDT"`.

- limit:

  Maximum number of trades to return. Must not exceed `500`.

- fromId:

  Optional trade identifier to fetch from.

- json_list:

  If `TRUE`, return the parsed list instead of a `data.table`.

- config:

  A futures configuration created by
  [`config_futures()`](https://oliverlds.github.io/binxr/reference/config_futures.md).

## Value

A `data.table` by default, or a parsed list when `json_list = TRUE`.
