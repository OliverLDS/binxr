test_that("options market/account/trade endpoints validate and shape responses", {
  cfg_public <- config_options()
  cfg_signed <- config_options(api_key = "k", secret_key = "s")

  expect_error(
    options_get_order("BTC-200730-9000-C", config = cfg_signed),
    "Provide at least one of: order_id, client_order_id"
  )

  local_mocked_bindings(
    .request_public = function(config, path, query = NULL) {
      switch(
        path,
        "/eapi/v1/trades" = list(list(id = "1", tradeId = "2", price = "100", qty = "1", quoteQty = "100", side = "-1", time = 1000)),
        "/eapi/v1/blockTrades" = list(list(id = "3", tradeId = "4", price = "90", qty = "2", quoteQty = "180", side = "1", time = 2000)),
        "/eapi/v1/klines" = list(list(0, "1", "2", "0.5", "1.5", "10", 1000, "15", 2, "4", "6", "0")),
        "/eapi/v1/mark" = list(list(symbol = "BTC-200730-9000-C", markPrice = "100", delta = "0.1")),
        "/eapi/v1/ticker" = list(list(symbol = "BTC-200730-9000-C", priceChange = "1", openTime = 0, closeTime = 1000)),
        "/eapi/v1/openInterest" = list(list(symbol = "ETH-221119-1175-P", sumOpenInterest = "4.01", sumOpenInterestUsd = "4880.2985", timestamp = "1668754020000")),
        "/eapi/v1/exerciseHistory" = list(list(symbol = "BTC-220121-60000-P", strikePrice = "60000", realStrikePrice = "38844.6965", expiryDate = 1000)),
        list(path = path, query = query)
      )
    },
    .request_signed = function(config, path, params = NULL, method = c("GET", "POST", "PUT", "DELETE")) {
      switch(
        path,
        "/eapi/v1/order" = list(path = path, params = params, method = method),
        "/eapi/v1/openOrders" = list(list(orderId = "1", price = "100", quantity = "1", executedQty = "0", avgPrice = "0", createTime = 1000, updateTime = 1000)),
        "/eapi/v1/historyOrders" = list(list(orderId = "2", price = "110", quantity = "1", executedQty = "1", avgPrice = "110", createTime = 1000, updateTime = 2000)),
        "/eapi/v1/userTrades" = list(list(id = "5", tradeId = "6", orderId = "2", price = "100", quantity = "1", fee = "0", realizedProfit = "1", time = 3000)),
        "/eapi/v1/position" = list(list(entryPrice = "100", quantity = "-0.1", markValue = "105", unrealizedPNL = "5", markPrice = "1050", strikePrice = "9000", expiryDate = 1000, time = 2000)),
        "/eapi/v1/bill" = list(list(id = "7", amount = "-0.5", createDate = 4000)),
        list(path = path, params = params, method = method)
      )
    },
    .package = "binxr"
  )

  expect_identical(options_ping(cfg_public)$path, "/eapi/v1/ping")

  recent_trades <- options_get_recent_trades("BTC-200730-9000-C", config = cfg_public)
  block_trades <- options_get_recent_block_trades(config = cfg_public)
  klines <- options_get_klines("BTC-200730-9000-C", "1m", config = cfg_public)
  mark <- options_get_mark_price(config = cfg_public)
  ticker <- options_get_24hr_ticker(config = cfg_public)
  open_interest <- options_get_open_interest("BTCUSDT", "221225", config = cfg_public)
  exercise_history <- options_get_exercise_history(config = cfg_public)

  place <- options_place_order("BTC-200730-9000-C", quantity = 1, price = 100, config = cfg_signed)
  open_orders <- options_get_open_orders(config = cfg_signed)
  order_history <- options_get_order_history("BTC-200730-9000-C", config = cfg_signed)
  trades <- options_get_account_trades(config = cfg_signed)
  positions <- options_get_positions(config = cfg_signed)
  funding <- options_get_funding_flow(config = cfg_signed)

  expect_s3_class(recent_trades, "data.table")
  expect_s3_class(block_trades, "data.table")
  expect_s3_class(klines, "data.table")
  expect_s3_class(mark, "data.table")
  expect_s3_class(ticker, "data.table")
  expect_s3_class(open_interest, "data.table")
  expect_s3_class(exercise_history, "data.table")

  expect_identical(place$path, "/eapi/v1/order")
  expect_s3_class(open_orders, "data.table")
  expect_s3_class(order_history, "data.table")
  expect_s3_class(trades, "data.table")
  expect_s3_class(positions, "data.table")
  expect_s3_class(funding, "data.table")
})

