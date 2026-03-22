#' Set Binance Futures margin type
#'
#' @param symbol Trading pair symbol, for example `"ETHUSDT"`.
#' @param margin_type One of `"CROSSED"` or `"ISOLATED"`.
#' @param config A futures configuration created by [config_futures()].
#'
#' @return A parsed list.
#' @export
futures_set_margin_type <- function(
    symbol,
    margin_type = c("CROSSED", "ISOLATED"),
    config = config_futures()) {
  .validate_symbol(symbol)
  margin_type <- match.arg(margin_type)
  .request_signed(
    config,
    "/fapi/v1/marginType",
    params = list(symbol = symbol, marginType = margin_type),
    method = "POST"
  )
}

#' @rdname futures_set_margin_type
#' @param marginType Legacy alias for `margin_type`.
#' @export
set_fapi_account_margin_type <- function(
    symbol,
    marginType = c("CROSSED", "ISOLATED"),
    config = binxr_config_futures()) {
  .binxr_deprecate_alias("set_fapi_account_margin_type", "futures_set_margin_type")
  futures_set_margin_type(symbol = symbol, margin_type = match.arg(marginType), config = config)
}

#' Set Binance Futures leverage
#'
#' @param symbol Trading pair symbol, for example `"ETHUSDT"`.
#' @param leverage Desired leverage.
#' @param config A futures configuration created by [config_futures()].
#'
#' @return A parsed list.
#' @export
futures_set_leverage <- function(symbol, leverage, config = config_futures()) {
  .validate_symbol(symbol)
  .validate_positive_integerish(leverage, "leverage")
  .request_signed(
    config,
    "/fapi/v1/leverage",
    params = list(symbol = symbol, leverage = leverage),
    method = "POST"
  )
}

#' @rdname futures_set_leverage
#' @export
set_fapi_account_leverage <- function(symbol, leverage, config = binxr_config_futures()) {
  .binxr_deprecate_alias("set_fapi_account_leverage", "futures_set_leverage")
  futures_set_leverage(symbol = symbol, leverage = leverage, config = config)
}

#' Set Binance Futures position mode
#'
#' @param dual_side_position `TRUE` for hedge mode, `FALSE` for one-way mode.
#' @param config A futures configuration created by [config_futures()].
#'
#' @return A parsed list.
#' @export
futures_set_position_mode <- function(dual_side_position = TRUE, config = config_futures()) {
  .validate_scalar_logical(dual_side_position, "dual_side_position")
  .request_signed(
    config,
    "/fapi/v1/positionSide",
    params = list(dualSidePosition = if (dual_side_position) "true" else "false"),
    method = "POST"
  )
}

#' @rdname futures_set_position_mode
#' @param dualSidePosition Legacy alias for `dual_side_position`.
#' @export
set_fapi_account_position_side <- function(dualSidePosition = TRUE, config = binxr_config_futures()) {
  .binxr_deprecate_alias("set_fapi_account_position_side", "futures_set_position_mode")
  futures_set_position_mode(dual_side_position = dualSidePosition, config = config)
}

