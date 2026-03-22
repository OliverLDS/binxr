#' Place a Binance Spot order
#'
#' @param symbol Trading pair symbol, for example `"BTCUSDT"`.
#' @param side One of `"BUY"` or `"SELL"`.
#' @param type Order type.
#' @param time_in_force Optional time-in-force value.
#' @param quantity Optional order quantity.
#' @param quote_order_qty Optional quote-order quantity for `MARKET` orders.
#' @param price Optional limit price.
#' @param new_client_order_id Optional client order identifier.
#' @param strategy_id Optional numeric strategy identifier.
#' @param strategy_type Optional numeric strategy type. Must be at least `1000000`.
#' @param stop_price Optional trigger price.
#' @param trailing_delta Optional trailing delta value.
#' @param iceberg_qty Optional iceberg quantity.
#' @param new_order_resp_type Optional response type. One of `"ACK"`, `"RESULT"`, or `"FULL"`.
#' @param self_trade_prevention_mode Optional self-trade prevention mode.
#' @param peg_price_type Optional pegged price type. One of `"PRIMARY_PEG"` or `"MARKET_PEG"`.
#' @param peg_offset_value Optional peg offset value.
#' @param peg_offset_type Optional peg offset type. Only `"PRICE_LEVEL"` is supported.
#' @param config A spot configuration created by [config_spot()].
#'
#' @return A parsed list.
#' @export
spot_place_order <- function(
    symbol,
    side = c("BUY", "SELL"),
    type = c(
      "LIMIT", "MARKET", "STOP_LOSS", "STOP_LOSS_LIMIT",
      "TAKE_PROFIT", "TAKE_PROFIT_LIMIT", "LIMIT_MAKER"
    ),
    time_in_force = NULL,
    quantity = NULL,
    quote_order_qty = NULL,
    price = NULL,
    new_client_order_id = NULL,
    strategy_id = NULL,
    strategy_type = NULL,
    stop_price = NULL,
    trailing_delta = NULL,
    iceberg_qty = NULL,
    new_order_resp_type = NULL,
    self_trade_prevention_mode = NULL,
    peg_price_type = NULL,
    peg_offset_value = NULL,
    peg_offset_type = NULL,
    config = config_spot()) {
  side <- match.arg(side)
  type <- match.arg(type)
  .validate_symbol(symbol)
  .validate_optional_scalar_character(time_in_force, "time_in_force")
  .validate_optional_scalar_numeric(quantity, "quantity")
  .validate_optional_scalar_numeric(quote_order_qty, "quote_order_qty")
  .validate_optional_scalar_numeric(price, "price")
  .validate_optional_scalar_character(new_client_order_id, "new_client_order_id")
  .validate_optional_scalar_numeric(strategy_id, "strategy_id")
  .validate_optional_scalar_numeric(strategy_type, "strategy_type")
  .validate_optional_scalar_numeric(stop_price, "stop_price")
  .validate_optional_scalar_numeric(trailing_delta, "trailing_delta")
  .validate_optional_scalar_numeric(iceberg_qty, "iceberg_qty")
  .validate_optional_scalar_character(new_order_resp_type, "new_order_resp_type")
  .validate_optional_scalar_character(self_trade_prevention_mode, "self_trade_prevention_mode")
  .validate_optional_scalar_character(peg_price_type, "peg_price_type")
  .validate_optional_scalar_numeric(peg_offset_value, "peg_offset_value")
  .validate_optional_scalar_character(peg_offset_type, "peg_offset_type")

  .spot_validate_order_request(
    type = type,
    time_in_force = time_in_force,
    quantity = quantity,
    quote_order_qty = quote_order_qty,
    price = price,
    strategy_type = strategy_type,
    stop_price = stop_price,
    trailing_delta = trailing_delta,
    iceberg_qty = iceberg_qty,
    new_order_resp_type = new_order_resp_type,
    peg_price_type = peg_price_type,
    peg_offset_value = peg_offset_value,
    peg_offset_type = peg_offset_type
  )

  .request_signed(
    config,
    "/api/v3/order",
    params = list(
      symbol = symbol,
      side = side,
      type = type,
      timeInForce = time_in_force,
      quantity = quantity,
      quoteOrderQty = quote_order_qty,
      price = price,
      newClientOrderId = new_client_order_id,
      strategyId = strategy_id,
      strategyType = strategy_type,
      stopPrice = stop_price,
      trailingDelta = trailing_delta,
      icebergQty = iceberg_qty,
      newOrderRespType = new_order_resp_type,
      selfTradePreventionMode = self_trade_prevention_mode,
      pegPriceType = peg_price_type,
      pegOffsetValue = peg_offset_value,
      pegOffsetType = peg_offset_type
    ),
    method = "POST"
  )
}

#' Test a Binance Spot order
#'
#' @inheritParams spot_place_order
#' @param compute_commission_rates Whether to return commission-rate details.
#'
#' @return A parsed list.
#' @export
spot_test_order <- function(
    symbol,
    side = c("BUY", "SELL"),
    type = c(
      "LIMIT", "MARKET", "STOP_LOSS", "STOP_LOSS_LIMIT",
      "TAKE_PROFIT", "TAKE_PROFIT_LIMIT", "LIMIT_MAKER"
    ),
    time_in_force = NULL,
    quantity = NULL,
    quote_order_qty = NULL,
    price = NULL,
    new_client_order_id = NULL,
    strategy_id = NULL,
    strategy_type = NULL,
    stop_price = NULL,
    trailing_delta = NULL,
    iceberg_qty = NULL,
    new_order_resp_type = NULL,
    self_trade_prevention_mode = NULL,
    peg_price_type = NULL,
    peg_offset_value = NULL,
    peg_offset_type = NULL,
    compute_commission_rates = FALSE,
    config = config_spot()) {
  .validate_scalar_logical(compute_commission_rates, "compute_commission_rates")

  side <- match.arg(side)
  type <- match.arg(type)
  .validate_symbol(symbol)
  .validate_optional_scalar_character(time_in_force, "time_in_force")
  .validate_optional_scalar_numeric(quantity, "quantity")
  .validate_optional_scalar_numeric(quote_order_qty, "quote_order_qty")
  .validate_optional_scalar_numeric(price, "price")
  .validate_optional_scalar_character(new_client_order_id, "new_client_order_id")
  .validate_optional_scalar_numeric(strategy_id, "strategy_id")
  .validate_optional_scalar_numeric(strategy_type, "strategy_type")
  .validate_optional_scalar_numeric(stop_price, "stop_price")
  .validate_optional_scalar_numeric(trailing_delta, "trailing_delta")
  .validate_optional_scalar_numeric(iceberg_qty, "iceberg_qty")
  .validate_optional_scalar_character(new_order_resp_type, "new_order_resp_type")
  .validate_optional_scalar_character(self_trade_prevention_mode, "self_trade_prevention_mode")
  .validate_optional_scalar_character(peg_price_type, "peg_price_type")
  .validate_optional_scalar_numeric(peg_offset_value, "peg_offset_value")
  .validate_optional_scalar_character(peg_offset_type, "peg_offset_type")

  .spot_validate_order_request(
    type = type,
    time_in_force = time_in_force,
    quantity = quantity,
    quote_order_qty = quote_order_qty,
    price = price,
    strategy_type = strategy_type,
    stop_price = stop_price,
    trailing_delta = trailing_delta,
    iceberg_qty = iceberg_qty,
    new_order_resp_type = new_order_resp_type,
    peg_price_type = peg_price_type,
    peg_offset_value = peg_offset_value,
    peg_offset_type = peg_offset_type
  )

  .request_signed(
    config,
    "/api/v3/order/test",
    params = list(
      symbol = symbol,
      side = side,
      type = type,
      timeInForce = time_in_force,
      quantity = quantity,
      quoteOrderQty = quote_order_qty,
      price = price,
      newClientOrderId = new_client_order_id,
      strategyId = strategy_id,
      strategyType = strategy_type,
      stopPrice = stop_price,
      trailingDelta = trailing_delta,
      icebergQty = iceberg_qty,
      newOrderRespType = new_order_resp_type,
      selfTradePreventionMode = self_trade_prevention_mode,
      pegPriceType = peg_price_type,
      pegOffsetValue = peg_offset_value,
      pegOffsetType = peg_offset_type,
      computeCommissionRates = if (isTRUE(compute_commission_rates)) "true" else "false"
    ),
    method = "POST"
  )
}

#' Cancel a Binance Spot order
#'
#' @param symbol Trading pair symbol, for example `"BTCUSDT"`.
#' @param order_id Optional exchange order ID.
#' @param orig_client_order_id Optional client order ID.
#' @param new_client_order_id Optional client order ID for the cancel request.
#' @param cancel_restrictions Optional cancel restriction. One of `"ONLY_NEW"` or `"ONLY_PARTIALLY_FILLED"`.
#' @param config A spot configuration created by [config_spot()].
#'
#' @return A parsed list.
#' @export
spot_cancel_order <- function(
    symbol,
    order_id = NULL,
    orig_client_order_id = NULL,
    new_client_order_id = NULL,
    cancel_restrictions = NULL,
    config = config_spot()) {
  .validate_symbol(symbol)
  .validate_required_any(order_id, orig_client_order_id, arg_names = c("order_id", "orig_client_order_id"))
  .validate_optional_scalar_numeric(order_id, "order_id")
  .validate_optional_scalar_character(orig_client_order_id, "orig_client_order_id")
  .validate_optional_scalar_character(new_client_order_id, "new_client_order_id")
  .validate_optional_scalar_character(cancel_restrictions, "cancel_restrictions")
  if (!is.null(cancel_restrictions)) {
    .validate_one_of(cancel_restrictions, c("ONLY_NEW", "ONLY_PARTIALLY_FILLED"), "cancel_restrictions")
  }

  .request_signed(
    config,
    "/api/v3/order",
    params = list(
      symbol = symbol,
      orderId = order_id,
      origClientOrderId = orig_client_order_id,
      newClientOrderId = new_client_order_id,
      cancelRestrictions = cancel_restrictions
    ),
    method = "DELETE"
  )
}