test_that("options batch, stock-contract, and listen-key helpers use documented paths", {
  cfg_signed <- config_options(api_key = "k", secret_key = "s")
  cfg_api_key <- config_options(api_key = "k", secret_key = NULL)

  local_mocked_bindings(
    .request_signed = function(config, path, params = NULL, method = c("GET", "POST", "PUT", "DELETE")) {
      list(path = path, params = params, method = method)
    },
    .request_api_key = function(config, path, params = NULL, method = c("GET", "POST", "PUT", "DELETE")) {
      list(path = path, params = params, method = method)
    },
    .package = "binxr"
  )

  place <- options_place_batch_orders(list(list(symbol = "BTC-200730-9000-C", side = "BUY", quantity = 1, price = 100)), config = cfg_signed)
  cancel <- options_cancel_batch_orders(c(1, 2), config = cfg_signed)
  contract <- options_sign_stock_contract(config = cfg_signed)
  start <- options_start_user_data_stream(config = cfg_api_key)
  keepalive <- options_keepalive_user_data_stream("listen-key", config = cfg_api_key)
  close <- options_close_user_data_stream("listen-key", config = cfg_api_key)

  expect_identical(place$path, "/eapi/v1/batchOrders")
  expect_identical(place$method, "POST")
  expect_identical(cancel$params$orderIds, "[1,2]")
  expect_identical(contract$path, "/eapi/v1/stock/contract")
  expect_identical(start$method, "POST")
  expect_identical(keepalive$method, "PUT")
  expect_identical(keepalive$params$listenKey, "listen-key")
  expect_identical(close$method, "DELETE")
})

test_that("opt-in Options block trade and market maker endpoints use signed paths", {
  cfg <- config_options(api_key = "k", secret_key = "s")
  expect_error(options_place_block_trade_order(list(), config = cfg), "legs")
  expect_error(options_set_market_maker_protection("BTCUSDT", 1000, -1, 1, 1, config = cfg), "frozen_time_ms")

  local_mocked_bindings(
    .request_signed = function(config, path, params = NULL, method = c("GET", "POST", "PUT", "DELETE")) {
      list(path = path, params = params, method = method)
    },
    .package = "binxr"
  )

  legs <- list(list(symbol = "BTC-200730-9000-C", side = "BUY", type = "LIMIT", quantity = 1, price = 100))
  place <- options_place_block_trade_order(legs, config = cfg)
  extend <- options_extend_block_trade_order("key", config = cfg)
  cancel <- options_cancel_block_trade_order("key", config = cfg)
  orders <- options_get_block_trade_orders("key", underlying = "BTCUSDT", json_list = TRUE, config = cfg)
  accept <- options_accept_block_trade_order("key", config = cfg)
  details <- options_get_block_trade_details("key", config = cfg)
  trades <- options_get_account_block_trades("BTCUSDT", json_list = TRUE, config = cfg)
  mmp <- options_get_market_maker_protection("BTCUSDT", config = cfg)
  set_mmp <- options_set_market_maker_protection("BTCUSDT", 1000, 0, 1, 2, config = cfg)
  reset_mmp <- options_reset_market_maker_protection("BTCUSDT", config = cfg)

  expect_identical(place$path, "/eapi/v1/block/order/create")
  expect_identical(place$method, "POST")
  expect_match(place$params$legs, "BTC-200730-9000-C", fixed = TRUE)
  expect_identical(extend$method, "PUT")
  expect_identical(cancel$method, "DELETE")
  expect_identical(orders$path, "/eapi/v1/block/order/orders")
  expect_identical(orders$params$underlying, "BTCUSDT")
  expect_identical(accept$path, "/eapi/v1/block/order/execute")
  expect_identical(accept$method, "POST")
  expect_identical(details$method, "GET")
  expect_identical(trades$path, "/eapi/v1/block/user-trades")
  expect_identical(mmp$path, "/eapi/v1/mmp")
  expect_identical(set_mmp$params$windowTimeInMilliseconds, 1000)
  expect_identical(set_mmp$params$frozenTimeInMilliseconds, 0)
  expect_identical(reset_mmp$path, "/eapi/v1/mmpReset")
})
