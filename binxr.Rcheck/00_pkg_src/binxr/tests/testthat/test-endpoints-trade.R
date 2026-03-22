test_that("futures_place_order rejects silently ignored parameters", {
  cfg <- config_futures(api_key = "k", secret_key = "s")

  expect_error(
    futures_place_order(
      symbol = "BTCUSDT",
      side = "BUY",
      type = "MARKET",
      quantity = 1,
      time_in_force = "GTC",
      config = cfg
    ),
    "time_in_force"
  )

  expect_error(
    futures_place_order(
      symbol = "BTCUSDT",
      side = "BUY",
      type = "LIMIT",
      quantity = 1,
      price = 100,
      time_in_force = "GTC",
      working_type = "MARK_PRICE",
      config = cfg
    ),
    "working_type"
  )
})

test_that("deprecated market aliases warn and forward to canonical names", {
  local_mocked_bindings(
    .request_public = function(config, path, query = NULL) {
      switch(
        path,
        "/api/v3/ticker/price" = list(symbol = query$symbol, price = "100"),
        "/fapi/v1/time" = list(serverTime = 1000),
        list(path = path, query = query)
      )
    },
    .package = "binxr"
  )

  spot_out <- NULL
  futures_out <- NULL
  time_out <- NULL
  expect_warning(
    spot_out <- get_spot_mark_price("BTCUSDT"),
    "deprecated"
  )
  expect_warning(
    futures_out <- get_fapi_mark_price("ETHUSDT"),
    "deprecated"
  )
  expect_warning(
    time_out <- get_fapi_system_time(),
    "deprecated"
  )

  expect_identical(spot_out$symbol, "BTCUSDT")
  expect_identical(futures_out$query$symbol, "ETHUSDT")
  expect_s3_class(time_out, "POSIXct")
})

test_that("deprecated futures trade aliases warn and forward to canonical names", {
  cfg <- config_futures(api_key = "k", secret_key = "s")

  local_mocked_bindings(
    .request_signed = function(config, path, params = NULL, method = c("GET", "POST", "PUT", "DELETE")) {
      list(path = path, params = params, method = method)
    },
    .package = "binxr"
  )

  order_out <- NULL
  place_out <- NULL
  expect_warning(
    order_out <- get_fapi_trade_order("BTCUSDT", orderId = 1, config = cfg),
    "deprecated"
  )
  expect_warning(
    place_out <- place_fapi_trade_order(
      symbol = "BTCUSDT",
      side = "BUY",
      type = "LIMIT",
      quantity = 1,
      price = 100,
      timeInForce = "GTC",
      config = cfg
    ),
    "deprecated"
  )

  expect_identical(order_out$path, "/fapi/v1/order")
  expect_identical(order_out$params$orderId, 1)
  expect_identical(place_out$method, "POST")
  expect_identical(place_out$params$timeInForce, "GTC")
})
