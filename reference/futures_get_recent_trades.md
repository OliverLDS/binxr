# Get Binance Futures recent trades

Get Binance Futures recent trades

## Usage

``` r
futures_get_recent_trades(
  symbol,
  limit = 500,
  json_list = FALSE,
  config = config_futures()
)
```

## Arguments

- symbol:

  Trading pair symbol, for example `"ETHUSDT"`.

- limit:

  Maximum number of trades to return. Must not exceed `1000`.

- json_list:

  If `TRUE`, return the parsed list instead of a `data.table`.

- config:

  A futures configuration created by
  [`config_futures()`](https://oliverlds.github.io/binxr/reference/config_futures.md).

## Value

A `data.table` by default, or a parsed list when `json_list = TRUE`.
