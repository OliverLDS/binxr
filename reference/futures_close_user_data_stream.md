# Close a Binance Futures user data stream

Close a Binance Futures user data stream

## Usage

``` r
futures_close_user_data_stream(listen_key, config = config_futures())
```

## Arguments

- listen_key:

  Listen key returned by
  [`futures_start_user_data_stream()`](https://oliverlds.github.io/binxr/reference/futures_start_user_data_stream.md).

- config:

  A futures configuration created by
  [`config_futures()`](https://oliverlds.github.io/binxr/reference/config_futures.md)
  with an API key.

## Value

A parsed list.
