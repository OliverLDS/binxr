test_that("futures_place_order rejects silently ignored parameters", {
  cfg <- config_futures(api_key = "k", secret_key = "s")

  expect_error(
    futures_place_order(
      symbol = "BTCUSDT",
      side = "BUY",
      type = "MARKET",
      quantity = 1,
      time_in_force = "GTC",
      config = cfg
    ),
    "time_in_force"
  )

  expect_error(
    futures_place_order(
      symbol = "BTCUSDT",
      side = "BUY",
      type = "LIMIT",
      quantity = 1,
      price = 100,
      time_in_force = "GTC",
      working_type = "MARK_PRICE",
      config = cfg
    ),
    "working_type"
  )
})

test_that("legacy spot wrapper forwards to canonical name", {
  local_mocked_bindings(
    .request_public = function(config, path, query = NULL) {
      list(symbol = query$symbol, price = "100")
    },
    .package = "binxr"
  )

  out <- get_spot_mark_price("BTCUSDT")

  expect_identical(out$symbol, "BTCUSDT")
})
