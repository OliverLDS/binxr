#' Place a Binance Options order
#'
#' @param symbol Option symbol, for example `"BTC-200730-9000-C"`.
#' @param side One of `"BUY"` or `"SELL"`.
#' @param type Order type. Only `"LIMIT"` is currently supported.
#' @param quantity Order quantity.
#' @param price Order price.
#' @param time_in_force Time in force. Default is `"GTC"`.
#' @param reduce_only Whether the order is reduce-only.
#' @param post_only Whether the order is post-only.
#' @param new_order_resp_type Response type. One of `"ACK"` or `"RESULT"`.
#' @param client_order_id Optional client order ID.
#' @param is_mmp Whether the order is an MMP order.
#' @param self_trade_prevention_mode Optional STP mode.
#' @param config An options configuration created by [config_options()].
#'
#' @return A parsed list.
#' @export
options_place_order <- function(
    symbol,
    side = c("BUY", "SELL"),
    type = c("LIMIT"),
    quantity,
    price,
    time_in_force = c("GTC", "IOC", "FOK"),
    reduce_only = FALSE,
    post_only = FALSE,
    new_order_resp_type = c("ACK", "RESULT"),
    client_order_id = NULL,
    is_mmp = FALSE,
    self_trade_prevention_mode = NULL,
    config = config_options()) {
  .validate_symbol(symbol)
  side <- match.arg(side)
  type <- match.arg(type)
  time_in_force <- match.arg(time_in_force)
  new_order_resp_type <- match.arg(new_order_resp_type)
  .validate_positive_number(quantity, "quantity")
  .validate_positive_number(price, "price")
  .validate_scalar_logical(reduce_only, "reduce_only")
  .validate_scalar_logical(post_only, "post_only")
  .validate_optional_scalar_character(client_order_id, "client_order_id")
  .validate_scalar_logical(is_mmp, "is_mmp")
  .validate_optional_scalar_character(self_trade_prevention_mode, "self_trade_prevention_mode")

  if (!is.null(self_trade_prevention_mode)) {
    .validate_one_of(
      self_trade_prevention_mode,
      c("EXPIRE_TAKER", "EXPIRE_MAKER", "EXPIRE_BOTH"),
      "self_trade_prevention_mode"
    )
  }

  .request_signed(
    config,
    "/eapi/v1/order",
    params = list(
      symbol = symbol,
      side = side,
      type = type,
      quantity = quantity,
      price = price,
      timeInForce = time_in_force,
      reduceOnly = if (isTRUE(reduce_only)) "true" else "false",
      postOnly = if (isTRUE(post_only)) "true" else "false",
      newOrderRespType = new_order_resp_type,
      clientOrderId = client_order_id,
      isMmp = if (isTRUE(is_mmp)) "true" else "false",
      selfTradePreventionMode = self_trade_prevention_mode
    ),
    method = "POST"
  )
}

#' Get a Binance Options order
#'
#' @param symbol Option symbol, for example `"BTC-200730-9000-C"`.
#' @param order_id Optional exchange order ID.
#' @param client_order_id Optional client order ID.
#' @param config An options configuration created by [config_options()].
#'
#' @return A parsed list.
#' @export
options_get_order <- function(symbol, order_id = NULL, client_order_id = NULL, config = config_options()) {
  .validate_symbol(symbol)
  .validate_required_any(order_id, client_order_id, arg_names = c("order_id", "client_order_id"))
  .validate_optional_scalar_numeric(order_id, "order_id")
  .validate_optional_scalar_character(client_order_id, "client_order_id")

  .request_signed(
    config,
    "/eapi/v1/order",
    params = list(symbol = symbol, orderId = order_id, clientOrderId = client_order_id),
    method = "GET"
  )
}

#' Cancel a Binance Options order
#'
#' @param symbol Option symbol, for example `"BTC-200730-9000-C"`.
#' @param order_id Optional exchange order ID.
#' @param client_order_id Optional client order ID.
#' @param config An options configuration created by [config_options()].
#'
#' @return A parsed list.
#' @export
options_cancel_order <- function(symbol, order_id = NULL, client_order_id = NULL, config = config_options()) {
  .validate_symbol(symbol)
  .validate_required_any(order_id, client_order_id, arg_names = c("order_id", "client_order_id"))
  .validate_optional_scalar_numeric(order_id, "order_id")
  .validate_optional_scalar_character(client_order_id, "client_order_id")

  .request_signed(
    config,
    "/eapi/v1/order",
    params = list(symbol = symbol, orderId = order_id, clientOrderId = client_order_id),
    method = "DELETE"
  )
}

