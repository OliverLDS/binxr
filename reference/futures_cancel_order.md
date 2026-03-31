# Cancel a Binance Futures order

Cancel a Binance Futures order

## Usage

``` r
futures_cancel_order(
  symbol,
  order_id = NULL,
  orig_client_order_id = NULL,
  config = config_futures()
)

cancel_fapi_trade_order(
  symbol,
  orderId = NULL,
  origClientOrderId = NULL,
  config = binxr_config_futures()
)
```

## Arguments

- symbol:

  Trading pair symbol, for example `"ETHUSDT"`.

- order_id:

  Optional exchange order ID.

- orig_client_order_id:

  Optional client order ID.

- config:

  A futures configuration created by
  [`config_futures()`](https://oliverlds.github.io/binxr/reference/config_futures.md).

- orderId:

  Legacy alias for `order_id`.

- origClientOrderId:

  Legacy alias for `orig_client_order_id`.

## Value

A parsed list.
