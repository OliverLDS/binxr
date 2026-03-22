test_that("spot account endpoints validate selectors and supported parameter combinations", {
  cfg <- config_spot(api_key = "k", secret_key = "s")

  expect_error(
    spot_get_order(symbol = "BTCUSDT", config = cfg),
    "Provide at least one of: order_id, orig_client_order_id"
  )

  expect_error(
    spot_get_all_order_lists(
      from_id = 1,
      start_time = 0,
      config = cfg
    ),
    "from_id"
  )

  expect_error(
    spot_get_account_trades(
      symbol = "BTCUSDT",
      order_id = 10,
      start_time = 0,
      config = cfg
    ),
    "order_id"
  )

  expect_error(
    spot_get_prevented_matches(
      symbol = "BTCUSDT",
      from_prevented_match_id = 2,
      config = cfg
    ),
    "Provide at least one of: prevented_match_id, order_id"
  )

  expect_error(
    spot_get_allocations(
      symbol = "BTCUSDT",
      start_time = 0,
      end_time = 24 * 60 * 60 * 1000 + 1,
      config = cfg
    ),
    "24 hours"
  )
})

test_that("spot account endpoints call signed paths and shape tabular responses", {
  cfg <- config_spot(api_key = "k", secret_key = "s")

  local_mocked_bindings(
    .request_signed = function(config, path, params = NULL, method = c("GET", "POST", "PUT", "DELETE")) {
      if (identical(path, "/api/v3/account")) {
        return(list(path = path, params = params, method = method))
      }
      if (identical(path, "/api/v3/order")) {
        return(list(path = path, params = params, method = method))
      }
      if (identical(path, "/api/v3/openOrders")) {
        return(list(list(orderId = "1", time = 1000, updateTime = 2000, price = "100.5")))
      }
      if (identical(path, "/api/v3/myTrades")) {
        return(list(list(id = "2", orderId = "9", price = "101", qty = "0.5", time = 3000)))
      }
      if (identical(path, "/api/v3/rateLimit/order")) {
        return(list(list(intervalNum = 10, limit = 50, count = 1)))
      }
      if (identical(path, "/api/v3/order/amendments")) {
        return(list(list(orderId = "9", executionId = "22", origQty = "5", newQty = "4", time = 4000)))
      }
      list(path = path, params = params, method = method)
    },
    .package = "binxr"
  )

  account_out <- spot_get_account(omit_zero_balances = TRUE, config = cfg)
  order_out <- spot_get_order(symbol = "BTCUSDT", order_id = 10, config = cfg)
  open_orders_out <- spot_get_open_orders(symbol = "BTCUSDT", config = cfg)
  trades_out <- spot_get_account_trades(symbol = "BTCUSDT", config = cfg)
  counts_out <- spot_get_unfilled_order_count(config = cfg)
  amendments_out <- spot_get_order_amendments(symbol = "BTCUSDT", order_id = 9, config = cfg)

  expect_identical(account_out$path, "/api/v3/account")
  expect_identical(account_out$params$omitZeroBalances, "true")
  expect_identical(order_out$path, "/api/v3/order")
  expect_identical(order_out$params$orderId, 10)

  expect_s3_class(open_orders_out, "data.table")
  expect_equal(open_orders_out$orderId, 1)
  expect_s3_class(open_orders_out$time, "POSIXct")

  expect_s3_class(trades_out, "data.table")
  expect_equal(trades_out$id, 2)
  expect_s3_class(trades_out$time, "POSIXct")

  expect_s3_class(counts_out, "data.table")
  expect_equal(counts_out$count, 1)

  expect_s3_class(amendments_out, "data.table")
  expect_equal(amendments_out$executionId, 22)
  expect_s3_class(amendments_out$time, "POSIXct")
})

test_that("spot account json_list flags return raw payloads", {
  cfg <- config_spot(api_key = "k", secret_key = "s")
  raw_payload <- list(list(orderId = "1"))

  local_mocked_bindings(
    .request_signed = function(config, path, params = NULL, method = c("GET", "POST", "PUT", "DELETE")) {
      raw_payload
    },
    .package = "binxr"
  )

  expect_identical(spot_get_open_orders(json_list = TRUE, config = cfg), raw_payload)
  expect_identical(spot_get_open_order_lists(json_list = TRUE, config = cfg), raw_payload)
  expect_identical(spot_get_unfilled_order_count(json_list = TRUE, config = cfg), raw_payload)
})