#' Cancel all Binance Options orders for a symbol
#'
#' @param symbol Option symbol, for example `"BTC-200730-9000-C"`.
#' @param config An options configuration created by [config_options()].
#'
#' @return A parsed list.
#' @export
options_cancel_all_orders <- function(symbol, config = config_options()) {
  .validate_symbol(symbol)
  .request_signed(config, "/eapi/v1/allOpenOrders", params = list(symbol = symbol), method = "DELETE")
}

#' Cancel all Binance Options orders by underlying
#'
#' @param underlying Underlying symbol, for example `"BTCUSDT"`.
#' @param config An options configuration created by [config_options()].
#'
#' @return A parsed list.
#' @export
options_cancel_all_orders_by_underlying <- function(underlying, config = config_options()) {
  .validate_symbol(underlying, "underlying")
  .request_signed(
    config,
    "/eapi/v1/allOpenOrdersByUnderlying",
    params = list(underlying = underlying),
    method = "DELETE"
  )
}

#' Get Binance Options open orders
#'
#' @param symbol Optional option symbol.
#' @param order_id Optional order ID to start from.
#' @param startTime Optional start time in milliseconds since Unix epoch.
#' @param endTime Optional end time in milliseconds since Unix epoch.
#' @param json_list If `TRUE`, return the parsed list instead of a `data.table`.
#' @param config An options configuration created by [config_options()].
#'
#' @return A `data.table` by default, or a parsed list when `json_list = TRUE`.
#' @export
options_get_open_orders <- function(
    symbol = NULL,
    order_id = NULL,
    startTime = NULL,
    endTime = NULL,
    json_list = FALSE,
    config = config_options()) {
  if (!is.null(symbol)) {
    .validate_symbol(symbol)
  }
  .validate_optional_scalar_numeric(order_id, "order_id")
  .validate_optional_scalar_numeric(startTime, "startTime")
  .validate_optional_scalar_numeric(endTime, "endTime")
  .validate_json_list_flag(json_list)

  payload <- .request_signed(
    config,
    "/eapi/v1/openOrders",
    params = list(symbol = symbol, orderId = order_id, startTime = startTime, endTime = endTime),
    method = "GET"
  )
  if (isTRUE(json_list)) {
    return(payload)
  }

  .options_as_orders_dt(payload)
}

#' Get Binance Options order history
#'
#' @param symbol Option symbol, for example `"BTC-200730-9000-C"`.
#' @param order_id Optional order ID to start from.
#' @param startTime Optional start time in milliseconds since Unix epoch.
#' @param endTime Optional end time in milliseconds since Unix epoch.
#' @param limit Maximum number of rows to return. Must not exceed `1000`.
#' @param json_list If `TRUE`, return the parsed list instead of a `data.table`.
#' @param config An options configuration created by [config_options()].
#'
#' @return A `data.table` by default, or a parsed list when `json_list = TRUE`.
#' @export
options_get_order_history <- function(
    symbol,
    order_id = NULL,
    startTime = NULL,
    endTime = NULL,
    limit = 100,
    json_list = FALSE,
    config = config_options()) {
  .validate_symbol(symbol)
  .validate_optional_scalar_numeric(order_id, "order_id")
  .validate_optional_scalar_numeric(startTime, "startTime")
  .validate_optional_scalar_numeric(endTime, "endTime")
  .options_validate_limit(limit, max = 1000)
  .validate_json_list_flag(json_list)

  payload <- .request_signed(
    config,
    "/eapi/v1/historyOrders",
    params = list(symbol = symbol, orderId = order_id, startTime = startTime, endTime = endTime, limit = limit),
    method = "GET"
  )
  if (isTRUE(json_list)) {
    return(payload)
  }

  .options_as_orders_dt(payload)
}