#' Cancel all open Binance Spot orders for a symbol
#'
#' @param symbol Trading pair symbol, for example `"BTCUSDT"`.
#' @param config A spot configuration created by [config_spot()].
#'
#' @return A parsed list by default.
#' @export
spot_cancel_all_orders <- function(symbol, config = config_spot()) {
  .validate_symbol(symbol)
  .request_signed(
    config,
    "/api/v3/openOrders",
    params = list(symbol = symbol),
    method = "DELETE"
  )
}

#' Cancel and replace a Binance Spot order
#'
#' @inheritParams spot_place_order
#' @param cancel_replace_mode One of `"STOP_ON_FAILURE"` or `"ALLOW_FAILURE"`.
#' @param cancel_new_client_order_id Optional client order ID for the cancel request.
#' @param cancel_orig_client_order_id Optional original client order ID to cancel.
#' @param cancel_order_id Optional exchange order ID to cancel.
#' @param cancel_restrictions Optional cancel restriction. One of `"ONLY_NEW"` or `"ONLY_PARTIALLY_FILLED"`.
#' @param order_rate_limit_exceeded_mode Optional order-rate-limit behavior. One of `"DO_NOTHING"` or `"CANCEL_ONLY"`.
#'
#' @return A parsed list.
#' @export
spot_cancel_replace_order <- function(
    symbol,
    side = c("BUY", "SELL"),
    type = c(
      "LIMIT", "MARKET", "STOP_LOSS", "STOP_LOSS_LIMIT",
      "TAKE_PROFIT", "TAKE_PROFIT_LIMIT", "LIMIT_MAKER"
    ),
    cancel_replace_mode = c("STOP_ON_FAILURE", "ALLOW_FAILURE"),
    time_in_force = NULL,
    quantity = NULL,
    quote_order_qty = NULL,
    price = NULL,
    cancel_new_client_order_id = NULL,
    cancel_orig_client_order_id = NULL,
    cancel_order_id = NULL,
    new_client_order_id = NULL,
    strategy_id = NULL,
    strategy_type = NULL,
    stop_price = NULL,
    trailing_delta = NULL,
    iceberg_qty = NULL,
    new_order_resp_type = NULL,
    self_trade_prevention_mode = NULL,
    cancel_restrictions = NULL,
    order_rate_limit_exceeded_mode = NULL,
    peg_price_type = NULL,
    peg_offset_value = NULL,
    peg_offset_type = NULL,
    config = config_spot()) {
  side <- match.arg(side)
  type <- match.arg(type)
  cancel_replace_mode <- match.arg(cancel_replace_mode)
  .validate_symbol(symbol)
  .validate_optional_scalar_character(cancel_new_client_order_id, "cancel_new_client_order_id")
  .validate_optional_scalar_character(cancel_orig_client_order_id, "cancel_orig_client_order_id")
  .validate_optional_scalar_numeric(cancel_order_id, "cancel_order_id")
  .validate_required_any(cancel_order_id, cancel_orig_client_order_id, arg_names = c("cancel_order_id", "cancel_orig_client_order_id"))
  .validate_optional_scalar_character(cancel_restrictions, "cancel_restrictions")
  .validate_optional_scalar_character(order_rate_limit_exceeded_mode, "order_rate_limit_exceeded_mode")

  if (!is.null(cancel_restrictions)) {
    .validate_one_of(cancel_restrictions, c("ONLY_NEW", "ONLY_PARTIALLY_FILLED"), "cancel_restrictions")
  }
  if (!is.null(order_rate_limit_exceeded_mode)) {
    .validate_one_of(order_rate_limit_exceeded_mode, c("DO_NOTHING", "CANCEL_ONLY"), "order_rate_limit_exceeded_mode")
  }

  .spot_validate_order_request(
    type = type,
    time_in_force = time_in_force,
    quantity = quantity,
    quote_order_qty = quote_order_qty,
    price = price,
    strategy_type = strategy_type,
    stop_price = stop_price,
    trailing_delta = trailing_delta,
    iceberg_qty = iceberg_qty,
    new_order_resp_type = new_order_resp_type,
    peg_price_type = peg_price_type,
    peg_offset_value = peg_offset_value,
    peg_offset_type = peg_offset_type
  )

  .request_signed(
    config,
    "/api/v3/order/cancelReplace",
    params = list(
      symbol = symbol,
      side = side,
      type = type,
      cancelReplaceMode = cancel_replace_mode,
      timeInForce = time_in_force,
      quantity = quantity,
      quoteOrderQty = quote_order_qty,
      price = price,
      cancelNewClientOrderId = cancel_new_client_order_id,
      cancelOrigClientOrderId = cancel_orig_client_order_id,
      cancelOrderId = cancel_order_id,
      newClientOrderId = new_client_order_id,
      strategyId = strategy_id,
      strategyType = strategy_type,
      stopPrice = stop_price,
      trailingDelta = trailing_delta,
      icebergQty = iceberg_qty,
      newOrderRespType = new_order_resp_type,
      selfTradePreventionMode = self_trade_prevention_mode,
      cancelRestrictions = cancel_restrictions,
      orderRateLimitExceededMode = order_rate_limit_exceeded_mode,
      pegPriceType = peg_price_type,
      pegOffsetValue = peg_offset_value,
      pegOffsetType = peg_offset_type
    ),
    method = "POST"
  )
}

#' Amend a Binance Spot order while keeping priority
#'
#' @param symbol Trading pair symbol, for example `"BTCUSDT"`.
#' @param order_id Optional exchange order ID.
#' @param orig_client_order_id Optional client order ID.
#' @param new_client_order_id Optional new client order ID after amendment.
#' @param new_qty New order quantity. Must be positive.
#' @param config A spot configuration created by [config_spot()].
#'
#' @return A parsed list.
#' @export
spot_amend_order_keep_priority <- function(
    symbol,
    order_id = NULL,
    orig_client_order_id = NULL,
    new_client_order_id = NULL,
    new_qty,
    config = config_spot()) {
  .validate_symbol(symbol)
  .validate_required_any(order_id, orig_client_order_id, arg_names = c("order_id", "orig_client_order_id"))
  .validate_optional_scalar_numeric(order_id, "order_id")
  .validate_optional_scalar_character(orig_client_order_id, "orig_client_order_id")
  .validate_optional_scalar_character(new_client_order_id, "new_client_order_id")
  .validate_positive_number(new_qty, "new_qty")

  .request_signed(
    config,
    "/api/v3/order/amend/keepPriority",
    params = list(
      symbol = symbol,
      orderId = order_id,
      origClientOrderId = orig_client_order_id,
      newClientOrderId = new_client_order_id,
      newQty = new_qty
    ),
    method = "PUT"
  )
}

#' Place a deprecated Binance Spot OCO order
#'
#' @param symbol Trading pair symbol, for example `"BTCUSDT"`.
#' @param side One of `"BUY"` or `"SELL"`.
#' @param quantity Order quantity shared by both legs.
#' @param price Limit price for the maker leg.
#' @param stop_price Stop trigger price.
#' @param list_client_order_id Optional order-list client ID.
#' @param limit_client_order_id Optional limit-leg client ID.
#' @param limit_strategy_id Optional limit-leg strategy ID.
#' @param limit_strategy_type Optional limit-leg strategy type.
#' @param limit_iceberg_qty Optional limit-leg iceberg quantity.
#' @param trailing_delta Optional shared trailing delta.
#' @param stop_client_order_id Optional stop-leg client ID.
#' @param stop_strategy_id Optional stop-leg strategy ID.
#' @param stop_strategy_type Optional stop-leg strategy type.
#' @param stop_limit_price Optional stop-limit price.
#' @param stop_iceberg_qty Optional stop-leg iceberg quantity.
#' @param stop_limit_time_in_force Optional stop-limit time-in-force.
#' @param new_order_resp_type Optional response type. One of `"ACK"`, `"RESULT"`, or `"FULL"`.
#' @param self_trade_prevention_mode Optional self-trade prevention mode.
#' @param config A spot configuration created by [config_spot()].
#'
#' @return A parsed list.
#' @export
spot_place_oco_order <- function(
    symbol,
    side = c("BUY", "SELL"),
    quantity,
    price,
    stop_price,
    list_client_order_id = NULL,
    limit_client_order_id = NULL,
    limit_strategy_id = NULL,
    limit_strategy_type = NULL,
    limit_iceberg_qty = NULL,
    trailing_delta = NULL,
    stop_client_order_id = NULL,
    stop_strategy_id = NULL,
    stop_strategy_type = NULL,
    stop_limit_price = NULL,
    stop_iceberg_qty = NULL,
    stop_limit_time_in_force = NULL,
    new_order_resp_type = NULL,
    self_trade_prevention_mode = NULL,
    config = config_spot()) {
  side <- match.arg(side)
  .validate_symbol(symbol)
  .validate_positive_number(quantity, "quantity")
  .validate_positive_number(price, "price")
  .validate_positive_number(stop_price, "stop_price")
  .validate_optional_scalar_character(list_client_order_id, "list_client_order_id")
  .validate_optional_scalar_character(limit_client_order_id, "limit_client_order_id")
  .validate_optional_scalar_character(stop_client_order_id, "stop_client_order_id")
  .validate_optional_scalar_numeric(limit_strategy_id, "limit_strategy_id")
  .validate_optional_scalar_numeric(limit_strategy_type, "limit_strategy_type")
  .validate_optional_scalar_numeric(limit_iceberg_qty, "limit_iceberg_qty")
  .validate_optional_scalar_numeric(trailing_delta, "trailing_delta")
  .validate_optional_scalar_numeric(stop_strategy_id, "stop_strategy_id")
  .validate_optional_scalar_numeric(stop_strategy_type, "stop_strategy_type")
  .validate_optional_scalar_numeric(stop_limit_price, "stop_limit_price")
  .validate_optional_scalar_numeric(stop_iceberg_qty, "stop_iceberg_qty")
  .validate_optional_scalar_character(stop_limit_time_in_force, "stop_limit_time_in_force")
  .validate_optional_scalar_character(new_order_resp_type, "new_order_resp_type")
  .validate_optional_scalar_character(self_trade_prevention_mode, "self_trade_prevention_mode")

  .spot_validate_strategy_type(limit_strategy_type, "limit_strategy_type")
  .spot_validate_strategy_type(stop_strategy_type, "stop_strategy_type")
  .spot_validate_positive_optional(limit_iceberg_qty, "limit_iceberg_qty")
  .spot_validate_positive_optional(trailing_delta, "trailing_delta")
  .spot_validate_positive_optional(stop_limit_price, "stop_limit_price")
  .spot_validate_positive_optional(stop_iceberg_qty, "stop_iceberg_qty")
  .spot_validate_optional_resp_type(new_order_resp_type)

  if (!is.null(stop_limit_price) && is.null(stop_limit_time_in_force)) {
    stop("`stop_limit_time_in_force` is required when `stop_limit_price` is supplied.", call. = FALSE)
  }
  if (!is.null(stop_limit_time_in_force)) {
    .validate_one_of(stop_limit_time_in_force, c("GTC", "FOK", "IOC"), "stop_limit_time_in_force")
  }

  .request_signed(
    config,
    "/api/v3/order/oco",
    params = list(
      symbol = symbol,
      listClientOrderId = list_client_order_id,
      side = side,
      quantity = quantity,
      limitClientOrderId = limit_client_order_id,
      price = price,
      limitStrategyId = limit_strategy_id,
      limitStrategyType = limit_strategy_type,
      limitIcebergQty = limit_iceberg_qty,
      trailingDelta = trailing_delta,
      stopClientOrderId = stop_client_order_id,
      stopPrice = stop_price,
      stopStrategyId = stop_strategy_id,
      stopStrategyType = stop_strategy_type,
      stopLimitPrice = stop_limit_price,
      stopIcebergQty = stop_iceberg_qty,
      stopLimitTimeInForce = stop_limit_time_in_force,
      newOrderRespType = new_order_resp_type,
      selfTradePreventionMode = self_trade_prevention_mode
    ),
    method = "POST"
  )
}

