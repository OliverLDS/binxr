test_that("futures market endpoints validate and shape responses", {
  cfg <- config_futures()

  expect_error(
    futures_get_order_book("BTCUSDT", limit = 7, config = cfg),
    "limit"
  )

  expect_error(
    futures_get_aggregate_trades(
      symbol = "BTCUSDT",
      fromId = 1,
      startTime = 0,
      config = cfg
    ),
    "fromId"
  )

  local_mocked_bindings(
    .request_public = function(config, path, query = NULL) {
      switch(
        path,
        "/fapi/v1/trades" = list(list(id = "1", price = "100", qty = "2", quoteQty = "200", time = 1000)),
        "/fapi/v1/aggTrades" = list(list(a = "1", p = "100", q = "2", f = "1", l = "1", T = 2000)),
        "/fapi/v1/fundingRate" = list(list(symbol = "BTCUSDT", fundingRate = "0.01", fundingTime = 3000, markPrice = "100")),
        "/fapi/v1/markPriceKlines" = list(list(0, "1", "2", "0.5", "1.5", "10", 1000, "15", 2, "4", "6", "0")),
        list(path = path, query = query)
      )
    },
    .package = "binxr"
  )

  trades_out <- futures_get_recent_trades("BTCUSDT")
  agg_out <- futures_get_aggregate_trades("BTCUSDT")
  funding_out <- futures_get_funding_rate_history(symbol = "BTCUSDT")
  kline_out <- futures_get_mark_price_klines("BTCUSDT", "1m")

  expect_s3_class(trades_out, "data.table")
  expect_equal(trades_out$id, 1)
  expect_s3_class(trades_out$time, "POSIXct")

  expect_s3_class(agg_out, "data.table")
  expect_equal(agg_out$a, 1)
  expect_s3_class(agg_out$T, "POSIXct")

  expect_s3_class(funding_out, "data.table")
  expect_equal(funding_out$fundingRate, 0.01)
  expect_s3_class(funding_out$fundingTime, "POSIXct")

  expect_s3_class(kline_out, "data.table")
  expect_equal(kline_out$open, 1)
})
