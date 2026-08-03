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

test_that("futures conditional orders use the Algo Service", {
  cfg <- config_futures(api_key = "k", secret_key = "s")
  requests <- list()

  local_mocked_bindings(
    .request_signed = function(config, path, params = NULL, method = c("GET", "POST", "PUT", "DELETE")) {
      requests[[length(requests) + 1L]] <<- list(path = path, params = params, method = method)
      if (identical(path, "/fapi/v1/openAlgoOrders")) {
        return(list(list(algoId = "1", createTime = 1000)))
      }
      if (identical(path, "/fapi/v1/allAlgoOrders")) {
        return(list(list(algoId = "2", updateTime = 2000)))
      }
      list(path = path, params = params, method = method)
    },
    .package = "binxr"
  )

  expect_error(
    futures_place_order("BTCUSDT", type = "STOP_MARKET", quantity = 1, stop_price = 90, config = cfg),
    "futures_place_algo_order"
  )
  expect_error(
    futures_test_order("BTCUSDT", type = "TAKE_PROFIT", quantity = 1, config = cfg),
    "futures_place_algo_order"
  )
  expect_length(requests, 0L)

  place_out <- futures_place_algo_order(
    "BTCUSDT", type = "STOP_MARKET", quantity = 1, trigger_price = 90, config = cfg
  )
  cancel_out <- futures_cancel_algo_order("BTCUSDT", algo_id = 7, config = cfg)
  cancel_all_out <- futures_cancel_all_algo_orders("BTCUSDT", config = cfg)
  get_out <- futures_get_algo_order("BTCUSDT", client_algo_id = "client-1", config = cfg)
  open_out <- futures_get_open_algo_orders("BTCUSDT", config = cfg)
  history_out <- futures_get_algo_orders("BTCUSDT", limit = 10, config = cfg)

  expect_identical(place_out$path, "/fapi/v1/algoOrder")
  expect_identical(place_out$params$algoType, "CONDITIONAL")
  expect_identical(place_out$params$triggerPrice, 90)
  expect_identical(cancel_out$method, "DELETE")
  expect_identical(cancel_all_out$path, "/fapi/v1/algoOpenOrders")
  expect_identical(get_out$params$clientAlgoId, "client-1")
  expect_s3_class(open_out, "data.table")
  expect_s3_class(open_out$createTime, "POSIXct")
  expect_s3_class(history_out, "data.table")
  expect_s3_class(history_out$updateTime, "POSIXct")
})

test_that("futures order modification endpoints forward modify IDs", {
  cfg <- config_futures(api_key = "k", secret_key = "s")

  local_mocked_bindings(
    .request_signed = function(config, path, params = NULL, method = c("GET", "POST", "PUT", "DELETE")) {
      if (identical(path, "/fapi/v1/orderAmendment")) {
        return(list(list(orderId = "3", modifyId = "44", time = 1000)))
      }
      list(path = path, params = params, method = method)
    },
    .package = "binxr"
  )

  modify_out <- futures_modify_order(
    "BTCUSDT", quantity = 2, price = 100, order_id = 3, modify_id = 44, config = cfg
  )
  amendments_out <- futures_get_order_amendments("BTCUSDT", order_id = 3, config = cfg)

  expect_identical(modify_out$path, "/fapi/v1/order")
  expect_identical(modify_out$method, "PUT")
  expect_identical(modify_out$params$modifyId, 44)
  expect_s3_class(amendments_out, "data.table")
  expect_equal(amendments_out$modifyId, 44)
  expect_s3_class(amendments_out$time, "POSIXct")
})

test_that("futures batch, margin, income, and open-order helpers forward parameters", {
  cfg <- config_futures(api_key = "k", secret_key = "s")

  local_mocked_bindings(
    .request_signed = function(config, path, params = NULL, method = c("GET", "POST", "PUT", "DELETE")) {
      list(path = path, params = params, method = method)
    },
    .package = "binxr"
  )

  position_mode <- futures_set_position_mode(FALSE, config = cfg)
  place <- futures_place_batch_orders(list(list(symbol = "BTCUSDT", side = "BUY", type = "MARKET", quantity = 1)), config = cfg)
  modify <- futures_modify_batch_orders(list(list(symbol = "BTCUSDT", orderId = 1, side = "BUY", quantity = 2, price = 100)), config = cfg)
  cancel <- futures_cancel_batch_orders("BTCUSDT", order_ids = c(1, 2), config = cfg)
  margin <- futures_modify_position_margin("BTCUSDT", amount = 1, type = "REDUCE", config = cfg)
  margin_history <- futures_get_position_margin_history("BTCUSDT", type = "ADD", json_list = TRUE, config = cfg)
  income <- futures_get_income_history("BTCUSDT", income_type = "REALIZED_PNL", json_list = TRUE, config = cfg)
  open_order <- futures_get_open_order("BTCUSDT", order_id = 1, config = cfg)

  expect_identical(position_mode$path, "/fapi/v1/positionSide/dual")
  expect_identical(place$path, "/fapi/v1/batchOrders")
  expect_identical(place$method, "POST")
  expect_match(place$params$batchOrders, "BTCUSDT", fixed = TRUE)
  expect_identical(modify$method, "PUT")
  expect_identical(cancel$method, "DELETE")
  expect_identical(cancel$params$orderIdList, "[1,2]")
  expect_identical(margin$params$type, 2L)
  expect_identical(margin_history$params$type, 1L)
  expect_identical(income$params$incomeType, "REALIZED_PNL")
  expect_identical(open_order$path, "/fapi/v1/openOrder")
})