#' Place a Binance Spot OCO order list
#'
#' @inheritParams spot_place_oco_order
#' @param above_type Type for the above leg.
#' @param above_client_order_id Optional above-leg client ID.
#' @param above_iceberg_qty Optional above-leg iceberg quantity.
#' @param above_price Optional above-leg limit price.
#' @param above_stop_price Optional above-leg stop price.
#' @param above_trailing_delta Optional above-leg trailing delta.
#' @param above_time_in_force Optional above-leg time-in-force.
#' @param above_strategy_id Optional above-leg strategy ID.
#' @param above_strategy_type Optional above-leg strategy type.
#' @param above_peg_price_type Optional above-leg peg price type.
#' @param above_peg_offset_type Optional above-leg peg offset type.
#' @param above_peg_offset_value Optional above-leg peg offset value.
#' @param below_type Type for the below leg.
#' @param below_client_order_id Optional below-leg client ID.
#' @param below_iceberg_qty Optional below-leg iceberg quantity.
#' @param below_price Optional below-leg limit price.
#' @param below_stop_price Optional below-leg stop price.
#' @param below_trailing_delta Optional below-leg trailing delta.
#' @param below_time_in_force Optional below-leg time-in-force.
#' @param below_strategy_id Optional below-leg strategy ID.
#' @param below_strategy_type Optional below-leg strategy type.
#' @param below_peg_price_type Optional below-leg peg price type.
#' @param below_peg_offset_type Optional below-leg peg offset type.
#' @param below_peg_offset_value Optional below-leg peg offset value.
#'
#' @return A parsed list.
#' @export
spot_place_order_list_oco <- function(
    symbol,
    side = c("BUY", "SELL"),
    quantity,
    above_type = c("STOP_LOSS_LIMIT", "STOP_LOSS", "LIMIT_MAKER", "TAKE_PROFIT", "TAKE_PROFIT_LIMIT"),
    above_client_order_id = NULL,
    above_iceberg_qty = NULL,
    above_price = NULL,
    above_stop_price = NULL,
    above_trailing_delta = NULL,
    above_time_in_force = NULL,
    above_strategy_id = NULL,
    above_strategy_type = NULL,
    above_peg_price_type = NULL,
    above_peg_offset_type = NULL,
    above_peg_offset_value = NULL,
    below_type = c("STOP_LOSS", "STOP_LOSS_LIMIT", "TAKE_PROFIT", "TAKE_PROFIT_LIMIT"),
    below_client_order_id = NULL,
    below_iceberg_qty = NULL,
    below_price = NULL,
    below_stop_price = NULL,
    below_trailing_delta = NULL,
    below_time_in_force = NULL,
    below_strategy_id = NULL,
    below_strategy_type = NULL,
    below_peg_price_type = NULL,
    below_peg_offset_type = NULL,
    below_peg_offset_value = NULL,
    list_client_order_id = NULL,
    new_order_resp_type = NULL,
    self_trade_prevention_mode = NULL,
    config = config_spot()) {
  side <- match.arg(side)
  above_type <- match.arg(above_type)
  below_type <- match.arg(below_type)
  .validate_symbol(symbol)
  .validate_positive_number(quantity, "quantity")
  .validate_optional_scalar_character(list_client_order_id, "list_client_order_id")
  .validate_optional_scalar_character(above_client_order_id, "above_client_order_id")
  .validate_optional_scalar_character(below_client_order_id, "below_client_order_id")
  .spot_validate_order_list_leg(
    type = above_type,
    price = above_price,
    stop_price = above_stop_price,
    trailing_delta = above_trailing_delta,
    time_in_force = above_time_in_force,
    iceberg_qty = above_iceberg_qty,
    strategy_type = above_strategy_type,
    peg_price_type = above_peg_price_type,
    peg_offset_type = above_peg_offset_type,
    peg_offset_value = above_peg_offset_value,
    prefix = "above"
  )
  .spot_validate_order_list_leg(
    type = below_type,
    price = below_price,
    stop_price = below_stop_price,
    trailing_delta = below_trailing_delta,
    time_in_force = below_time_in_force,
    iceberg_qty = below_iceberg_qty,
    strategy_type = below_strategy_type,
    peg_price_type = below_peg_price_type,
    peg_offset_type = below_peg_offset_type,
    peg_offset_value = below_peg_offset_value,
    prefix = "below"
  )
  .spot_validate_optional_resp_type(new_order_resp_type)

  .request_signed(
    config,
    "/api/v3/orderList/oco",
    params = list(
      symbol = symbol,
      listClientOrderId = list_client_order_id,
      side = side,
      quantity = quantity,
      aboveType = above_type,
      aboveClientOrderId = above_client_order_id,
      aboveIcebergQty = above_iceberg_qty,
      abovePrice = above_price,
      aboveStopPrice = above_stop_price,
      aboveTrailingDelta = above_trailing_delta,
      aboveTimeInForce = above_time_in_force,
      aboveStrategyId = above_strategy_id,
      aboveStrategyType = above_strategy_type,
      abovePegPriceType = above_peg_price_type,
      abovePegOffsetType = above_peg_offset_type,
      abovePegOffsetValue = above_peg_offset_value,
      belowType = below_type,
      belowClientOrderId = below_client_order_id,
      belowIcebergQty = below_iceberg_qty,
      belowPrice = below_price,
      belowStopPrice = below_stop_price,
      belowTrailingDelta = below_trailing_delta,
      belowTimeInForce = below_time_in_force,
      belowStrategyId = below_strategy_id,
      belowStrategyType = below_strategy_type,
      belowPegPriceType = below_peg_price_type,
      belowPegOffsetType = below_peg_offset_type,
      belowPegOffsetValue = below_peg_offset_value,
      newOrderRespType = new_order_resp_type,
      selfTradePreventionMode = self_trade_prevention_mode
    ),
    method = "POST"
  )
}