#' Place a Binance Futures order
#'
#' @param symbol Trading pair symbol, for example `"ETHUSDT"`.
#' @param side One of `"BUY"` or `"SELL"`.
#' @param type Order type.
#' @param quantity Order quantity.
#' @param price Optional limit price.
#' @param time_in_force Optional time-in-force value. Required for `LIMIT`.
#' @param position_side One of `"BOTH"`, `"LONG"`, or `"SHORT"`.
#' @param reduce_only Whether the order is reduce-only.
#' @param stop_price Optional trigger price for conditional orders.
#' @param working_type Optional trigger source. Must only be supplied with
#'   `stop_price`.
#' @param new_client_order_id Optional client order identifier.
#' @param config A futures configuration created by [config_futures()].
#'
#' @return A parsed list.
#' @export
futures_place_order <- function(
    symbol,
    side = c("BUY", "SELL"),
    type = c(
      "LIMIT", "MARKET", "STOP", "STOP_MARKET",
      "TAKE_PROFIT", "TAKE_PROFIT_MARKET", "TRAILING_STOP_MARKET"
    ),
    quantity,
    price = NULL,
    time_in_force = NULL,
    position_side = c("BOTH", "LONG", "SHORT"),
    reduce_only = FALSE,
    stop_price = NULL,
    working_type = NULL,
    new_client_order_id = NULL,
    config = config_futures()) {
  .validate_symbol(symbol)
  side <- match.arg(side)
  type <- match.arg(type)
  position_side <- match.arg(position_side)
  .validate_positive_number(quantity, "quantity")
  .validate_optional_scalar_numeric(price, "price")
  .validate_optional_scalar_numeric(stop_price, "stop_price")
  .validate_optional_scalar_character(time_in_force, "time_in_force")
  .validate_optional_scalar_character(working_type, "working_type")
  .validate_optional_scalar_character(new_client_order_id, "new_client_order_id")
  .validate_scalar_logical(reduce_only, "reduce_only")

  if (identical(type, "LIMIT")) {
    if (is.null(price)) {
      stop("`price` is required when `type = \"LIMIT\"`.", call. = FALSE)
    }
    if (is.null(time_in_force)) {
      stop("`time_in_force` is required when `type = \"LIMIT\"`.", call. = FALSE)
    }
    .validate_one_of(time_in_force, c("GTC", "IOC", "FOK", "GTX"), "time_in_force")
  } else if (!is.null(time_in_force)) {
    stop("`time_in_force` must only be supplied when `type = \"LIMIT\"`.", call. = FALSE)
  }

  if (is.null(stop_price) && !is.null(working_type)) {
    stop("`working_type` must only be supplied when `stop_price` is provided.", call. = FALSE)
  }
  if (!is.null(working_type)) {
    .validate_one_of(working_type, c("CONTRACT_PRICE", "MARK_PRICE"), "working_type")
  }

  .request_signed(
    config,
    "/fapi/v1/order",
    params = list(
      symbol = symbol,
      side = side,
      type = type,
      quantity = quantity,
      price = price,
      timeInForce = time_in_force,
      positionSide = position_side,
      reduceOnly = if (isTRUE(reduce_only)) "true" else "false",
      stopPrice = stop_price,
      workingType = working_type,
      newClientOrderId = new_client_order_id
    ),
    method = "POST"
  )
}

#' @rdname futures_place_order
#' @param timeInForce Legacy alias for `time_in_force`.
#' @param positionSide Legacy alias for `position_side`.
#' @param reduceOnly Legacy alias for `reduce_only`.
#' @param stopPrice Legacy alias for `stop_price`.
#' @param workingType Legacy alias for `working_type`.
#' @param newClientOrderId Legacy alias for `new_client_order_id`.
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
  .binxr_deprecate_alias("place_fapi_trade_order", "futures_place_order")
  type <- match.arg(type)
  futures_place_order(
    symbol = symbol,
    side = match.arg(side),
    type = type,
    quantity = quantity,
    price = price,
    time_in_force = if (identical(type, "LIMIT")) match.arg(timeInForce) else NULL,
    position_side = match.arg(positionSide),
    reduce_only = reduceOnly,
    stop_price = stopPrice,
    working_type = if (!is.null(stopPrice)) match.arg(workingType) else NULL,
    new_client_order_id = newClientOrderId,
    config = config
  )
}

#' Cancel a Binance Futures order
#'
#' @param symbol Trading pair symbol, for example `"ETHUSDT"`.
#' @param order_id Optional exchange order ID.
#' @param orig_client_order_id Optional client order ID.
#' @param config A futures configuration created by [config_futures()].
#'
#' @return A parsed list.
#' @export
futures_cancel_order <- function(
    symbol,
    order_id = NULL,
    orig_client_order_id = NULL,
    config = config_futures()) {
  .validate_symbol(symbol)
  .validate_required_any(order_id, orig_client_order_id, arg_names = c("order_id", "orig_client_order_id"))
  .validate_optional_scalar_numeric(order_id, "order_id")
  .validate_optional_scalar_character(orig_client_order_id, "orig_client_order_id")
  .request_signed(
    config,
    "/fapi/v1/order",
    params = list(symbol = symbol, orderId = order_id, origClientOrderId = orig_client_order_id),
    method = "DELETE"
  )
}

#' @rdname futures_cancel_order
#' @param orderId Legacy alias for `order_id`.
#' @param origClientOrderId Legacy alias for `orig_client_order_id`.
#' @export
cancel_fapi_trade_order <- function(
    symbol,
    orderId = NULL,
    origClientOrderId = NULL,
    config = binxr_config_futures()) {
  .binxr_deprecate_alias("cancel_fapi_trade_order", "futures_cancel_order")
  futures_cancel_order(
    symbol = symbol,
    order_id = orderId,
    orig_client_order_id = origClientOrderId,
    config = config
  )
}

