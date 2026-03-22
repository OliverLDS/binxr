test_that("futures trade expansion validates and forwards params", {
  cfg <- config_futures(api_key = "k", secret_key = "s")

  expect_error(
    futures_get_account_trades(
      symbol = "BTCUSDT",
      fromId = 1,
      startTime = 0,
      config = cfg
    ),
    "fromId"
  )

  local_mocked_bindings(
    .request_signed = function(config, path, params = NULL, method = c("GET", "POST", "PUT", "DELETE")) {
      switch(
        path,
        "/fapi/v1/userTrades" = list(list(id = "1", orderId = "2", price = "100", qty = "1", quoteQty = "100", realizedPnl = "0.5", commission = "-0.1", time = 1000)),
        "/fapi/v1/forceOrders" = list(list(orderId = "3", price = "90", origQty = "1", executedQty = "1", averagePrice = "90", cumQuote = "90", time = 2000)),
        list(path = path, params = params, method = method)
      )
    },
    .package = "binxr"
  )

  test_out <- futures_test_order(
    symbol = "BTCUSDT",
    side = "BUY",
    type = "LIMIT",
    quantity = 1,
    price = 100,
    time_in_force = "GTC",
    config = cfg
  )
  multi_assets_out <- futures_set_multi_assets_mode(TRUE, config = cfg)
  countdown_out <- futures_countdown_cancel_all("BTCUSDT", 5000, config = cfg)
  trades_out <- futures_get_account_trades("BTCUSDT", config = cfg)
  force_out <- futures_get_force_orders(symbol = "BTCUSDT", config = cfg)

  expect_identical(test_out$path, "/fapi/v1/order/test")
  expect_identical(multi_assets_out$params$multiAssetsMargin, "true")
  expect_identical(countdown_out$params$countdownTime, 5000)

  expect_s3_class(trades_out, "data.table")
  expect_equal(trades_out$id, 1)
  expect_s3_class(trades_out$time, "POSIXct")

  expect_s3_class(force_out, "data.table")
  expect_equal(force_out$orderId, 3)
  expect_s3_class(force_out$time, "POSIXct")
})
