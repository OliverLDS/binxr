# Cancel a Binance Futures algo order

Cancel a Binance Futures algo order

## Usage

``` r
futures_cancel_algo_order(
  symbol,
  algo_id = NULL,
  client_algo_id = NULL,
  config = config_futures()
)
```

## Arguments

- symbol:

  Trading pair symbol.

- algo_id:

  Optional exchange algo-order ID.

- client_algo_id:

  Optional client algo-order ID.

- config:

  A futures configuration created by
  [`config_futures()`](https://oliverlds.github.io/binxr/reference/config_futures.md).

## Value

A parsed list.
