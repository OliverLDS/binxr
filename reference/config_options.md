# Create a Binance options configuration

Create a Binance options configuration

## Usage

``` r
config_options(
  api_key = Sys.getenv("BINX_API_KEY", unset = ""),
  secret_key = Sys.getenv("BINX_SECRET_KEY", unset = ""),
  base_url = "https://eapi.binance.com",
  recv_window = 10000L,
  timeout = 30,
  verbose = FALSE
)
```

## Arguments

- api_key:

  character API key. Leave `NULL` for unsigned/public requests.

- secret_key:

  character Secret key. Leave `NULL` for unsigned/public requests.

- base_url:

  character Base URL for the Binance Options API.

- recv_window:

  integer recvWindow in milliseconds used for signed requests.

- timeout:

  numeric request timeout in seconds.

- verbose:

  logical whether to enable verbose request debugging in future helpers.

## Value

A `binxr_config` list.