#' Cancel all open Binance Futures orders for a symbol
#'
#' @param symbol Trading pair symbol, for example `"ETHUSDT"`.
#' @param config A futures configuration created by [config_futures()].
#'
#' @return A parsed list.
#' @export
futures_cancel_all_orders <- function(symbol, config = config_futures()) {
  .validate_symbol(symbol)
  .request_signed(
    config,
    "/fapi/v1/allOpenOrders",
    params = list(symbol = symbol),
    method = "DELETE"
  )
}

#' @rdname futures_cancel_all_orders
#' @export
cancel_fapi_trade_orders_all <- function(symbol, config = binxr_config_futures()) {
  .binxr_deprecate_alias("cancel_fapi_trade_orders_all", "futures_cancel_all_orders")
  futures_cancel_all_orders(symbol = symbol, config = config)
}

#' Get Binance Futures open orders
#'
#' @param symbol Optional trading pair symbol. If `NULL`, returns all open
#'   orders.
#' @param json_list If `TRUE`, return the parsed list instead of a `data.table`.
#' @param config A futures configuration created by [config_futures()].
#'
#' @return A `data.table` by default, or a parsed list when `json_list = TRUE`.
#' @export
futures_get_open_orders <- function(symbol = NULL, json_list = FALSE, config = config_futures()) {
  if (!is.null(symbol)) {
    .validate_symbol(symbol)
  }
  payload <- .request_signed(
    config,
    "/fapi/v1/openOrders",
    params = list(symbol = symbol),
    method = "GET"
  )
  if (isTRUE(json_list)) {
    return(payload)
  }
  orders_dt <- .maybe_as_dt(payload)
  .normalize_order_time_cols(orders_dt)
}

#' @rdname futures_get_open_orders
#' @export
get_fapi_trade_open_orders <- function(symbol = NULL, config = binxr_config_futures()) {
  .binxr_deprecate_alias("get_fapi_trade_open_orders", "futures_get_open_orders")
  futures_get_open_orders(symbol = symbol, config = config)
}

#' Get Binance Futures order history
#'
#' @param symbol Trading pair symbol, for example `"ETHUSDT"`.
#' @param limit Maximum number of orders to return.
#' @param json_list If `TRUE`, return the parsed list instead of a `data.table`.
#' @param config A futures configuration created by [config_futures()].
#'
#' @return A `data.table` by default, or a parsed list when `json_list = TRUE`.
#' @export
futures_get_orders <- function(symbol, limit = 500, json_list = FALSE, config = config_futures()) {
  .validate_symbol(symbol)
  .validate_positive_integerish(limit, "limit")
  payload <- .request_signed(
    config,
    "/fapi/v1/allOrders",
    params = list(symbol = symbol, limit = limit),
    method = "GET"
  )
  if (isTRUE(json_list)) {
    return(payload)
  }
  orders_dt <- .maybe_as_dt(payload)
  .normalize_order_time_cols(orders_dt)
}

#' @rdname futures_get_orders
#' @export
get_fapi_trade_orders <- function(symbol, limit = 500, config = binxr_config_futures()) {
  .binxr_deprecate_alias("get_fapi_trade_orders", "futures_get_orders")
  futures_get_orders(symbol = symbol, limit = limit, config = config)
}

#' Get a Binance Futures order
#'
#' @param symbol Trading pair symbol, for example `"ETHUSDT"`.
#' @param order_id Optional exchange order ID.
#' @param orig_client_order_id Optional client order ID.
#' @param config A futures configuration created by [config_futures()].
#'
#' @return A parsed list.
#' @export
futures_get_order <- function(
    symbol,
    order_id = NULL,
    orig_client_order_id = NULL,
    config = config_futures()) {
  .validate_symbol(symbol)
  .validate_required_any(order_id, orig_client_order_id, arg_names = c("order_id", "orig_client_order_id"))
  .validate_optional_scalar_numeric(order_id, "order_id")
  .validate_optional_scalar_character(orig_client_order_id, "orig_client_order_id")
  .request_signed(
    config,
    "/fapi/v1/order",
    params = list(symbol = symbol, orderId = order_id, origClientOrderId = orig_client_order_id),
    method = "GET"
  )
}

