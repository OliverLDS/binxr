# Get standardized Binance Futures positions

Get standardized Binance Futures positions

## Usage

``` r
futures_get_positions(acc = NULL, json_list = FALSE, config = config_futures())

get_fapi_account_positions(acc = NULL, config = binxr_config_futures())
```

## Arguments

- acc:

  Optional account payload from
  [`futures_get_account()`](https://oliverlds.github.io/binxr/reference/futures_get_account.md).
  If `NULL`, account data is fetched.

- json_list:

  If `TRUE`, return the parsed list instead of a `data.table`.

- config:

  A futures configuration created by
  [`config_futures()`](https://oliverlds.github.io/binxr/reference/config_futures.md).

## Value

A `data.table` by default, or a parsed list when `json_list = TRUE`.
