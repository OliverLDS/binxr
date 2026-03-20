test_that("spot place order validates market quantity selectors", {
  cfg <- config_spot(api_key = "k", secret_key = "s")

  expect_error(
    spot_place_order(
      symbol = "BTCUSDT",
      side = "BUY",
      type = "MARKET",
      config = cfg
    ),
    "Provide at least one of: quantity, quote_order_qty"
  )

  expect_error(
    spot_place_order(
      symbol = "BTCUSDT",
      side = "BUY",
      type = "MARKET",
      quantity = 1,
      quote_order_qty = 100,
      config = cfg
    ),
    "Only one of quantity, quote_order_qty may be supplied"
  )

  expect_error(
    spot_place_order(
      symbol = "BTCUSDT",
      side = "BUY",
      type = "MARKET",
      quantity = 1,
      time_in_force = "GTC",
      config = cfg
    ),
    "time_in_force"
  )
})

test_that("spot place order validates conditional limit and stop order fields", {
  cfg <- config_spot(api_key = "k", secret_key = "s")

  expect_error(
    spot_place_order(
      symbol = "BTCUSDT",
      side = "BUY",
      type = "LIMIT",
      quantity = 1,
      price = 100,
      config = cfg
    ),
    "time_in_force"
  )

  expect_error(
    spot_place_order(
      symbol = "BTCUSDT",
      side = "SELL",
      type = "STOP_LOSS",
      quantity = 1,
      config = cfg
    ),
    "Provide at least one of: stop_price, trailing_delta"
  )

  expect_error(
    spot_place_order(
      symbol = "BTCUSDT",
      side = "SELL",
      type = "LIMIT_MAKER",
      quantity = 1,
      price = 100,
      stop_price = 90,
      config = cfg
    ),
    "stop_price"
  )
})

test_that("spot place order validates iceberg and pegged order constraints", {
  cfg <- config_spot(api_key = "k", secret_key = "s")

  expect_error(
    spot_place_order(
      symbol = "BTCUSDT",
      side = "BUY",
      type = "LIMIT",
      quantity = 1,
      price = 100,
      time_in_force = "IOC",
      iceberg_qty = 0.1,
      config = cfg
    ),
    "iceberg_qty"
  )

  expect_error(
    spot_place_order(
      symbol = "BTCUSDT",
      side = "BUY",
      type = "MARKET",
      quantity = 1,
      peg_price_type = "PRIMARY_PEG",
      config = cfg
    ),
    "peg_price_type"
  )

  expect_error(
    spot_place_order(
      symbol = "BTCUSDT",
      side = "BUY",
      type = "LIMIT",
      quantity = 1,
      time_in_force = "GTC",
      peg_price_type = "PRIMARY_PEG",
      peg_offset_value = 2,
      config = cfg
    ),
    "peg_offset_type"
  )
})

test_that("spot place order forwards signed params for valid requests", {
  local_mocked_bindings(
    .request_signed = function(config, path, params = NULL, method = c("GET", "POST", "DELETE")) {
      list(path = path, params = params, method = method)
    },
    .package = "binxr"
  )

  out <- spot_place_order(
    symbol = "BTCUSDT",
    side = "BUY",
    type = "LIMIT",
    quantity = 1,
    price = 100,
    time_in_force = "GTC",
    iceberg_qty = 0.2,
    new_order_resp_type = "FULL",
    config = config_spot(api_key = "k", secret_key = "s")
  )

  expect_identical(out$path, "/api/v3/order")
  expect_identical(out$method, "POST")
  expect_identical(out$params$symbol, "BTCUSDT")
  expect_identical(out$params$timeInForce, "GTC")
  expect_identical(out$params$icebergQty, 0.2)
  expect_identical(out$params$newOrderRespType, "FULL")
})

test_that("spot test order includes computeCommissionRates", {
  local_mocked_bindings(
    .request_signed = function(config, path, params = NULL, method = c("GET", "POST", "DELETE")) {
      list(path = path, params = params, method = method)
    },
    .package = "binxr"
  )

  out <- spot_test_order(
    symbol = "BTCUSDT",
    side = "BUY",
    type = "MARKET",
    quantity = 1,
    compute_commission_rates = TRUE,
    config = config_spot(api_key = "k", secret_key = "s")
  )

  expect_identical(out$path, "/api/v3/order/test")
  expect_identical(out$params$computeCommissionRates, "true")
})