#' Place a Binance Spot OTO order list
#'
#' @param symbol Trading pair symbol, for example `"BTCUSDT"`.
#' @param list_client_order_id Optional order-list client ID.
#' @param new_order_resp_type Optional response type. One of `"ACK"`, `"RESULT"`, or `"FULL"`.
#' @param self_trade_prevention_mode Optional self-trade prevention mode.
#' @param working_type Working leg type. One of `"LIMIT"` or `"LIMIT_MAKER"`.
#' @param working_side Working leg side. One of `"BUY"` or `"SELL"`.
#' @param working_client_order_id Optional working-leg client ID.
#' @param working_price Working leg price.
#' @param working_quantity Working leg quantity.
#' @param working_iceberg_qty Optional working-leg iceberg quantity.
#' @param working_time_in_force Optional working-leg time-in-force.
#' @param working_strategy_id Optional working-leg strategy ID.
#' @param working_strategy_type Optional working-leg strategy type.
#' @param working_peg_price_type Optional working-leg peg price type.
#' @param working_peg_offset_type Optional working-leg peg offset type.
#' @param working_peg_offset_value Optional working-leg peg offset value.
#' @param pending_type Pending leg order type.
#' @param pending_side Pending leg side. One of `"BUY"` or `"SELL"`.
#' @param pending_client_order_id Optional pending-leg client ID.
#' @param pending_price Optional pending-leg price.
#' @param pending_stop_price Optional pending-leg stop price.
#' @param pending_trailing_delta Optional pending-leg trailing delta.
#' @param pending_quantity Pending leg quantity.
#' @param pending_iceberg_qty Optional pending-leg iceberg quantity.
#' @param pending_time_in_force Optional pending-leg time-in-force.
#' @param pending_strategy_id Optional pending-leg strategy ID.
#' @param pending_strategy_type Optional pending-leg strategy type.
#' @param pending_peg_price_type Optional pending-leg peg price type.
#' @param pending_peg_offset_type Optional pending-leg peg offset type.
#' @param pending_peg_offset_value Optional pending-leg peg offset value.
#' @param config A spot configuration created by [config_spot()].
#'
#' @return A parsed list.
#' @export
spot_place_order_list_oto <- function(
    symbol,
    list_client_order_id = NULL,
    new_order_resp_type = NULL,
    self_trade_prevention_mode = NULL,
    working_type = c("LIMIT", "LIMIT_MAKER"),
    working_side = c("BUY", "SELL"),
    working_client_order_id = NULL,
    working_price,
    working_quantity,
    working_iceberg_qty = NULL,
    working_time_in_force = NULL,
    working_strategy_id = NULL,
    working_strategy_type = NULL,
    working_peg_price_type = NULL,
    working_peg_offset_type = NULL,
    working_peg_offset_value = NULL,
    pending_type = c("LIMIT", "MARKET", "STOP_LOSS", "STOP_LOSS_LIMIT", "TAKE_PROFIT", "TAKE_PROFIT_LIMIT", "LIMIT_MAKER"),
    pending_side = c("BUY", "SELL"),
    pending_client_order_id = NULL,
    pending_price = NULL,
    pending_stop_price = NULL,
    pending_trailing_delta = NULL,
    pending_quantity,
    pending_iceberg_qty = NULL,
    pending_time_in_force = NULL,
    pending_strategy_id = NULL,
    pending_strategy_type = NULL,
    pending_peg_price_type = NULL,
    pending_peg_offset_type = NULL,
    pending_peg_offset_value = NULL,
    config = config_spot()) {
  working_type <- match.arg(working_type)
  working_side <- match.arg(working_side)
  pending_type <- match.arg(pending_type)
  pending_side <- match.arg(pending_side)
  .validate_symbol(symbol)
  .validate_positive_number(working_price, "working_price")
  .validate_positive_number(working_quantity, "working_quantity")
  .validate_positive_number(pending_quantity, "pending_quantity")
  if (identical(pending_type, "MARKET") && !is.null(pending_price)) {
    stop("`pending_price` must not be supplied when `pending_type = \"MARKET\"`.", call. = FALSE)
  }
  .spot_validate_working_order_list_leg(
    type = working_type,
    time_in_force = working_time_in_force,
    iceberg_qty = working_iceberg_qty,
    strategy_type = working_strategy_type,
    peg_price_type = working_peg_price_type,
    peg_offset_type = working_peg_offset_type,
    peg_offset_value = working_peg_offset_value,
    prefix = "working"
  )
  .spot_validate_order_list_leg(
    type = pending_type,
    price = pending_price,
    stop_price = pending_stop_price,
    trailing_delta = pending_trailing_delta,
    time_in_force = pending_time_in_force,
    iceberg_qty = pending_iceberg_qty,
    strategy_type = pending_strategy_type,
    peg_price_type = pending_peg_price_type,
    peg_offset_type = pending_peg_offset_type,
    peg_offset_value = pending_peg_offset_value,
    prefix = "pending",
    allow_market = TRUE
  )
  .spot_validate_optional_resp_type(new_order_resp_type)

  .request_signed(
    config,
    "/api/v3/orderList/oto",
    params = list(
      symbol = symbol,
      listClientOrderId = list_client_order_id,
      newOrderRespType = new_order_resp_type,
      selfTradePreventionMode = self_trade_prevention_mode,
      workingType = working_type,
      workingSide = working_side,
      workingClientOrderId = working_client_order_id,
      workingPrice = working_price,
      workingQuantity = working_quantity,
      workingIcebergQty = working_iceberg_qty,
      workingTimeInForce = working_time_in_force,
      workingStrategyId = working_strategy_id,
      workingStrategyType = working_strategy_type,
      workingPegPriceType = working_peg_price_type,
      workingPegOffsetType = working_peg_offset_type,
      workingPegOffsetValue = working_peg_offset_value,
      pendingType = pending_type,
      pendingSide = pending_side,
      pendingClientOrderId = pending_client_order_id,
      pendingPrice = pending_price,
      pendingStopPrice = pending_stop_price,
      pendingTrailingDelta = pending_trailing_delta,
      pendingQuantity = pending_quantity,
      pendingIcebergQty = pending_iceberg_qty,
      pendingTimeInForce = pending_time_in_force,
      pendingStrategyId = pending_strategy_id,
      pendingStrategyType = pending_strategy_type,
      pendingPegPriceType = pending_peg_price_type,
      pendingPegOffsetType = pending_peg_offset_type,
      pendingPegOffsetValue = pending_peg_offset_value
    ),
    method = "POST"
  )
}

#' Place a Binance Spot OTOCO order list
#'
#' @inheritParams spot_place_order_list_oto
#' @param pending_side Shared side for the pending OCO legs.
#' @param pending_above_type Type for the pending-above leg.
#' @param pending_above_client_order_id Optional pending-above client ID.
#' @param pending_above_price Optional pending-above price.
#' @param pending_above_stop_price Optional pending-above stop price.
#' @param pending_above_trailing_delta Optional pending-above trailing delta.
#' @param pending_above_iceberg_qty Optional pending-above iceberg quantity.
#' @param pending_above_time_in_force Optional pending-above time-in-force.
#' @param pending_above_strategy_id Optional pending-above strategy ID.
#' @param pending_above_strategy_type Optional pending-above strategy type.
#' @param pending_above_peg_price_type Optional pending-above peg price type.
#' @param pending_above_peg_offset_type Optional pending-above peg offset type.
#' @param pending_above_peg_offset_value Optional pending-above peg offset value.
#' @param pending_below_type Type for the pending-below leg.
#' @param pending_below_client_order_id Optional pending-below client ID.
#' @param pending_below_price Optional pending-below price.
#' @param pending_below_stop_price Optional pending-below stop price.
#' @param pending_below_trailing_delta Optional pending-below trailing delta.
#' @param pending_below_iceberg_qty Optional pending-below iceberg quantity.
#' @param pending_below_time_in_force Optional pending-below time-in-force.
#' @param pending_below_strategy_id Optional pending-below strategy ID.
#' @param pending_below_strategy_type Optional pending-below strategy type.
#' @param pending_below_peg_price_type Optional pending-below peg price type.
#' @param pending_below_peg_offset_type Optional pending-below peg offset type.
#' @param pending_below_peg_offset_value Optional pending-below peg offset value.
#'
#' @return A parsed list.
#' @export
spot_place_order_list_otoco <- function(
    symbol,
    list_client_order_id = NULL,
    new_order_resp_type = NULL,
    self_trade_prevention_mode = NULL,
    working_type = c("LIMIT", "LIMIT_MAKER"),
    working_side = c("BUY", "SELL"),
    working_client_order_id = NULL,
    working_price,
    working_quantity,
    working_iceberg_qty = NULL,
    working_time_in_force = NULL,
    working_strategy_id = NULL,
    working_strategy_type = NULL,
    working_peg_price_type = NULL,
    working_peg_offset_type = NULL,
    working_peg_offset_value = NULL,
    pending_side = c("BUY", "SELL"),
    pending_quantity,
    pending_above_type = c("STOP_LOSS_LIMIT", "STOP_LOSS", "LIMIT_MAKER", "TAKE_PROFIT", "TAKE_PROFIT_LIMIT"),
    pending_above_client_order_id = NULL,
    pending_above_price = NULL,
    pending_above_stop_price = NULL,
    pending_above_trailing_delta = NULL,
    pending_above_iceberg_qty = NULL,
    pending_above_time_in_force = NULL,
    pending_above_strategy_id = NULL,
    pending_above_strategy_type = NULL,
    pending_above_peg_price_type = NULL,
    pending_above_peg_offset_type = NULL,
    pending_above_peg_offset_value = NULL,
    pending_below_type = c("STOP_LOSS", "STOP_LOSS_LIMIT", "TAKE_PROFIT", "TAKE_PROFIT_LIMIT"),
    pending_below_client_order_id = NULL,
    pending_below_price = NULL,
    pending_below_stop_price = NULL,
    pending_below_trailing_delta = NULL,
    pending_below_iceberg_qty = NULL,
    pending_below_time_in_force = NULL,
    pending_below_strategy_id = NULL,
    pending_below_strategy_type = NULL,
    pending_below_peg_price_type = NULL,
    pending_below_peg_offset_type = NULL,
    pending_below_peg_offset_value = NULL,
    config = config_spot()) {
  working_type <- match.arg(working_type)
  working_side <- match.arg(working_side)
  pending_side <- match.arg(pending_side)
  pending_above_type <- match.arg(pending_above_type)
  pending_below_type <- match.arg(pending_below_type)
  .validate_symbol(symbol)
  .validate_positive_number(working_price, "working_price")
  .validate_positive_number(working_quantity, "working_quantity")
  .validate_positive_number(pending_quantity, "pending_quantity")
  .spot_validate_working_order_list_leg(
    type = working_type,
    time_in_force = working_time_in_force,
    iceberg_qty = working_iceberg_qty,
    strategy_type = working_strategy_type,
    peg_price_type = working_peg_price_type,
    peg_offset_type = working_peg_offset_type,
    peg_offset_value = working_peg_offset_value,
    prefix = "working"
  )
  .spot_validate_order_list_leg(
    type = pending_above_type,
    price = pending_above_price,
    stop_price = pending_above_stop_price,
    trailing_delta = pending_above_trailing_delta,
    time_in_force = pending_above_time_in_force,
    iceberg_qty = pending_above_iceberg_qty,
    strategy_type = pending_above_strategy_type,
    peg_price_type = pending_above_peg_price_type,
    peg_offset_type = pending_above_peg_offset_type,
    peg_offset_value = pending_above_peg_offset_value,
    prefix = "pending_above"
  )
  .spot_validate_order_list_leg(
    type = pending_below_type,
    price = pending_below_price,
    stop_price = pending_below_stop_price,
    trailing_delta = pending_below_trailing_delta,
    time_in_force = pending_below_time_in_force,
    iceberg_qty = pending_below_iceberg_qty,
    strategy_type = pending_below_strategy_type,
    peg_price_type = pending_below_peg_price_type,
    peg_offset_type = pending_below_peg_offset_type,
    peg_offset_value = pending_below_peg_offset_value,
    prefix = "pending_below"
  )
  .spot_validate_optional_resp_type(new_order_resp_type)

  .request_signed(
    config,
    "/api/v3/orderList/otoco",
    params = list(
      symbol = symbol,
      listClientOrderId = list_client_order_id,
      newOrderRespType = new_order_resp_type,
      selfTradePreventionMode = self_trade_prevention_mode,
      workingType = working_type,
      workingSide = working_side,
      workingClientOrderId = working_client_order_id,
      workingPrice = working_price,
      workingQuantity = working_quantity,
      workingIcebergQty = working_iceberg_qty,
      workingTimeInForce = working_time_in_force,
      workingStrategyId = working_strategy_id,
      workingStrategyType = working_strategy_type,
      workingPegPriceType = working_peg_price_type,
      workingPegOffsetType = working_peg_offset_type,
      workingPegOffsetValue = working_peg_offset_value,
      pendingSide = pending_side,
      pendingQuantity = pending_quantity,
      pendingAboveType = pending_above_type,
      pendingAboveClientOrderId = pending_above_client_order_id,
      pendingAbovePrice = pending_above_price,
      pendingAboveStopPrice = pending_above_stop_price,
      pendingAboveTrailingDelta = pending_above_trailing_delta,
      pendingAboveIcebergQty = pending_above_iceberg_qty,
      pendingAboveTimeInForce = pending_above_time_in_force,
      pendingAboveStrategyId = pending_above_strategy_id,
      pendingAboveStrategyType = pending_above_strategy_type,
      pendingAbovePegPriceType = pending_above_peg_price_type,
      pendingAbovePegOffsetType = pending_above_peg_offset_type,
      pendingAbovePegOffsetValue = pending_above_peg_offset_value,
      pendingBelowType = pending_below_type,
      pendingBelowClientOrderId = pending_below_client_order_id,
      pendingBelowPrice = pending_below_price,
      pendingBelowStopPrice = pending_below_stop_price,
      pendingBelowTrailingDelta = pending_below_trailing_delta,
      pendingBelowIcebergQty = pending_below_iceberg_qty,
      pendingBelowTimeInForce = pending_below_time_in_force,
      pendingBelowStrategyId = pending_below_strategy_id,
      pendingBelowStrategyType = pending_below_strategy_type,
      pendingBelowPegPriceType = pending_below_peg_price_type,
      pendingBelowPegOffsetType = pending_below_peg_offset_type,
      pendingBelowPegOffsetValue = pending_below_peg_offset_value
    ),
    method = "POST"
  )
}

