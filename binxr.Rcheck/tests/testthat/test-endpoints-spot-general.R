test_that("spot exchange info validates symbol_status exclusivity", {
  expect_error(
    spot_get_exchange_info(symbol = "BTCUSDT", symbol_status = "TRADING"),
    "cannot be used with `symbol` or `symbols`"
  )
})

test_that("spot execution rules allows only one selector", {
  expect_error(
    spot_get_execution_rules(symbol = "BTCUSDT", symbol_status = "TRADING"),
    "Only one of symbol, symbols, symbol_status may be supplied"
  )
})

test_that("spot exchange info shapes array parameters as JSON strings", {
  local_mocked_bindings(
    .request_public = function(config, path, query = NULL) {
      query
    },
    .package = "binxr"
  )

  out <- spot_get_exchange_info(
    symbols = c("BTCUSDT", "ETHUSDT"),
    permissions = c("SPOT", "MARGIN"),
    show_permission_sets = FALSE
  )

  expect_identical(as.character(out$symbols), "[\"BTCUSDT\",\"ETHUSDT\"]")
  expect_identical(as.character(out$permissions), "[\"SPOT\",\"MARGIN\"]")
  expect_identical(out$showPermissionSets, "false")
})

test_that("spot ping uses public request helper", {
  local_mocked_bindings(
    .request_public = function(config, path, query = NULL) {
      list(path = path)
    },
    .package = "binxr"
  )

  out <- spot_ping()

  expect_identical(out$path, "/api/v3/ping")
})
