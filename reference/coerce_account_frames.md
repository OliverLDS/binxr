# (Optional) Coerce account to data.frames

(Optional) Coerce account to data.frames

## Usage

``` r
coerce_account_frames(account)
```

## Arguments

- account:

  get_account() result

## Value

list(assets=..., positions=...)

## Examples

``` r
account <- list(
  assets = list(list(asset = "USDT", walletBalance = "10")),
  positions = list(list(symbol = "ETHUSDT", positionAmt = "0"))
)
coerce_account_frames(account)
#> $assets
#>   asset walletBalance
#> 1  USDT            10
#> 
#> $positions
#>    symbol positionAmt
#> 1 ETHUSDT           0
#> 
```