#' Cancel a Binance Spot order list
#'
#' @param symbol Trading pair symbol, for example `"BTCUSDT"`.
#' @param order_list_id Optional exchange order-list ID.
#' @param list_client_order_id Optional order-list client ID.
#' @param new_client_order_id Optional client order ID for the cancel request.
#' @param config A spot configuration created by [config_spot()].
#'
#' @return A parsed list.
#' @export
spot_cancel_order_list <- function(
    symbol,
    order_list_id = NULL,
    list_client_order_id = NULL,
    new_client_order_id = NULL,
    config = config_spot()) {
  .validate_symbol(symbol)
  .validate_required_any(order_list_id, list_client_order_id, arg_names = c("order_list_id", "list_client_order_id"))
  .validate_optional_scalar_numeric(order_list_id, "order_list_id")
  .validate_optional_scalar_character(list_client_order_id, "list_client_order_id")
  .validate_optional_scalar_character(new_client_order_id, "new_client_order_id")

  .request_signed(
    config,
    "/api/v3/orderList",
    params = list(
      symbol = symbol,
      orderListId = order_list_id,
      listClientOrderId = list_client_order_id,
      newClientOrderId = new_client_order_id
    ),
    method = "DELETE"
  )
}

#' Place a Binance Spot OPO order list
#'
#' @inheritParams spot_place_order_list_oto
#'
#' @return A parsed list.
#' @export
spot_place_order_list_opo <- function(
    symbol,
    list_client_order_id = NULL,
    new_order_resp_type = NULL,
    self_trade_prevention_mode = NULL,
    working_type = c("LIMIT", "LIMIT_MAKER"),
    working_side = c("BUY", "SELL"),
    working_client_order_id = NULL,
    working_price,
    working_quantity,
    working_iceberg_qty = NULL,
    working_time_in_force = NULL,
    working_strategy_id = NULL,
    working_strategy_type = NULL,
    working_peg_price_type = NULL,
    working_peg_offset_type = NULL,
    working_peg_offset_value = NULL,
    pending_type = c("LIMIT", "MARKET", "STOP_LOSS", "STOP_LOSS_LIMIT", "TAKE_PROFIT", "TAKE_PROFIT_LIMIT", "LIMIT_MAKER"),
    pending_side = c("BUY", "SELL"),
    pending_client_order_id = NULL,
    pending_price = NULL,
    pending_stop_price = NULL,
    pending_trailing_delta = NULL,
    pending_iceberg_qty = NULL,
    pending_time_in_force = NULL,
    pending_strategy_id = NULL,
    pending_strategy_type = NULL,
    pending_peg_price_type = NULL,
    pending_peg_offset_type = NULL,
    pending_peg_offset_value = NULL,
    config = config_spot()) {
  working_type <- match.arg(working_type)
  working_side <- match.arg(working_side)
  pending_type <- match.arg(pending_type)
  pending_side <- match.arg(pending_side)
  .validate_symbol(symbol)
  .validate_positive_number(working_price, "working_price")
  .validate_positive_number(working_quantity, "working_quantity")
  .spot_validate_working_order_list_leg(
    type = working_type,
    time_in_force = working_time_in_force,
    iceberg_qty = working_iceberg_qty,
    strategy_type = working_strategy_type,
    peg_price_type = working_peg_price_type,
    peg_offset_type = working_peg_offset_type,
    peg_offset_value = working_peg_offset_value,
    prefix = "working"
  )
  .spot_validate_order_list_leg(
    type = pending_type,
    price = pending_price,
    stop_price = pending_stop_price,
    trailing_delta = pending_trailing_delta,
    time_in_force = pending_time_in_force,
    iceberg_qty = pending_iceberg_qty,
    strategy_type = pending_strategy_type,
    peg_price_type = pending_peg_price_type,
    peg_offset_type = pending_peg_offset_type,
    peg_offset_value = pending_peg_offset_value,
    prefix = "pending",
    allow_market = TRUE
  )
  .spot_validate_optional_resp_type(new_order_resp_type)

  .request_signed(
    config,
    "/api/v3/orderList/opo",
    params = list(
      symbol = symbol,
      listClientOrderId = list_client_order_id,
      newOrderRespType = new_order_resp_type,
      selfTradePreventionMode = self_trade_prevention_mode,
      workingType = working_type,
      workingSide = working_side,
      workingClientOrderId = working_client_order_id,
      workingPrice = working_price,
      workingQuantity = working_quantity,
      workingIcebergQty = working_iceberg_qty,
      workingTimeInForce = working_time_in_force,
      workingStrategyId = working_strategy_id,
      workingStrategyType = working_strategy_type,
      workingPegPriceType = working_peg_price_type,
      workingPegOffsetType = working_peg_offset_type,
      workingPegOffsetValue = working_peg_offset_value,
      pendingType = pending_type,
      pendingSide = pending_side,
      pendingClientOrderId = pending_client_order_id,
      pendingPrice = pending_price,
      pendingStopPrice = pending_stop_price,
      pendingTrailingDelta = pending_trailing_delta,
      pendingIcebergQty = pending_iceberg_qty,
      pendingTimeInForce = pending_time_in_force,
      pendingStrategyId = pending_strategy_id,
      pendingStrategyType = pending_strategy_type,
      pendingPegPriceType = pending_peg_price_type,
      pendingPegOffsetType = pending_peg_offset_type,
      pendingPegOffsetValue = pending_peg_offset_value
    ),
    method = "POST"
  )
}