test_that("spot cancel order validates selectors and restrictions", {
  cfg <- config_spot(api_key = "k", secret_key = "s")

  expect_error(
    spot_cancel_order(symbol = "BTCUSDT", config = cfg),
    "Provide at least one of: order_id, orig_client_order_id"
  )

  expect_error(
    spot_cancel_order(
      symbol = "BTCUSDT",
      order_id = 1,
      cancel_restrictions = "INVALID",
      config = cfg
    ),
    "cancel_restrictions"
  )
})

test_that("spot cancel order and cancel all orders call signed endpoints", {
  local_mocked_bindings(
    .request_signed = function(config, path, params = NULL, method = c("GET", "POST", "DELETE")) {
      list(path = path, params = params, method = method)
    },
    .package = "binxr"
  )

  cancel_out <- spot_cancel_order(
    symbol = "BTCUSDT",
    order_id = 10,
    new_client_order_id = "cancel-1",
    cancel_restrictions = "ONLY_NEW",
    config = config_spot(api_key = "k", secret_key = "s")
  )
  cancel_all_out <- spot_cancel_all_orders(
    symbol = "BTCUSDT",
    config = config_spot(api_key = "k", secret_key = "s")
  )

  expect_identical(cancel_out$path, "/api/v3/order")
  expect_identical(cancel_out$method, "DELETE")
  expect_identical(cancel_out$params$orderId, 10)
  expect_identical(cancel_out$params$cancelRestrictions, "ONLY_NEW")

  expect_identical(cancel_all_out$path, "/api/v3/openOrders")
  expect_identical(cancel_all_out$method, "DELETE")
  expect_identical(cancel_all_out$params$symbol, "BTCUSDT")
})

test_that("spot cancel-replace validates cancel selectors and forwards params", {
  cfg <- config_spot(api_key = "k", secret_key = "s")

  expect_error(
    spot_cancel_replace_order(
      symbol = "BTCUSDT",
      side = "BUY",
      type = "MARKET",
      cancel_replace_mode = "STOP_ON_FAILURE",
      quantity = 1,
      config = cfg
    ),
    "Provide at least one of: cancel_order_id, cancel_orig_client_order_id"
  )

  local_mocked_bindings(
    .request_signed = function(config, path, params = NULL, method = c("GET", "POST", "PUT", "DELETE")) {
      list(path = path, params = params, method = method)
    },
    .package = "binxr"
  )

  out <- spot_cancel_replace_order(
    symbol = "BTCUSDT",
    side = "BUY",
    type = "LIMIT",
    cancel_replace_mode = "ALLOW_FAILURE",
    cancel_order_id = 123,
    quantity = 1,
    price = 100,
    time_in_force = "GTC",
    order_rate_limit_exceeded_mode = "CANCEL_ONLY",
    config = cfg
  )

  expect_identical(out$path, "/api/v3/order/cancelReplace")
  expect_identical(out$method, "POST")
  expect_identical(out$params$cancelOrderId, 123)
  expect_identical(out$params$cancelReplaceMode, "ALLOW_FAILURE")
  expect_identical(out$params$orderRateLimitExceededMode, "CANCEL_ONLY")
})

test_that("spot amend keep priority validates selectors and uses PUT", {
  cfg <- config_spot(api_key = "k", secret_key = "s")

  expect_error(
    spot_amend_order_keep_priority(
      symbol = "BTCUSDT",
      new_qty = 1,
      config = cfg
    ),
    "Provide at least one of: order_id, orig_client_order_id"
  )

  local_mocked_bindings(
    .request_signed = function(config, path, params = NULL, method = c("GET", "POST", "PUT", "DELETE")) {
      list(path = path, params = params, method = method)
    },
    .package = "binxr"
  )

  out <- spot_amend_order_keep_priority(
    symbol = "BTCUSDT",
    order_id = 10,
    new_client_order_id = "amended-1",
    new_qty = 0.5,
    config = cfg
  )

  expect_identical(out$path, "/api/v3/order/amend/keepPriority")
  expect_identical(out$method, "PUT")
  expect_identical(out$params$newQty, 0.5)
})

