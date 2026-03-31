# Get Binance Options 24hr ticker statistics

Get Binance Options 24hr ticker statistics

## Usage

``` r
options_get_24hr_ticker(
  symbol = NULL,
  json_list = FALSE,
  config = config_options()
)
```

## Arguments

- symbol:

  Optional option symbol.

- json_list:

  If `TRUE`, return the parsed list instead of a `data.table`.

- config:

  An options configuration created by
  [`config_options()`](https://oliverlds.github.io/binxr/reference/config_options.md).

## Value

A `data.table` by default, or a parsed list when `json_list = TRUE`.
