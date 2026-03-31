# Get Binance Spot 24-hour ticker statistics

Get Binance Spot 24-hour ticker statistics

## Usage

``` r
spot_get_24hr_ticker(
  symbol = NULL,
  symbols = NULL,
  type = c("FULL", "MINI"),
  symbol_status = NULL,
  json_list = FALSE,
  config = config_spot()
)
```

## Arguments

- symbol:

  Optional trading pair symbol.

- symbols:

  Optional character vector of trading pair symbols.

- type:

  One of `"FULL"` or `"MINI"`.

- symbol_status:

  Optional trading status filter.

- json_list:

  If `TRUE`, return the parsed list instead of converting array
  responses to `data.table`.

- config:

  A spot configuration created by
  [`config_spot()`](https://oliverlds.github.io/binxr/reference/config_spot.md).

## Value

A parsed list for single-symbol requests, or a `data.table` for
multi-symbol/all-symbol requests unless `json_list = TRUE`.
