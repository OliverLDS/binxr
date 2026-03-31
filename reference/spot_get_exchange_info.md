# Get Binance Spot exchange information

Get Binance Spot exchange information

## Usage

``` r
spot_get_exchange_info(
  symbol = NULL,
  symbols = NULL,
  permissions = NULL,
  show_permission_sets = TRUE,
  symbol_status = NULL,
  config = config_spot()
)
```

## Arguments

- symbol:

  Optional trading pair symbol.

- symbols:

  Optional character vector of trading pair symbols.

- permissions:

  Optional character vector of permission strings.

- show_permission_sets:

  Logical flag forwarded as `showPermissionSets`.

- symbol_status:

  Optional trading status filter.

- config:

  A spot configuration created by
  [`config_spot()`](https://oliverlds.github.io/binxr/reference/config_spot.md).

## Value

A parsed list.