#' @rdname futures_get_order
#' @param orderId Legacy alias for `order_id`.
#' @param origClientOrderId Legacy alias for `orig_client_order_id`.
#' @export
get_fapi_trade_order <- function(
    symbol,
    orderId = NULL,
    origClientOrderId = NULL,
    config = binxr_config_futures()) {
  .binxr_deprecate_alias("get_fapi_trade_order", "futures_get_order")
  futures_get_order(
    symbol = symbol,
    order_id = orderId,
    orig_client_order_id = origClientOrderId,
    config = config
  )
}

#' Test a Binance Futures order
#'
#' @inheritParams futures_place_order
#'
#' @return A parsed list.
#' @export
futures_test_order <- function(
    symbol,
    side = c("BUY", "SELL"),
    type = c(
      "LIMIT", "MARKET", "STOP", "STOP_MARKET",
      "TAKE_PROFIT", "TAKE_PROFIT_MARKET", "TRAILING_STOP_MARKET"
    ),
    quantity,
    price = NULL,
    time_in_force = NULL,
    position_side = c("BOTH", "LONG", "SHORT"),
    reduce_only = FALSE,
    stop_price = NULL,
    working_type = NULL,
    new_client_order_id = NULL,
    config = config_futures()) {
  .validate_symbol(symbol)
  side <- match.arg(side)
  type <- match.arg(type)
  position_side <- match.arg(position_side)
  .validate_positive_number(quantity, "quantity")
  .validate_optional_scalar_numeric(price, "price")
  .validate_optional_scalar_numeric(stop_price, "stop_price")
  .validate_optional_scalar_character(time_in_force, "time_in_force")
  .validate_optional_scalar_character(working_type, "working_type")
  .validate_optional_scalar_character(new_client_order_id, "new_client_order_id")
  .validate_scalar_logical(reduce_only, "reduce_only")

  if (identical(type, "LIMIT")) {
    if (is.null(price)) {
      stop("`price` is required when `type = \"LIMIT\"`.", call. = FALSE)
    }
    if (is.null(time_in_force)) {
      stop("`time_in_force` is required when `type = \"LIMIT\"`.", call. = FALSE)
    }
    .validate_one_of(time_in_force, c("GTC", "IOC", "FOK", "GTX"), "time_in_force")
  } else if (!is.null(time_in_force)) {
    stop("`time_in_force` must only be supplied when `type = \"LIMIT\"`.", call. = FALSE)
  }

  if (is.null(stop_price) && !is.null(working_type)) {
    stop("`working_type` must only be supplied when `stop_price` is provided.", call. = FALSE)
  }
  if (!is.null(working_type)) {
    .validate_one_of(working_type, c("CONTRACT_PRICE", "MARK_PRICE"), "working_type")
  }

  .request_signed(
    config,
    "/fapi/v1/order/test",
    params = list(
      symbol = symbol,
      side = side,
      type = type,
      quantity = quantity,
      price = price,
      timeInForce = time_in_force,
      positionSide = position_side,
      reduceOnly = if (isTRUE(reduce_only)) "true" else "false",
      stopPrice = stop_price,
      workingType = working_type,
      newClientOrderId = new_client_order_id
    ),
    method = "POST"
  )
}

#' Set Binance Futures multi-assets mode
#'
#' @param multi_assets_margin `TRUE` to enable multi-assets mode, `FALSE` to disable it.
#' @param config A futures configuration created by [config_futures()].
#'
#' @return A parsed list.
#' @export
futures_set_multi_assets_mode <- function(multi_assets_margin = TRUE, config = config_futures()) {
  .validate_scalar_logical(multi_assets_margin, "multi_assets_margin")
  .request_signed(
    config,
    "/fapi/v1/multiAssetsMargin",
    params = list(multiAssetsMargin = if (isTRUE(multi_assets_margin)) "true" else "false"),
    method = "POST"
  )
}

