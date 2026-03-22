test_that("futures account expansion endpoints call signed paths and shape outputs", {
  cfg <- config_futures(api_key = "k", secret_key = "s")

  local_mocked_bindings(
    .request_signed = function(config, path, params = NULL, method = c("GET", "POST", "PUT", "DELETE")) {
      switch(
        path,
        "/fapi/v3/balance" = list(list(asset = "USDT", balance = "10", crossWalletBalance = "9", crossUnPnl = "1", availableBalance = "8", maxWithdrawAmount = "7", updateTime = 1000)),
        "/fapi/v1/rateLimit/order" = list(list(intervalNum = 1, limit = 1200)),
        list(path = path, params = params, method = method)
      )
    },
    .package = "binxr"
  )

  balance_out <- futures_get_balance(config = cfg)
  position_mode_out <- futures_get_position_mode(config = cfg)
  multi_assets_out <- futures_get_multi_assets_mode(config = cfg)
  commission_out <- futures_get_commission_rate("BTCUSDT", config = cfg)
  rate_limit_out <- futures_get_order_rate_limit(config = cfg)

  expect_s3_class(balance_out, "data.table")
  expect_equal(balance_out$balance, 10)
  expect_s3_class(balance_out$updateTime, "POSIXct")

  expect_identical(position_mode_out$path, "/fapi/v1/positionSide/dual")
  expect_identical(multi_assets_out$path, "/fapi/v1/multiAssetsMargin")
  expect_identical(commission_out$params$symbol, "BTCUSDT")

  expect_s3_class(rate_limit_out, "data.table")
  expect_equal(rate_limit_out$limit, 1200)
})

test_that("deprecated futures account aliases warn and forward", {
  acc <- list(
    totalWalletBalance = "10",
    totalUnrealizedProfit = "2",
    totalInitialMargin = "3",
    totalMaintMargin = "1",
    availableBalance = "7",
    maxWithdrawAmount = "6"
  )

  out <- NULL
  expect_warning(
    out <- get_fapi_account_summary(acc = acc),
    "deprecated"
  )

  expect_s3_class(out, "data.table")
  expect_equal(out$availableBalance, 7)
})
