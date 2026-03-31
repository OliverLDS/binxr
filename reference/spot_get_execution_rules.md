# Get Binance Spot execution rules

Get Binance Spot execution rules

## Usage

``` r
spot_get_execution_rules(
  symbol = NULL,
  symbols = NULL,
  symbol_status = NULL,
  config = config_spot()
)
```

## Arguments

- symbol:

  Optional trading pair symbol.

- symbols:

  Optional character vector of trading pair symbols.

- symbol_status:

  Optional trading status filter.

- config:

  A spot configuration created by
  [`config_spot()`](https://oliverlds.github.io/binxr/reference/config_spot.md).

## Value

A parsed list.
