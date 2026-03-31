# Set Binance Futures position mode

Set Binance Futures position mode

## Usage

``` r
futures_set_position_mode(dual_side_position = TRUE, config = config_futures())

set_fapi_account_position_side(
  dualSidePosition = TRUE,
  config = binxr_config_futures()
)
```

## Arguments

- dual_side_position:

  `TRUE` for hedge mode, `FALSE` for one-way mode.

- config:

  A futures configuration created by
  [`config_futures()`](https://oliverlds.github.io/binxr/reference/config_futures.md).

- dualSidePosition:

  Legacy alias for `dual_side_position`.

## Value

A parsed list.