#' Get Binance Options account trades
#'
#' @param symbol Optional option symbol.
#' @param fromId Optional trade ID to start from.
#' @param startTime Optional start time in milliseconds since Unix epoch.
#' @param endTime Optional end time in milliseconds since Unix epoch.
#' @param limit Maximum number of rows to return. Must not exceed `1000`.
#' @param json_list If `TRUE`, return the parsed list instead of a `data.table`.
#' @param config An options configuration created by [config_options()].
#'
#' @return A `data.table` by default, or a parsed list when `json_list = TRUE`.
#' @export
options_get_account_trades <- function(
    symbol = NULL,
    fromId = NULL,
    startTime = NULL,
    endTime = NULL,
    limit = 100,
    json_list = FALSE,
    config = config_options()) {
  if (!is.null(symbol)) {
    .validate_symbol(symbol)
  }
  .validate_optional_scalar_numeric(fromId, "fromId")
  .validate_optional_scalar_numeric(startTime, "startTime")
  .validate_optional_scalar_numeric(endTime, "endTime")
  .options_validate_limit(limit, max = 1000)
  .validate_json_list_flag(json_list)

  payload <- .request_signed(
    config,
    "/eapi/v1/userTrades",
    params = list(symbol = symbol, fromId = fromId, startTime = startTime, endTime = endTime, limit = limit),
    method = "GET"
  )
  if (isTRUE(json_list)) {
    return(payload)
  }

  trades_dt <- .maybe_as_dt(payload)
  trades_dt <- .coerce_numeric_cols(
    trades_dt,
    c("id", "tradeId", "orderId", "price", "quantity", "fee", "realizedProfit")
  )
  .normalize_time_cols(trades_dt, "time")
}

#' Get Binance Options positions
#'
#' @param symbol Optional option symbol.
#' @param json_list If `TRUE`, return the parsed list instead of a `data.table`.
#' @param config An options configuration created by [config_options()].
#'
#' @return A `data.table` by default, or a parsed list when `json_list = TRUE`.
#' @export
options_get_positions <- function(symbol = NULL, json_list = FALSE, config = config_options()) {
  if (!is.null(symbol)) {
    .validate_symbol(symbol)
  }
  .validate_json_list_flag(json_list)

  payload <- .request_signed(config, "/eapi/v1/position", params = list(symbol = symbol), method = "GET")
  if (isTRUE(json_list)) {
    return(payload)
  }

  pos_dt <- .maybe_as_dt(payload)
  pos_dt <- .coerce_numeric_cols(
    pos_dt,
    c("entryPrice", "quantity", "markValue", "unrealizedPNL", "markPrice", "strikePrice", "bidQuantity", "askQuantity")
  )
  .normalize_time_cols(pos_dt, c("expiryDate", "time"))
}

#' Get Binance Options user commission
#'
#' @param config An options configuration created by [config_options()].
#'
#' @return A parsed list.
#' @export
options_get_commission <- function(config = config_options()) {
  .request_signed(config, "/eapi/v1/commission", params = list(), method = "GET")
}

#' Get Binance Options exercise records
#'
#' @param symbol Optional option symbol.
#' @param startTime Optional start time in milliseconds since Unix epoch.
#' @param endTime Optional end time in milliseconds since Unix epoch.
#' @param limit Maximum number of rows to return. Must not exceed `1000`.
#' @param json_list If `TRUE`, return the parsed list instead of a `data.table`.
#' @param config An options configuration created by [config_options()].
#'
#' @return A `data.table` by default, or a parsed list when `json_list = TRUE`.
#' @export
options_get_exercise_records <- function(
    symbol = NULL,
    startTime = NULL,
    endTime = NULL,
    limit = 1000,
    json_list = FALSE,
    config = config_options()) {
  if (!is.null(symbol)) {
    .validate_symbol(symbol)
  }
  .validate_optional_scalar_numeric(startTime, "startTime")
  .validate_optional_scalar_numeric(endTime, "endTime")
  .options_validate_limit(limit, max = 1000)
  .validate_json_list_flag(json_list)

  payload <- .request_signed(
    config,
    "/eapi/v1/exerciseRecord",
    params = list(symbol = symbol, startTime = startTime, endTime = endTime, limit = limit),
    method = "GET"
  )
  if (isTRUE(json_list)) {
    return(payload)
  }

  exercise_dt <- .maybe_as_dt(payload)
  exercise_dt <- .coerce_numeric_cols(exercise_dt, c("id", "exercisePrice", "quantity", "amount", "fee"))
  .normalize_time_cols(exercise_dt, "createDate")
}

#' @noRd
.options_as_orders_dt <- function(payload) {
  orders_dt <- .maybe_as_dt(payload)
  orders_dt <- .coerce_numeric_cols(
    orders_dt,
    c("orderId", "price", "quantity", "executedQty", "avgPrice")
  )
  .normalize_time_cols(orders_dt, c("createTime", "updateTime"))
}