test_that("spot order list oco validates conditional fields", {
  cfg <- config_spot(api_key = "k", secret_key = "s")

  expect_error(
    spot_place_order_list_oco(
      symbol = "BTCUSDT",
      side = "SELL",
      quantity = 1,
      above_type = "STOP_LOSS_LIMIT",
      below_type = "STOP_LOSS",
      below_stop_price = 90,
      config = cfg
    ),
    "above_price"
  )

  local_mocked_bindings(
    .request_signed = function(config, path, params = NULL, method = c("GET", "POST", "PUT", "DELETE")) {
      list(path = path, params = params, method = method)
    },
    .package = "binxr"
  )

  out <- spot_place_order_list_oco(
    symbol = "BTCUSDT",
    side = "SELL",
    quantity = 1,
    above_type = "TAKE_PROFIT_LIMIT",
    above_price = 110,
    above_stop_price = 108,
    above_time_in_force = "GTC",
    below_type = "STOP_LOSS_LIMIT",
    below_price = 90,
    below_stop_price = 92,
    below_time_in_force = "GTC",
    config = cfg
  )

  expect_identical(out$path, "/api/v3/orderList/oco")
  expect_identical(out$params$aboveType, "TAKE_PROFIT_LIMIT")
  expect_identical(out$params$belowType, "STOP_LOSS_LIMIT")
})

test_that("spot order list oto validates working and pending requirements", {
  cfg <- config_spot(api_key = "k", secret_key = "s")

  expect_error(
    spot_place_order_list_oto(
      symbol = "BTCUSDT",
      working_type = "LIMIT",
      working_side = "BUY",
      working_price = 100,
      working_quantity = 1,
      pending_type = "LIMIT",
      pending_side = "SELL",
      pending_quantity = 1,
      config = cfg
    ),
    "working_time_in_force"
  )

  local_mocked_bindings(
    .request_signed = function(config, path, params = NULL, method = c("GET", "POST", "PUT", "DELETE")) {
      list(path = path, params = params, method = method)
    },
    .package = "binxr"
  )

  out <- spot_place_order_list_oto(
    symbol = "BTCUSDT",
    working_type = "LIMIT",
    working_side = "BUY",
    working_price = 100,
    working_quantity = 1,
    working_time_in_force = "GTC",
    pending_type = "STOP_LOSS_LIMIT",
    pending_side = "SELL",
    pending_price = 90,
    pending_stop_price = 92,
    pending_quantity = 1,
    pending_time_in_force = "GTC",
    config = cfg
  )

  expect_identical(out$path, "/api/v3/orderList/oto")
  expect_identical(out$params$workingType, "LIMIT")
  expect_identical(out$params$pendingType, "STOP_LOSS_LIMIT")
})

test_that("spot order list otoco and cancel order list call signed endpoints", {
  cfg <- config_spot(api_key = "k", secret_key = "s")

  local_mocked_bindings(
    .request_signed = function(config, path, params = NULL, method = c("GET", "POST", "PUT", "DELETE")) {
      list(path = path, params = params, method = method)
    },
    .package = "binxr"
  )

  otoco_out <- spot_place_order_list_otoco(
    symbol = "BTCUSDT",
    working_type = "LIMIT",
    working_side = "BUY",
    working_price = 100,
    working_quantity = 1,
    working_time_in_force = "GTC",
    pending_side = "SELL",
    pending_quantity = 1,
    pending_above_type = "TAKE_PROFIT_LIMIT",
    pending_above_price = 110,
    pending_above_stop_price = 108,
    pending_above_time_in_force = "GTC",
    pending_below_type = "STOP_LOSS_LIMIT",
    pending_below_price = 90,
    pending_below_stop_price = 92,
    pending_below_time_in_force = "GTC",
    config = cfg
  )
  cancel_out <- spot_cancel_order_list(
    symbol = "BTCUSDT",
    order_list_id = 99,
    config = cfg
  )

  expect_identical(otoco_out$path, "/api/v3/orderList/otoco")
  expect_identical(otoco_out$params$pendingAboveType, "TAKE_PROFIT_LIMIT")
  expect_identical(cancel_out$path, "/api/v3/orderList")
  expect_identical(cancel_out$method, "DELETE")
  expect_identical(cancel_out$params$orderListId, 99)
})
