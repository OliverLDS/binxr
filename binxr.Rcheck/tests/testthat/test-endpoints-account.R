test_that("futures_get_positions keeps zero and short positions by default", {
  acc <- list(
    positions = list(
      list(symbol = "BTCUSDT", positionAmt = "0", initialMargin = "0", leverage = "20", updateTime = 0),
      list(symbol = "ETHUSDT", positionAmt = "-1.5", initialMargin = "12.3", leverage = "10", updateTime = 1000)
    )
  )

  out <- futures_get_positions(acc = acc)

  expect_s3_class(out, "data.table")
  expect_equal(nrow(out), 2L)
  expect_equal(out$positionAmt, c(0, -1.5))
})

test_that("futures_get_positions returns raw list when json_list is TRUE", {
  positions <- list(list(symbol = "BTCUSDT", positionAmt = "1"))
  acc <- list(positions = positions)

  out <- futures_get_positions(acc = acc, json_list = TRUE)

  expect_identical(out, positions)
})

test_that("futures_get_account_summary supports data.table and list return shapes", {
  acc <- list(
    totalWalletBalance = "10",
    totalUnrealizedProfit = "2",
    totalInitialMargin = "3",
    totalMaintMargin = "1",
    availableBalance = "7",
    maxWithdrawAmount = "6"
  )

  dt_out <- futures_get_account_summary(acc = acc)
  list_out <- futures_get_account_summary(acc = acc, json_list = TRUE)

  expect_s3_class(dt_out, "data.table")
  expect_equal(dt_out$totalWalletBalance, 10)
  expect_type(list_out, "list")
  expect_equal(list_out$availableBalance, 7)
})
