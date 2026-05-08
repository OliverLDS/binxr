# Round price and quantity to exchange increments

Round price and quantity to exchange increments

## Usage

``` r
round_price_qty(
  exchangeInfo,
  symbol,
  price = NULL,
  quantity = NULL,
  round_dir = c("down", "up")
)

util_round_price_qty(
  exchangeInfo,
  symbol,
  price = NULL,
  quantity = NULL,
  round_dir = c("down", "up")
)
```

## Arguments

- exchangeInfo:

  Exchange info from
  [`futures_get_exchange_info()`](https://oliverlds.github.io/binxr/reference/futures_get_exchange_info.md).

- symbol:

  Trading pair symbol, for example `"ETHUSDT"`.

- price:

  Optional price to round using the symbol tick size.

- quantity:

  Optional quantity to round using the symbol step size.

- round_dir:

  Direction: `"down"` or `"up"`.

## Value

A list with elements `price` and `quantity`.

## Examples

``` r
exchange_info <- list(
  symbols = list(
    ETHUSDT = list(
      filters = list(
        list(filterType = "PRICE_FILTER", tickSize = "0.01"),
        list(filterType = "LOT_SIZE", stepSize = "0.001")
      )
    )
  )
)
round_price_qty(exchange_info, "ETHUSDT", price = 1800.123, quantity = 0.12345)
#> $price
#> [1] 1800.12
#> 
#> $quantity
#> [1] 0.123
#> 
```
