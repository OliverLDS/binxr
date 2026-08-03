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

test_that("futures data endpoints validate and shape responses", {
  cfg <- config_futures()
  expect_error(futures_get_open_interest_history("BTCUSDT", period = "3m", config = cfg), "period")
  expect_error(futures_get_delivery_prices("BTCUSDT", limit = 101, config = cfg), "limit")

  local_mocked_bindings(
    .request_public = function(config, path, query = NULL) {
      switch(
        path,
        "/futures/data/openInterestHist" = list(list(sumOpenInterest = "2", sumOpenInterestValue = "200", timestamp = 1000)),
        "/futures/data/globalLongShortAccountRatio" = list(list(longShortRatio = "1.2", longAccount = "0.6", shortAccount = "0.5", timestamp = 1000)),
        "/futures/data/topLongShortAccountRatio" = list(list(longShortRatio = "1.3", longAccount = "0.7", shortAccount = "0.5", timestamp = 1000)),
        "/futures/data/topLongShortPositionRatio" = list(list(longShortRatio = "1.4", longAccount = "0.7", shortAccount = "0.5", timestamp = 1000)),
        "/futures/data/takerlongshortRatio" = list(list(buySellRatio = "1.1", buyVol = "10", sellVol = "9", timestamp = 1000)),
        "/futures/data/basis" = list(list(basis = "1", basisRate = "0.01", annualizedBasisRate = "0.1", indexPrice = "100", futuresPrice = "101", timestamp = 1000)),
        "/futures/data/delivery-price" = list(list(deliveryPrice = "100", deliveryTime = 1000)),
        "/fapi/v1/assetIndex" = list(list(asset = "USDT", assetIndex = "1", timestamp = 1000)),
        list(path = path, query = query)
      )
    },
    .package = "binxr"
  )

  open_interest <- futures_get_open_interest_history("BTCUSDT", period = "1h", limit = 10, config = cfg)
  global_ratio <- futures_get_global_long_short_ratio("BTCUSDT", config = cfg)
  account_ratio <- futures_get_top_long_short_account_ratio("BTCUSDT", config = cfg)
  position_ratio <- futures_get_top_long_short_position_ratio("BTCUSDT", config = cfg)
  taker_volume <- futures_get_taker_buy_sell_volume("BTCUSDT", config = cfg)
  basis <- futures_get_basis("BTCUSDT", "PERPETUAL", config = cfg)
  delivery <- futures_get_delivery_prices("BTCUSDT", config = cfg)
  index_info <- futures_get_index_info("BTCUSDT", json_list = TRUE, config = cfg)
  asset_index <- futures_get_asset_index("USDT", config = cfg)

  expect_s3_class(open_interest, "data.table")
  expect_equal(open_interest$sumOpenInterest, 2)
  expect_s3_class(open_interest$timestamp, "POSIXct")
  expect_equal(global_ratio$longShortRatio, 1.2)
  expect_equal(account_ratio$longAccount, 0.7)
  expect_equal(position_ratio$shortAccount, 0.5)
  expect_equal(taker_volume$buyVol, 10)
  expect_equal(basis$futuresPrice, 101)
  expect_s3_class(delivery$deliveryTime, "POSIXct")
  expect_identical(index_info$path, "/fapi/v1/indexInfo")
  expect_equal(asset_index$assetIndex, 1)
  expect_s3_class(asset_index$timestamp, "POSIXct")
})