#' Set Binance Futures countdown cancel-all
#'
#' @param symbol Trading pair symbol, for example `"ETHUSDT"`.
#' @param countdown_time Countdown time in milliseconds.
#' @param config A futures configuration created by [config_futures()].
#'
#' @return A parsed list.
#' @export
futures_countdown_cancel_all <- function(symbol, countdown_time, config = config_futures()) {
  .validate_symbol(symbol)
  .validate_positive_integerish(countdown_time, "countdown_time")
  .request_signed(
    config,
    "/fapi/v1/countdownCancelAll",
    params = list(symbol = symbol, countdownTime = countdown_time),
    method = "POST"
  )
}

#' Get Binance Futures account trades
#'
#' @param symbol Trading pair symbol, for example `"ETHUSDT"`.
#' @param order_id Optional order ID.
#' @param startTime Optional start time in milliseconds since Unix epoch.
#' @param endTime Optional end time in milliseconds since Unix epoch.
#' @param fromId Optional trade ID to start from.
#' @param limit Maximum number of rows to return. Must not exceed `1000`.
#' @param json_list If `TRUE`, return the parsed list instead of a `data.table`.
#' @param config A futures configuration created by [config_futures()].
#'
#' @return A `data.table` by default, or a parsed list when `json_list = TRUE`.
#' @export
futures_get_account_trades <- function(
    symbol,
    order_id = NULL,
    startTime = NULL,
    endTime = NULL,
    fromId = NULL,
    limit = 500,
    json_list = FALSE,
    config = config_futures()) {
  .validate_symbol(symbol)
  .validate_optional_scalar_numeric(order_id, "order_id")
  .validate_optional_scalar_numeric(startTime, "startTime")
  .validate_optional_scalar_numeric(endTime, "endTime")
  .validate_optional_scalar_numeric(fromId, "fromId")
  .futures_validate_limit(limit)
  .validate_json_list_flag(json_list)

  if (!is.null(fromId) && (!is.null(startTime) || !is.null(endTime))) {
    stop("`fromId` must not be supplied with `startTime` or `endTime`.", call. = FALSE)
  }
  .futures_validate_time_window(startTime, endTime, 7L * 24L * 60L * 60L * 1000L, "7 days")

  payload <- .request_signed(
    config,
    "/fapi/v1/userTrades",
    params = list(
      symbol = symbol,
      orderId = order_id,
      startTime = startTime,
      endTime = endTime,
      fromId = fromId,
      limit = limit
    ),
    method = "GET"
  )
  if (isTRUE(json_list)) {
    return(payload)
  }

  trades_dt <- .maybe_as_dt(payload)
  trades_dt <- .coerce_numeric_cols(
    trades_dt,
    c("commission", "id", "orderId", "price", "qty", "quoteQty", "realizedPnl")
  )
  .normalize_time_cols(trades_dt, "time")
}

#' Get Binance Futures force orders
#'
#' @param symbol Optional trading pair symbol.
#' @param auto_close_type Optional auto-close type.
#' @param startTime Optional start time in milliseconds since Unix epoch.
#' @param endTime Optional end time in milliseconds since Unix epoch.
#' @param limit Maximum number of rows to return. Must not exceed `100`.
#' @param json_list If `TRUE`, return the parsed list instead of a `data.table`.
#' @param config A futures configuration created by [config_futures()].
#'
#' @return A `data.table` by default, or a parsed list when `json_list = TRUE`.
#' @export
futures_get_force_orders <- function(
    symbol = NULL,
    auto_close_type = NULL,
    startTime = NULL,
    endTime = NULL,
    limit = 50,
    json_list = FALSE,
    config = config_futures()) {
  if (!is.null(symbol)) {
    .validate_symbol(symbol)
  }
  .validate_optional_scalar_character(auto_close_type, "auto_close_type")
  .validate_optional_scalar_numeric(startTime, "startTime")
  .validate_optional_scalar_numeric(endTime, "endTime")
  .futures_validate_limit(limit, max = 100)
  .validate_json_list_flag(json_list)

  payload <- .request_signed(
    config,
    "/fapi/v1/forceOrders",
    params = list(symbol = symbol, autoCloseType = auto_close_type, startTime = startTime, endTime = endTime, limit = limit),
    method = "GET"
  )
  if (isTRUE(json_list)) {
    return(payload)
  }

  orders_dt <- .maybe_as_dt(payload)
  orders_dt <- .coerce_numeric_cols(
    orders_dt,
    c("price", "origQty", "executedQty", "averagePrice", "cumQuote", "orderId")
  )
  .normalize_time_cols(orders_dt, "time")
}
