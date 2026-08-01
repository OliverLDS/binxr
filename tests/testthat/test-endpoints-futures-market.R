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

test_that("new futures market endpoints validate and shape responses", {
  cfg <- config_futures()

  expect_error(futures_get_historical_trades("BTCUSDT", limit = 501, config = cfg), "limit")
  expect_error(futures_get_rpi_depth("BTCUSDT", limit = 7, config = cfg), "limit")

  local_mocked_bindings(
    .request_public = function(config, path, query = NULL) {
      switch(
        path,
        "/fapi/v1/historicalTrades" = list(list(id = "1", price = "100", qty = "2", quoteQty = "200", time = 1000, isRPITrade = TRUE)),
        "/fapi/v1/insuranceBalance" = list(list(symbol = "BTCUSDT", balance = "1000", time = 2000)),
        list(path = path, query = query)
      )
    },
    .package = "binxr"
  )

  historical_out <- futures_get_historical_trades("BTCUSDT", fromId = 5, config = cfg)
  rpi_out <- futures_get_rpi_depth("BTCUSDT", limit = 20, config = cfg)
  constituents_out <- futures_get_index_constituents("BTCUSDT", config = cfg)
  insurance_out <- futures_get_insurance_balance("BTCUSDT", limit = 10, config = cfg)
  schedule_out <- futures_get_trading_schedule(config = cfg)
  adl_risk_out <- futures_get_symbol_adl_risk("BTCUSDT", config = cfg)

  expect_s3_class(historical_out, "data.table")
  expect_equal(historical_out$id, 1)
  expect_true(historical_out$isRPITrade)
  expect_s3_class(historical_out$time, "POSIXct")
  expect_identical(rpi_out$path, "/fapi/v1/rpiDepth")
  expect_identical(rpi_out$query$limit, 20)
  expect_identical(constituents_out$path, "/fapi/v1/constituents")
  expect_s3_class(insurance_out, "data.table")
  expect_equal(insurance_out$balance, "1000")
  expect_identical(schedule_out$path, "/fapi/v1/tradingSchedule")
  expect_identical(adl_risk_out$path, "/fapi/v1/symbolAdlRisk")
  expect_identical(adl_risk_out$query$symbol, "BTCUSDT")
})
