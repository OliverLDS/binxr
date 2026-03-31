# Get Binance Futures account trades

Get Binance Futures account trades

## Usage

``` r
futures_get_account_trades(
  symbol,
  order_id = NULL,
  startTime = NULL,
  endTime = NULL,
  fromId = NULL,
  limit = 500,
  json_list = FALSE,
  config = config_futures()
)
```

## Arguments

- symbol:

  Trading pair symbol, for example `"ETHUSDT"`.

- order_id:

  Optional order ID.

- startTime:

  Optional start time in milliseconds since Unix epoch.

- endTime:

  Optional end time in milliseconds since Unix epoch.

- fromId:

  Optional trade ID to start from.

- limit:

  Maximum number of rows to return. Must not exceed `1000`.

- json_list:

  If `TRUE`, return the parsed list instead of a `data.table`.

- config:

  A futures configuration created by
  [`config_futures()`](https://oliverlds.github.io/binxr/reference/config_futures.md).

## Value

A `data.table` by default, or a parsed list when `json_list = TRUE`.
