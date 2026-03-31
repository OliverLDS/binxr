# Set Binance Futures margin type

Set Binance Futures margin type

## Usage

``` r
futures_set_margin_type(
  symbol,
  margin_type = c("CROSSED", "ISOLATED"),
  config = config_futures()
)

set_fapi_account_margin_type(
  symbol,
  marginType = c("CROSSED", "ISOLATED"),
  config = binxr_config_futures()
)
```

## Arguments

- symbol:

  Trading pair symbol, for example `"ETHUSDT"`.

- margin_type:

  One of `"CROSSED"` or `"ISOLATED"`.

- config:

  A futures configuration created by
  [`config_futures()`](https://oliverlds.github.io/binxr/reference/config_futures.md).

- marginType:

  Legacy alias for `margin_type`.

## Value

A parsed list.