#' Place a Binance Spot OPOCO order list
#'
#' @inheritParams spot_place_order_list_otoco
#'
#' @return A parsed list.
#' @export
spot_place_order_list_opoco <- function(
    symbol,
    list_client_order_id = NULL,
    new_order_resp_type = NULL,
    self_trade_prevention_mode = NULL,
    working_type = c("LIMIT", "LIMIT_MAKER"),
    working_side = c("BUY", "SELL"),
    working_client_order_id = NULL,
    working_price,
    working_quantity,
    working_iceberg_qty = NULL,
    working_time_in_force = NULL,
    working_strategy_id = NULL,
    working_strategy_type = NULL,
    working_peg_price_type = NULL,
    working_peg_offset_type = NULL,
    working_peg_offset_value = NULL,
    pending_side = c("BUY", "SELL"),
    pending_above_type = c("STOP_LOSS_LIMIT", "STOP_LOSS", "LIMIT_MAKER", "TAKE_PROFIT", "TAKE_PROFIT_LIMIT"),
    pending_above_client_order_id = NULL,
    pending_above_price = NULL,
    pending_above_stop_price = NULL,
    pending_above_trailing_delta = NULL,
    pending_above_iceberg_qty = NULL,
    pending_above_time_in_force = NULL,
    pending_above_strategy_id = NULL,
    pending_above_strategy_type = NULL,
    pending_above_peg_price_type = NULL,
    pending_above_peg_offset_type = NULL,
    pending_above_peg_offset_value = NULL,
    pending_below_type = c("STOP_LOSS", "STOP_LOSS_LIMIT", "TAKE_PROFIT", "TAKE_PROFIT_LIMIT"),
    pending_below_client_order_id = NULL,
    pending_below_price = NULL,
    pending_below_stop_price = NULL,
    pending_below_trailing_delta = NULL,
    pending_below_iceberg_qty = NULL,
    pending_below_time_in_force = NULL,
    pending_below_strategy_id = NULL,
    pending_below_strategy_type = NULL,
    pending_below_peg_price_type = NULL,
    pending_below_peg_offset_type = NULL,
    pending_below_peg_offset_value = NULL,
    config = config_spot()) {
  working_type <- match.arg(working_type)
  working_side <- match.arg(working_side)
  pending_side <- match.arg(pending_side)
  pending_above_type <- match.arg(pending_above_type)
  pending_below_type <- match.arg(pending_below_type)
  .validate_symbol(symbol)
  .validate_positive_number(working_price, "working_price")
  .validate_positive_number(working_quantity, "working_quantity")
  .spot_validate_working_order_list_leg(
    type = working_type,
    time_in_force = working_time_in_force,
    iceberg_qty = working_iceberg_qty,
    strategy_type = working_strategy_type,
    peg_price_type = working_peg_price_type,
    peg_offset_type = working_peg_offset_type,
    peg_offset_value = working_peg_offset_value,
    prefix = "working"
  )
  .spot_validate_order_list_leg(
    type = pending_above_type,
    price = pending_above_price,
    stop_price = pending_above_stop_price,
    trailing_delta = pending_above_trailing_delta,
    time_in_force = pending_above_time_in_force,
    iceberg_qty = pending_above_iceberg_qty,
    strategy_type = pending_above_strategy_type,
    peg_price_type = pending_above_peg_price_type,
    peg_offset_type = pending_above_peg_offset_type,
    peg_offset_value = pending_above_peg_offset_value,
    prefix = "pending_above"
  )
  .spot_validate_order_list_leg(
    type = pending_below_type,
    price = pending_below_price,
    stop_price = pending_below_stop_price,
    trailing_delta = pending_below_trailing_delta,
    time_in_force = pending_below_time_in_force,
    iceberg_qty = pending_below_iceberg_qty,
    strategy_type = pending_below_strategy_type,
    peg_price_type = pending_below_peg_price_type,
    peg_offset_type = pending_below_peg_offset_type,
    peg_offset_value = pending_below_peg_offset_value,
    prefix = "pending_below"
  )
  .spot_validate_optional_resp_type(new_order_resp_type)

  .request_signed(
    config,
    "/api/v3/orderList/opoco",
    params = list(
      symbol = symbol,
      listClientOrderId = list_client_order_id,
      newOrderRespType = new_order_resp_type,
      selfTradePreventionMode = self_trade_prevention_mode,
      workingType = working_type,
      workingSide = working_side,
      workingClientOrderId = working_client_order_id,
      workingPrice = working_price,
      workingQuantity = working_quantity,
      workingIcebergQty = working_iceberg_qty,
      workingTimeInForce = working_time_in_force,
      workingStrategyId = working_strategy_id,
      workingStrategyType = working_strategy_type,
      workingPegPriceType = working_peg_price_type,
      workingPegOffsetType = working_peg_offset_type,
      workingPegOffsetValue = working_peg_offset_value,
      pendingSide = pending_side,
      pendingAboveType = pending_above_type,
      pendingAboveClientOrderId = pending_above_client_order_id,
      pendingAbovePrice = pending_above_price,
      pendingAboveStopPrice = pending_above_stop_price,
      pendingAboveTrailingDelta = pending_above_trailing_delta,
      pendingAboveIcebergQty = pending_above_iceberg_qty,
      pendingAboveTimeInForce = pending_above_time_in_force,
      pendingAboveStrategyId = pending_above_strategy_id,
      pendingAboveStrategyType = pending_above_strategy_type,
      pendingAbovePegPriceType = pending_above_peg_price_type,
      pendingAbovePegOffsetType = pending_above_peg_offset_type,
      pendingAbovePegOffsetValue = pending_above_peg_offset_value,
      pendingBelowType = pending_below_type,
      pendingBelowClientOrderId = pending_below_client_order_id,
      pendingBelowPrice = pending_below_price,
      pendingBelowStopPrice = pending_below_stop_price,
      pendingBelowTrailingDelta = pending_below_trailing_delta,
      pendingBelowIcebergQty = pending_below_iceberg_qty,
      pendingBelowTimeInForce = pending_below_time_in_force,
      pendingBelowStrategyId = pending_below_strategy_id,
      pendingBelowStrategyType = pending_below_strategy_type,
      pendingBelowPegPriceType = pending_below_peg_price_type,
      pendingBelowPegOffsetType = pending_below_peg_offset_type,
      pendingBelowPegOffsetValue = pending_below_peg_offset_value
    ),
    method = "POST"
  )
}

#' Place a Binance Spot SOR order
#'
#' @param symbol Trading pair symbol, for example `"BTCUSDT"`.
#' @param side One of `"BUY"` or `"SELL"`.
#' @param type SOR order type. One of `"LIMIT"` or `"MARKET"`.
#' @param quantity Order quantity.
#' @param time_in_force Optional time-in-force value.
#' @param price Optional limit price.
#' @param new_client_order_id Optional client order identifier.
#' @param strategy_id Optional numeric strategy identifier.
#' @param strategy_type Optional numeric strategy type. Must be at least `1000000`.
#' @param iceberg_qty Optional iceberg quantity.
#' @param new_order_resp_type Optional response type. One of `"ACK"`, `"RESULT"`, or `"FULL"`.
#' @param self_trade_prevention_mode Optional self-trade prevention mode.
#' @param config A spot configuration created by [config_spot()].
#'
#' @return A parsed list.
#' @export
spot_place_sor_order <- function(
    symbol,
    side = c("BUY", "SELL"),
    type = c("LIMIT", "MARKET"),
    quantity,
    time_in_force = NULL,
    price = NULL,
    new_client_order_id = NULL,
    strategy_id = NULL,
    strategy_type = NULL,
    iceberg_qty = NULL,
    new_order_resp_type = NULL,
    self_trade_prevention_mode = NULL,
    config = config_spot()) {
  side <- match.arg(side)
  type <- match.arg(type)
  .validate_symbol(symbol)
  .validate_positive_number(quantity, "quantity")
  .validate_optional_scalar_character(time_in_force, "time_in_force")
  .validate_optional_scalar_numeric(price, "price")
  .validate_optional_scalar_character(new_client_order_id, "new_client_order_id")
  .validate_optional_scalar_numeric(strategy_id, "strategy_id")
  .validate_optional_scalar_numeric(strategy_type, "strategy_type")
  .validate_optional_scalar_numeric(iceberg_qty, "iceberg_qty")
  .validate_optional_scalar_character(new_order_resp_type, "new_order_resp_type")
  .validate_optional_scalar_character(self_trade_prevention_mode, "self_trade_prevention_mode")

  .spot_validate_sor_order_request(
    type = type,
    time_in_force = time_in_force,
    price = price,
    strategy_type = strategy_type,
    iceberg_qty = iceberg_qty,
    new_order_resp_type = new_order_resp_type
  )

  .request_signed(
    config,
    "/api/v3/sor/order",
    params = list(
      symbol = symbol,
      side = side,
      type = type,
      quantity = quantity,
      timeInForce = time_in_force,
      price = price,
      newClientOrderId = new_client_order_id,
      strategyId = strategy_id,
      strategyType = strategy_type,
      icebergQty = iceberg_qty,
      newOrderRespType = new_order_resp_type,
      selfTradePreventionMode = self_trade_prevention_mode
    ),
    method = "POST"
  )
}

#' Test a Binance Spot SOR order
#'
#' @inheritParams spot_place_sor_order
#' @param compute_commission_rates Whether to return commission-rate details.
#'
#' @return A parsed list.
#' @export
spot_test_sor_order <- function(
    symbol,
    side = c("BUY", "SELL"),
    type = c("LIMIT", "MARKET"),
    quantity,
    time_in_force = NULL,
    price = NULL,
    new_client_order_id = NULL,
    strategy_id = NULL,
    strategy_type = NULL,
    iceberg_qty = NULL,
    new_order_resp_type = NULL,
    self_trade_prevention_mode = NULL,
    compute_commission_rates = FALSE,
    config = config_spot()) {
  .validate_scalar_logical(compute_commission_rates, "compute_commission_rates")

  side <- match.arg(side)
  type <- match.arg(type)
  .validate_symbol(symbol)
  .validate_positive_number(quantity, "quantity")
  .validate_optional_scalar_character(time_in_force, "time_in_force")
  .validate_optional_scalar_numeric(price, "price")
  .validate_optional_scalar_character(new_client_order_id, "new_client_order_id")
  .validate_optional_scalar_numeric(strategy_id, "strategy_id")
  .validate_optional_scalar_numeric(strategy_type, "strategy_type")
  .validate_optional_scalar_numeric(iceberg_qty, "iceberg_qty")
  .validate_optional_scalar_character(new_order_resp_type, "new_order_resp_type")
  .validate_optional_scalar_character(self_trade_prevention_mode, "self_trade_prevention_mode")

  .spot_validate_sor_order_request(
    type = type,
    time_in_force = time_in_force,
    price = price,
    strategy_type = strategy_type,
    iceberg_qty = iceberg_qty,
    new_order_resp_type = new_order_resp_type
  )

  .request_signed(
    config,
    "/api/v3/sor/order/test",
    params = list(
      symbol = symbol,
      side = side,
      type = type,
      quantity = quantity,
      timeInForce = time_in_force,
      price = price,
      newClientOrderId = new_client_order_id,
      strategyId = strategy_id,
      strategyType = strategy_type,
      icebergQty = iceberg_qty,
      newOrderRespType = new_order_resp_type,
      selfTradePreventionMode = self_trade_prevention_mode,
      computeCommissionRates = if (isTRUE(compute_commission_rates)) "true" else "false"
    ),
    method = "POST"
  )
}

