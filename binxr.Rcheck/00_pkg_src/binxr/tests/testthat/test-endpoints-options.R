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
