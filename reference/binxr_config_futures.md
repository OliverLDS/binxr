# Backward-compatible futures config constructor

Backward-compatible futures config constructor

## Usage

``` r
binxr_config_futures(
  api_key = Sys.getenv("BINX_API_KEY", unset = ""),
  secret_key = Sys.getenv("BINX_SECRET_KEY", unset = ""),
  base = "https://fapi.binance.com",
  recvWindow = 10000L
)
```

## Arguments

- api_key:

  character API key. Leave `NULL` for unsigned/public requests.

- secret_key:

  character Secret key. Leave `NULL` for unsigned/public requests.

- base:

  Legacy alias for `base_url`.

- recvWindow:

  Legacy alias for `recv_window`.

## Value

A `binxr_config` list.
