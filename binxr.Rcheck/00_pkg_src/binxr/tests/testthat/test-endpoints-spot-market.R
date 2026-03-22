test_that("spot ticker price rejects symbol and symbols together", {
  expect_error(
    spot_get_ticker_price(symbol = "BTCUSDT", symbols = c("ETHUSDT")),
    "Only one of symbol, symbols may be supplied"
  )
})

test_that("spot ticker price converts multi-symbol responses to data.table", {
  local_mocked_bindings(
    .request_public = function(config, path, query = NULL) {
      list(
        list(symbol = "BTCUSDT", price = "100"),
        list(symbol = "ETHUSDT", price = "200")
      )
    },
    .package = "binxr"
  )

  out <- spot_get_ticker_price(symbols = c("BTCUSDT", "ETHUSDT"))

  expect_s3_class(out, "data.table")
  expect_equal(nrow(out), 2L)
})

test_that("spot klines default to data.table and support json_list", {
  payload <- list(
    list(1, "1", "2", "0.5", "1.5", "10", 2, "20", 3, "4", "5", "0")
  )

  local_mocked_bindings(
    .request_public = function(config, path, query = NULL) payload,
    .package = "binxr"
  )

  dt_out <- spot_get_klines("BTCUSDT", "1m")
  list_out <- spot_get_klines("BTCUSDT", "1m", json_list = TRUE)

  expect_s3_class(dt_out, "data.table")
  expect_true("datetime" %in% names(dt_out))
  expect_identical(list_out, payload)
})

test_that("spot order book passes symbolStatus through explicitly", {
  local_mocked_bindings(
    .request_public = function(config, path, query = NULL) query,
    .package = "binxr"
  )

  out <- spot_get_order_book("BTCUSDT", limit = 100, symbol_status = "TRADING")

  expect_identical(out$symbol, "BTCUSDT")
  expect_identical(out$limit, 100)
  expect_identical(out$symbolStatus, "TRADING")
})

test_that("spot 24hr ticker includes type and supports tabular array responses", {
  local_mocked_bindings(
    .request_public = function(config, path, query = NULL) {
      if (is.null(query$symbol)) {
        return(list(
          list(symbol = "BTCUSDT", lastPrice = "100"),
          list(symbol = "ETHUSDT", lastPrice = "200")
        ))
      }
      list(symbol = query$symbol, lastPrice = "100")
    },
    .package = "binxr"
  )

  dt_out <- spot_get_24hr_ticker(symbols = c("BTCUSDT", "ETHUSDT"), type = "MINI")
  list_out <- spot_get_24hr_ticker(symbol = "BTCUSDT", type = "FULL")

  expect_s3_class(dt_out, "data.table")
  expect_equal(nrow(dt_out), 2L)
  expect_type(list_out, "list")
  expect_identical(list_out$symbol, "BTCUSDT")
})

test_that("spot recent and historical trades default to data.table and support json_list", {
  payload <- list(
    list(
      id = 1,
      price = "100",
      qty = "2",
      quoteQty = "200",
      time = 1700000000000,
      isBuyerMaker = TRUE,
      isBestMatch = TRUE
    )
  )

  local_mocked_bindings(
    .request_public = function(config, path, query = NULL) payload,
    .package = "binxr"
  )

  recent_dt <- spot_get_recent_trades("BTCUSDT")
  historical_list <- spot_get_historical_trades("BTCUSDT", fromId = 10, json_list = TRUE)

  expect_s3_class(recent_dt, "data.table")
  expect_identical(historical_list, payload)
})

test_that("spot aggregate trades pass selector parameters through and default to data.table", {
  local_mocked_bindings(
    .request_public = function(config, path, query = NULL) {
      if (!is.null(query$fromId)) {
        return(query)
      }
      list(list(a = 1, p = "1", q = "2", f = 1, l = 2, T = 3, m = TRUE, M = TRUE))
    },
    .package = "binxr"
  )

  query_out <- spot_get_aggregate_trades(
    "BTCUSDT",
    fromId = 5,
    startTime = 10,
    endTime = 20,
    limit = 50,
    json_list = TRUE
  )
  dt_out <- spot_get_aggregate_trades("BTCUSDT")

  expect_identical(query_out$symbol, "BTCUSDT")
  expect_identical(query_out$fromId, 5)
  expect_identical(query_out$startTime, 10)
  expect_identical(query_out$endTime, 20)
  expect_identical(query_out$limit, 50)
  expect_s3_class(dt_out, "data.table")
})

test_that("spot trading day ticker requires a selector and supports tabular responses", {
  expect_error(
    spot_get_trading_day_ticker(),
    "Provide at least one of: symbol, symbols"
  )

  local_mocked_bindings(
    .request_public = function(config, path, query = NULL) {
      if (!is.null(query$symbols)) {
        return(list(
          list(symbol = "BTCUSDT", lastPrice = "100"),
          list(symbol = "ETHUSDT", lastPrice = "200")
        ))
      }
      query
    },
    .package = "binxr"
  )

  dt_out <- spot_get_trading_day_ticker(
    symbols = c("BTCUSDT", "ETHUSDT"),
    timeZone = "8",
    type = "MINI",
    symbol_status = "TRADING"
  )
  query_out <- spot_get_trading_day_ticker(symbol = "BTCUSDT", timeZone = "0", json_list = TRUE)

  expect_s3_class(dt_out, "data.table")
  expect_identical(query_out$symbol, "BTCUSDT")
  expect_identical(query_out$timeZone, "0")
  expect_identical(query_out$type, "FULL")
})

test_that("spot rolling window ticker validates windowSize and requires a selector", {
  expect_error(
    spot_get_rolling_window_ticker(),
    "Provide at least one of: symbol, symbols"
  )
  expect_error(
    spot_get_rolling_window_ticker(symbol = "BTCUSDT", windowSize = "1d2h"),
    "must be one of 1m-59m, 1h-23h, or 1d-7d"
  )

  local_mocked_bindings(
    .request_public = function(config, path, query = NULL) query,
    .package = "binxr"
  )

  out <- spot_get_rolling_window_ticker(
    symbol = "BTCUSDT",
    windowSize = "4h",
    type = "MINI",
    symbol_status = "BREAK",
    json_list = TRUE
  )

  expect_identical(out$symbol, "BTCUSDT")
  expect_identical(out$windowSize, "4h")
  expect_identical(out$type, "MINI")
  expect_identical(out$symbolStatus, "BREAK")
})

test_that("spot reference price endpoints pass required parameters through", {
  local_mocked_bindings(
    .request_public = function(config, path, query = NULL) list(path = path, query = query),
    .package = "binxr"
  )

  ref_out <- spot_get_reference_price("BTCUSDT")
  calc_out <- spot_get_reference_price_calculation("BTCUSDT", symbol_status = "HALT")

  expect_identical(ref_out$path, "/api/v3/referencePrice")
  expect_identical(ref_out$query$symbol, "BTCUSDT")
  expect_identical(calc_out$path, "/api/v3/referencePrice/calculation")
  expect_identical(calc_out$query$symbolStatus, "HALT")
})