#' @noRd
.spot_validate_order_request <- function(
    type,
    time_in_force,
    quantity,
    quote_order_qty,
    price,
    strategy_type,
    stop_price,
    trailing_delta,
    iceberg_qty,
    new_order_resp_type,
    peg_price_type,
    peg_offset_value,
    peg_offset_type) {
  if (!is.null(quantity) && quantity <= 0) {
    stop("`quantity` must be positive when provided.", call. = FALSE)
  }
  if (!is.null(quote_order_qty) && quote_order_qty <= 0) {
    stop("`quote_order_qty` must be positive when provided.", call. = FALSE)
  }
  if (!is.null(price) && price <= 0) {
    stop("`price` must be positive when provided.", call. = FALSE)
  }
  if (!is.null(stop_price) && stop_price <= 0) {
    stop("`stop_price` must be positive when provided.", call. = FALSE)
  }
  if (!is.null(trailing_delta) && trailing_delta <= 0) {
    stop("`trailing_delta` must be positive when provided.", call. = FALSE)
  }
  if (!is.null(iceberg_qty) && iceberg_qty <= 0) {
    stop("`iceberg_qty` must be positive when provided.", call. = FALSE)
  }
  if (!is.null(strategy_type) && strategy_type < 1000000) {
    stop("`strategy_type` must be at least 1000000 when provided.", call. = FALSE)
  }

  if (!is.null(new_order_resp_type)) {
    .validate_one_of(new_order_resp_type, c("ACK", "RESULT", "FULL"), "new_order_resp_type")
  }

  if (!is.null(time_in_force)) {
    .validate_one_of(time_in_force, c("GTC", "IOC", "FOK"), "time_in_force")
  }

  peg_allowed_types <- c("LIMIT", "LIMIT_MAKER", "STOP_LOSS_LIMIT", "TAKE_PROFIT_LIMIT")
  if (!is.null(peg_price_type)) {
    .validate_one_of(peg_price_type, c("PRIMARY_PEG", "MARKET_PEG"), "peg_price_type")
    if (!(type %in% peg_allowed_types)) {
      stop(
        "`peg_price_type` must only be supplied for LIMIT, LIMIT_MAKER, STOP_LOSS_LIMIT, or TAKE_PROFIT_LIMIT orders.",
        call. = FALSE
      )
    }
  }
  if (!is.null(peg_offset_type)) {
    .validate_one_of(peg_offset_type, c("PRICE_LEVEL"), "peg_offset_type")
  }
  if (xor(is.null(peg_offset_type), is.null(peg_offset_value))) {
    stop("`peg_offset_type` and `peg_offset_value` must be supplied together.", call. = FALSE)
  }
  if (!is.null(peg_offset_value) && (peg_offset_value <= 0 || peg_offset_value != as.integer(peg_offset_value))) {
    stop("`peg_offset_value` must be a positive whole number when provided.", call. = FALSE)
  }
  if (!is.null(peg_offset_value) && is.null(peg_price_type)) {
    stop("`peg_offset_type` and `peg_offset_value` require `peg_price_type`.", call. = FALSE)
  }

  if (!is.null(iceberg_qty)) {
    iceberg_allowed_types <- c("LIMIT", "LIMIT_MAKER", "STOP_LOSS_LIMIT", "TAKE_PROFIT_LIMIT")
    if (!(type %in% iceberg_allowed_types)) {
      stop(
        "`iceberg_qty` must only be supplied for LIMIT, LIMIT_MAKER, STOP_LOSS_LIMIT, or TAKE_PROFIT_LIMIT orders.",
        call. = FALSE
      )
    }
    if (is.null(time_in_force) || !identical(time_in_force, "GTC")) {
      stop("`iceberg_qty` requires `time_in_force = \"GTC\"`.", call. = FALSE)
    }
  }

  if (identical(type, "MARKET")) {
    .validate_required_any(quantity, quote_order_qty, arg_names = c("quantity", "quote_order_qty"))
    .validate_at_most_one(quantity, quote_order_qty, arg_names = c("quantity", "quote_order_qty"))
    if (!is.null(time_in_force)) {
      stop("`time_in_force` must not be supplied for MARKET orders.", call. = FALSE)
    }
    if (!is.null(price)) {
      stop("`price` must not be supplied for MARKET orders.", call. = FALSE)
    }
  }

  price_required <- type %in% c("LIMIT", "LIMIT_MAKER", "STOP_LOSS_LIMIT", "TAKE_PROFIT_LIMIT") && is.null(peg_price_type)
  if (isTRUE(price_required) && is.null(price)) {
    stop(sprintf("`price` is required when `type = \"%s\"` unless `peg_price_type` is supplied.", type), call. = FALSE)
  }

  if (identical(type, "LIMIT")) {
    if (is.null(quantity)) {
      stop("`quantity` is required when `type = \"LIMIT\"`.", call. = FALSE)
    }
    if (is.null(time_in_force)) {
      stop("`time_in_force` is required when `type = \"LIMIT\"`.", call. = FALSE)
    }
    if (!is.null(quote_order_qty)) {
      stop("`quote_order_qty` must not be supplied when `type = \"LIMIT\"`.", call. = FALSE)
    }
    return(invisible(TRUE))
  }

  if (identical(type, "LIMIT_MAKER")) {
    if (is.null(quantity)) {
      stop("`quantity` is required when `type = \"LIMIT_MAKER\"`.", call. = FALSE)
    }
    if (!is.null(time_in_force)) {
      stop("`time_in_force` must not be supplied when `type = \"LIMIT_MAKER\"`.", call. = FALSE)
    }
    if (!is.null(quote_order_qty)) {
      stop("`quote_order_qty` must not be supplied when `type = \"LIMIT_MAKER\"`.", call. = FALSE)
    }
    if (!is.null(stop_price) || !is.null(trailing_delta)) {
      stop("`stop_price` and `trailing_delta` must not be supplied when `type = \"LIMIT_MAKER\"`.", call. = FALSE)
    }
    return(invisible(TRUE))
  }

  if (type %in% c("STOP_LOSS", "TAKE_PROFIT")) {
    if (is.null(quantity)) {
      stop(sprintf("`quantity` is required when `type = \"%s\"`.", type), call. = FALSE)
    }
    .validate_required_any(stop_price, trailing_delta, arg_names = c("stop_price", "trailing_delta"))
    if (!is.null(price)) {
      stop(sprintf("`price` must not be supplied when `type = \"%s\"`.", type), call. = FALSE)
    }
    if (!is.null(time_in_force)) {
      stop(sprintf("`time_in_force` must not be supplied when `type = \"%s\"`.", type), call. = FALSE)
    }
    if (!is.null(quote_order_qty)) {
      stop(sprintf("`quote_order_qty` must not be supplied when `type = \"%s\"`.", type), call. = FALSE)
    }
    return(invisible(TRUE))
  }

  if (type %in% c("STOP_LOSS_LIMIT", "TAKE_PROFIT_LIMIT")) {
    if (is.null(quantity)) {
      stop(sprintf("`quantity` is required when `type = \"%s\"`.", type), call. = FALSE)
    }
    if (is.null(time_in_force)) {
      stop(sprintf("`time_in_force` is required when `type = \"%s\"`.", type), call. = FALSE)
    }
    .validate_required_any(stop_price, trailing_delta, arg_names = c("stop_price", "trailing_delta"))
    if (!is.null(quote_order_qty)) {
      stop(sprintf("`quote_order_qty` must not be supplied when `type = \"%s\"`.", type), call. = FALSE)
    }
    return(invisible(TRUE))
  }

  invisible(TRUE)
}

#' @noRd
.spot_validate_strategy_type <- function(x, arg) {
  if (is.null(x)) {
    return(invisible(x))
  }
  if (x < 1000000) {
    stop(sprintf("`%s` must be at least 1000000 when provided.", arg), call. = FALSE)
  }
  invisible(x)
}

#' @noRd
.spot_validate_positive_optional <- function(x, arg) {
  if (is.null(x)) {
    return(invisible(x))
  }
  if (!is.numeric(x) || length(x) != 1L || is.na(x) || x <= 0) {
    stop(sprintf("`%s` must be positive when provided.", arg), call. = FALSE)
  }
  invisible(x)
}

#' @noRd
.spot_validate_optional_resp_type <- function(x) {
  if (is.null(x)) {
    return(invisible(x))
  }
  .validate_one_of(x, c("ACK", "RESULT", "FULL"), "new_order_resp_type")
}

#' @noRd
.spot_validate_optional_tif <- function(x, arg) {
  if (is.null(x)) {
    return(invisible(x))
  }
  .validate_one_of(x, c("GTC", "IOC", "FOK"), arg)
}

