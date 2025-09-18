#' Set margin type (Futures)
#'
#' @param symbol character Trading pair symbol, e.g., "ETHUSDT".
#' @param marginType character One of "CROSSED" or "ISOLATED".
#' @param config list binxr futures configuration.
#' @return list Parsed JSON response.
#' @export
set_fapi_account_margin_type <- function(
    symbol, marginType = c("CROSSED", "ISOLATED"),
    config = binxr_config_futures()) {
  marginType <- match.arg(marginType)
  .signed_req(config, "/fapi/v1/marginType", list(symbol = symbol, marginType = marginType), method = "POST")
}

#' Set leverage (Futures)
#'
#' @param symbol character Trading pair symbol, e.g., "ETHUSDT".
#' @param leverage integer Desired leverage.
#' @param config list binxr futures configuration.
#' @return list Parsed JSON response.
#' @export
set_fapi_account_leverage <- function(symbol, leverage, config = binxr_config_futures()) {
  .signed_req(config, "/fapi/v1/leverage", list(symbol = symbol, leverage = leverage), method = "POST")
}

#' Set position mode (dual-side) (Futures)
#'
#' @param dualSidePosition logical TRUE for dual-side, FALSE for one-way.
#' @param config list binxr futures configuration.
#' @return list Parsed JSON response.
#' @export
set_fapi_account_position_side <- function(dualSidePosition = TRUE, config = binxr_config_futures()) {
  val <- if (dualSidePosition) "true" else "false"
  .signed_req(config, "/fapi/v1/positionSide", list(dualSidePosition = val), method = "POST")
}

#' Place futures trade order
#'
#' @param symbol character Trading pair symbol, e.g., "ETHUSDT".
#' @param side character "BUY" or "SELL".
#' @param type character Order type, e.g., "LIMIT", "MARKET", "STOP", etc.
#' @param quantity numeric Order quantity.
#' @param price numeric|NULL Limit price for limit orders.
#' @param timeInForce character One of "GTC","IOC","FOK","GTX" (for limit).
#' @param positionSide character "BOTH","LONG","SHORT".
#' @param reduceOnly logical Whether the order is reduce-only.
#' @param stopPrice numeric|NULL Stop/trigger price for conditional orders.
#' @param workingType character "CONTRACT_PRICE" or "MARK_PRICE".
#' @param newClientOrderId character|NULL Optional client order ID.
#' @param config list binxr futures configuration.
#' @return list Parsed JSON response.
#' @export
place_fapi_trade_order <- function(
    symbol,
    side = c("BUY", "SELL"),
    type = c(
      "LIMIT", "MARKET", "STOP", "STOP_MARKET",
      "TAKE_PROFIT", "TAKE_PROFIT_MARKET", "TRAILING_STOP_MARKET"
    ),
    quantity,
    price = NULL,
    timeInForce = c("GTC", "IOC", "FOK", "GTX"),
    positionSide = c("BOTH", "LONG", "SHORT"),
    reduceOnly = FALSE,
    stopPrice = NULL,
    workingType = c("CONTRACT_PRICE", "MARK_PRICE"),
    newClientOrderId = NULL,
    config = binxr_config_futures()) {
  side <- match.arg(side)
  type <- match.arg(type)
  timeInForce <- match.arg(timeInForce)
  positionSide <- match.arg(positionSide)
  workingType <- match.arg(workingType)


  kv <- list(
    symbol = symbol,
    side = side,
    type = type,
    quantity = quantity,
    price = price,
    timeInForce = if (type == "LIMIT") timeInForce else NULL,
    positionSide = positionSide,
    reduceOnly = if (isTRUE(reduceOnly)) "true" else NULL,
    stopPrice = stopPrice,
    workingType = if (!is.null(stopPrice)) workingType else NULL,
    newClientOrderId = newClientOrderId
  )
  .signed_req(config, "/fapi/v1/order", kv, method = "POST")
}

#' Cancel a futures order
#'
#' @param symbol character Trading pair symbol, e.g., "ETHUSDT".
#' @param orderId numeric|NULL Exchange order ID.
#' @param origClientOrderId character|NULL Client order ID.
#' @param config list binxr futures configuration.
#' @return list Parsed JSON response.
#' @export
cancel_fapi_trade_order <- function(symbol, orderId = NULL, origClientOrderId = NULL, config = binxr_config_futures()) {
  if (is.null(orderId) && is.null(origClientOrderId)) stop("Provide orderId or origClientOrderId")
  kv <- list(symbol = symbol, orderId = orderId, origClientOrderId = origClientOrderId)
  .signed_req(config, "/fapi/v1/order", kv, method = "DELETE")
}


#' Cancel all open futures orders for a symbol
#'
#' @param symbol character Trading pair symbol, e.g., "ETHUSDT".
#' @param config list binxr futures configuration.
#' @return list Parsed JSON response.
#' @export
cancel_fapi_trade_orders_all <- function(symbol, config = binxr_config_futures()) {
  .signed_req(config, "/fapi/v1/allOpenOrders", list(symbol = symbol), method = "DELETE")
}


#' Get open orders (Futures)
#'
#' @param symbol character|NULL Trading pair symbol; NULL for all.
#' @param config list binxr futures configuration.
#' @return data.table Open orders with `time_human` and `updateTime_human` columns.
#' @export
get_fapi_trade_open_orders <- function(symbol = NULL, config = binxr_config_futures()) {
  kv <- list(symbol = symbol)
  orders_dt <- data.table::rbindlist(.signed_req(config, "/fapi/v1/openOrders", kv, method = "GET"))
  data.table::set(orders_dt, j = 'time_human', value = as.POSIXct(orders_dt$time/1000, origin = "1970-01-01", tz = Sys.timezone()))
  data.table::set(orders_dt, j = 'updateTime_human', value = as.POSIXct(orders_dt$updateTime/1000, origin = "1970-01-01", tz = Sys.timezone()))
  invisible(orders_dt)
}

#' Get all futures orders
#'
#' Retrieve all (filled, cancelled, or open) futures orders for a symbol.
#'
#' @param symbol character Trading pair symbol, e.g., "ETHUSDT".
#' @param limit integer Maximum number of orders to return (default 500).
#' @param config list binxr futures configuration.
#' @return data.table All orders with `time_human` and `updateTime_human` columns; returned invisibly.
#' @export
get_fapi_trade_orders <- function(symbol, limit = 500, config = binxr_config_futures()) {
  kv <- list(symbol = symbol, limit = limit)
  orders_dt <- data.table::rbindlist(.signed_req(config, "/fapi/v1/allOrders", kv, method = "GET"))
  data.table::set(orders_dt, j = 'time_human', value = as.POSIXct(orders_dt$time/1000, origin = "1970-01-01", tz = Sys.timezone()))
  data.table::set(orders_dt, j = 'updateTime_human', value = as.POSIXct(orders_dt$updateTime/1000, origin = "1970-01-01", tz = Sys.timezone()))
  invisible(orders_dt)
}

#' Get a futures order
#'
#' @param symbol character Trading pair symbol, e.g., "ETHUSDT".
#' @param orderId numeric|NULL Exchange order ID.
#' @param origClientOrderId character|NULL Client order ID.
#' @param config list binxr futures configuration.
#' @return list Parsed JSON response.
#' @export
get_fapi_trade_order <- function(symbol, orderId = NULL, origClientOrderId = NULL, config = binxr_config_futures()) {
  kv <- list(symbol = symbol, orderId = orderId, origClientOrderId = origClientOrderId)
  .signed_req(config, "/fapi/v1/order", kv, method = "GET")
}
