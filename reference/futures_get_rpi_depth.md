# Get Binance Futures RPI order book

Get Binance Futures RPI order book

## Usage

``` r
futures_get_rpi_depth(symbol, limit = NULL, config = config_futures())
```

## Arguments

- symbol:

  Trading pair symbol, for example `"ETHUSDT"`.

- limit:

  Optional depth limit. One of `5`, `10`, `20`, `50`, `100`, `500`, or
  `1000`.

- config:

  A futures configuration created by
  [`config_futures()`](https://oliverlds.github.io/binxr/reference/config_futures.md).

## Value

A parsed list.