#' @noRd
.spot_validate_peg_fields <- function(peg_price_type, peg_offset_type, peg_offset_value, prefix, allowed_types, type) {
  peg_price_arg <- paste0(prefix, "_peg_price_type")
  peg_offset_type_arg <- paste0(prefix, "_peg_offset_type")
  peg_offset_value_arg <- paste0(prefix, "_peg_offset_value")
  if (!is.null(peg_price_type)) {
    .validate_one_of(peg_price_type, c("PRIMARY_PEG", "MARKET_PEG"), peg_price_arg)
    if (!(type %in% allowed_types)) {
      stop(
        sprintf("`%s` must only be supplied for supported pegged order types.", peg_price_arg),
        call. = FALSE
      )
    }
  }
  if (!is.null(peg_offset_type)) {
    .validate_one_of(peg_offset_type, c("PRICE_LEVEL"), peg_offset_type_arg)
  }
  if (xor(is.null(peg_offset_type), is.null(peg_offset_value))) {
    stop(sprintf("`%s` and `%s` must be supplied together.", peg_offset_type_arg, peg_offset_value_arg), call. = FALSE)
  }
  if (!is.null(peg_offset_value)) {
    if (!is.numeric(peg_offset_value) || length(peg_offset_value) != 1L || is.na(peg_offset_value) ||
        peg_offset_value <= 0 || peg_offset_value != as.integer(peg_offset_value)) {
      stop(sprintf("`%s` must be a positive whole number when provided.", peg_offset_value_arg), call. = FALSE)
    }
    if (is.null(peg_price_type)) {
      stop(sprintf("`%s` requires `%s`.", peg_offset_value_arg, peg_price_arg), call. = FALSE)
    }
  }
  invisible(TRUE)
}

#' @noRd
.spot_validate_order_list_leg <- function(
    type,
    price,
    stop_price,
    trailing_delta,
    time_in_force,
    iceberg_qty,
    strategy_type,
    peg_price_type,
    peg_offset_type,
    peg_offset_value,
    prefix,
    allow_market = FALSE) {
  allowed_types <- c("STOP_LOSS", "STOP_LOSS_LIMIT", "LIMIT_MAKER", "TAKE_PROFIT", "TAKE_PROFIT_LIMIT")
  if (isTRUE(allow_market)) {
    allowed_types <- c("LIMIT", "MARKET", allowed_types)
  }
  if (!(type %in% allowed_types)) {
    stop(sprintf("Unsupported `%s_type` value `%s`.", prefix, type), call. = FALSE)
  }

  .validate_optional_scalar_numeric(price, paste0(prefix, "_price"))
  .validate_optional_scalar_numeric(stop_price, paste0(prefix, "_stop_price"))
  .validate_optional_scalar_numeric(trailing_delta, paste0(prefix, "_trailing_delta"))
  .validate_optional_scalar_character(time_in_force, paste0(prefix, "_time_in_force"))
  .validate_optional_scalar_numeric(iceberg_qty, paste0(prefix, "_iceberg_qty"))
  .spot_validate_strategy_type(strategy_type, paste0(prefix, "_strategy_type"))
  .spot_validate_positive_optional(price, paste0(prefix, "_price"))
  .spot_validate_positive_optional(stop_price, paste0(prefix, "_stop_price"))
  .spot_validate_positive_optional(trailing_delta, paste0(prefix, "_trailing_delta"))
  .spot_validate_positive_optional(iceberg_qty, paste0(prefix, "_iceberg_qty"))
  .spot_validate_optional_tif(time_in_force, paste0(prefix, "_time_in_force"))

  .spot_validate_peg_fields(
    peg_price_type = peg_price_type,
    peg_offset_type = peg_offset_type,
    peg_offset_value = peg_offset_value,
    prefix = prefix,
    allowed_types = c("LIMIT_MAKER", "STOP_LOSS_LIMIT", "TAKE_PROFIT_LIMIT"),
    type = type
  )

  if (identical(type, "LIMIT")) {
    if (is.null(price)) {
      stop(sprintf("`%s_price` is required when `%s_type = \"LIMIT\"`.", prefix, prefix), call. = FALSE)
    }
    if (is.null(time_in_force)) {
      stop(sprintf("`%s_time_in_force` is required when `%s_type = \"LIMIT\"`.", prefix, prefix), call. = FALSE)
    }
  }

  if (identical(type, "MARKET")) {
    if (!is.null(price)) {
      stop(sprintf("`%s_price` must not be supplied when `%s_type = \"MARKET\"`.", prefix, prefix), call. = FALSE)
    }
    if (!is.null(time_in_force)) {
      stop(sprintf("`%s_time_in_force` must not be supplied when `%s_type = \"MARKET\"`.", prefix, prefix), call. = FALSE)
    }
  }

  if (type %in% c("STOP_LOSS", "TAKE_PROFIT")) {
    .validate_required_any(stop_price, trailing_delta, arg_names = c(paste0(prefix, "_stop_price"), paste0(prefix, "_trailing_delta")))
    if (!is.null(price)) {
      stop(sprintf("`%s_price` must not be supplied when `%s_type = \"%s\"`.", prefix, prefix, type), call. = FALSE)
    }
    if (!is.null(time_in_force)) {
      stop(sprintf("`%s_time_in_force` must not be supplied when `%s_type = \"%s\"`.", prefix, prefix, type), call. = FALSE)
    }
  }

  if (type %in% c("STOP_LOSS_LIMIT", "TAKE_PROFIT_LIMIT")) {
    if (is.null(price)) {
      stop(sprintf("`%s_price` is required when `%s_type = \"%s\"`.", prefix, prefix, type), call. = FALSE)
    }
    .validate_required_any(stop_price, trailing_delta, arg_names = c(paste0(prefix, "_stop_price"), paste0(prefix, "_trailing_delta")))
    if (is.null(time_in_force)) {
      stop(sprintf("`%s_time_in_force` is required when `%s_type = \"%s\"`.", prefix, prefix, type), call. = FALSE)
    }
  }

  if (identical(type, "LIMIT_MAKER") && is.null(price)) {
    stop(sprintf("`%s_price` is required when `%s_type = \"LIMIT_MAKER\"`.", prefix, prefix), call. = FALSE)
  }

  if (!is.null(iceberg_qty)) {
    if (!(type %in% c("LIMIT_MAKER", "STOP_LOSS_LIMIT", "TAKE_PROFIT_LIMIT", "LIMIT"))) {
      stop(sprintf("`%s_iceberg_qty` is not supported for `%s_type = \"%s\"`.", prefix, prefix, type), call. = FALSE)
    }
    if (!identical(time_in_force, "GTC") && !identical(type, "LIMIT_MAKER")) {
      stop(sprintf("`%s_iceberg_qty` requires `%s_time_in_force = \"GTC\"`.", prefix, prefix), call. = FALSE)
    }
  }

  invisible(TRUE)
}

#' @noRd
.spot_validate_working_order_list_leg <- function(
    type,
    time_in_force,
    iceberg_qty,
    strategy_type,
    peg_price_type,
    peg_offset_type,
    peg_offset_value,
    prefix) {
  .spot_validate_strategy_type(strategy_type, paste0(prefix, "_strategy_type"))
  .spot_validate_positive_optional(iceberg_qty, paste0(prefix, "_iceberg_qty"))
  .spot_validate_optional_tif(time_in_force, paste0(prefix, "_time_in_force"))
  .spot_validate_peg_fields(
    peg_price_type = peg_price_type,
    peg_offset_type = peg_offset_type,
    peg_offset_value = peg_offset_value,
    prefix = prefix,
    allowed_types = c("LIMIT", "LIMIT_MAKER"),
    type = type
  )

  if (identical(type, "LIMIT") && is.null(time_in_force)) {
    stop(sprintf("`%s_time_in_force` is required when `%s_type = \"LIMIT\"`.", prefix, prefix), call. = FALSE)
  }
  if (!is.null(iceberg_qty) && !identical(time_in_force, "GTC") && !identical(type, "LIMIT_MAKER")) {
    stop(sprintf("`%s_iceberg_qty` requires `%s_time_in_force = \"GTC\"`.", prefix, prefix), call. = FALSE)
  }
  invisible(TRUE)
}

#' @noRd
.spot_validate_sor_order_request <- function(
    type,
    time_in_force,
    price,
    strategy_type,
    iceberg_qty,
    new_order_resp_type) {
  if (!is.null(strategy_type) && strategy_type < 1000000) {
    stop("`strategy_type` must be at least 1000000 when provided.", call. = FALSE)
  }
  .spot_validate_optional_resp_type(new_order_resp_type)

  if (identical(type, "LIMIT")) {
    if (is.null(price)) {
      stop("`price` is required when `type = \"LIMIT\"`.", call. = FALSE)
    }
    if (is.null(time_in_force)) {
      stop("`time_in_force` is required when `type = \"LIMIT\"`.", call. = FALSE)
    }
    .validate_one_of(time_in_force, c("GTC", "IOC", "FOK"), "time_in_force")
  } else {
    if (!is.null(time_in_force)) {
      stop("`time_in_force` must not be supplied when `type = \"MARKET\"`.", call. = FALSE)
    }
    if (!is.null(price)) {
      stop("`price` must not be supplied when `type = \"MARKET\"`.", call. = FALSE)
    }
  }

  if (!is.null(iceberg_qty)) {
    if (iceberg_qty <= 0) {
      stop("`iceberg_qty` must be positive when provided.", call. = FALSE)
    }
    if (!identical(type, "LIMIT")) {
      stop("`iceberg_qty` must only be supplied when `type = \"LIMIT\"`.", call. = FALSE)
    }
    if (!identical(time_in_force, "GTC")) {
      stop("`iceberg_qty` requires `time_in_force = \"GTC\"`.", call. = FALSE)
    }
  }

  invisible(TRUE)
}
