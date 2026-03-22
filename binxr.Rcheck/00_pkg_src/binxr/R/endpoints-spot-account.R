#' Get Binance Spot account information
#'
#' @param omit_zero_balances Whether to omit zero balances from the response.
#' @param config A spot configuration created by [config_spot()].
#'
#' @return A parsed list.
#' @export
spot_get_account <- function(omit_zero_balances = FALSE, config = config_spot()) {
  .validate_scalar_logical(omit_zero_balances, "omit_zero_balances")

  .request_signed(
    config,
    "/api/v3/account",
    params = list(omitZeroBalances = if (isTRUE(omit_zero_balances)) "true" else "false"),
    method = "GET"
  )
}

#' Get a Binance Spot order
#'
#' @param symbol Trading pair symbol, for example `"BTCUSDT"`.
#' @param order_id Optional exchange order ID.
#' @param orig_client_order_id Optional client order ID.
#' @param config A spot configuration created by [config_spot()].
#'
#' @return A parsed list.
#' @export
spot_get_order <- function(
    symbol,
    order_id = NULL,
    orig_client_order_id = NULL,
    config = config_spot()) {
  .validate_symbol(symbol)
  .validate_required_any(order_id, orig_client_order_id, arg_names = c("order_id", "orig_client_order_id"))
  .validate_optional_scalar_numeric(order_id, "order_id")
  .validate_optional_scalar_character(orig_client_order_id, "orig_client_order_id")

  .request_signed(
    config,
    "/api/v3/order",
    params = list(
      symbol = symbol,
      orderId = order_id,
      origClientOrderId = orig_client_order_id
    ),
    method = "GET"
  )
}

#' Get Binance Spot open orders
#'
#' @param symbol Optional trading pair symbol. If `NULL`, returns all open
#'   orders.
#' @param json_list If `TRUE`, return the parsed list instead of a `data.table`.
#' @param config A spot configuration created by [config_spot()].
#'
#' @return A `data.table` by default, or a parsed list when `json_list = TRUE`.
#' @export
spot_get_open_orders <- function(symbol = NULL, json_list = FALSE, config = config_spot()) {
  if (!is.null(symbol)) {
    .validate_symbol(symbol)
  }
  .validate_json_list_flag(json_list)

  payload <- .request_signed(
    config,
    "/api/v3/openOrders",
    params = list(symbol = symbol),
    method = "GET"
  )
  if (isTRUE(json_list)) {
    return(payload)
  }

  .spot_as_orders_dt(payload)
}

#' Get Binance Spot order history
#'
#' @param symbol Trading pair symbol, for example `"BTCUSDT"`.
#' @param order_id Optional exchange order ID to start from.
#' @param start_time Optional start time in milliseconds.
#' @param end_time Optional end time in milliseconds.
#' @param limit Maximum number of orders to return. Must not exceed `1000`.
#' @param json_list If `TRUE`, return the parsed list instead of a `data.table`.
#' @param config A spot configuration created by [config_spot()].
#'
#' @return A `data.table` by default, or a parsed list when `json_list = TRUE`.
#' @export
spot_get_orders <- function(
    symbol,
    order_id = NULL,
    start_time = NULL,
    end_time = NULL,
    limit = 500,
    json_list = FALSE,
    config = config_spot()) {
  .validate_symbol(symbol)
  .validate_optional_scalar_numeric(order_id, "order_id")
  .validate_optional_scalar_numeric(start_time, "start_time")
  .validate_optional_scalar_numeric(end_time, "end_time")
  .spot_validate_limit(limit)
  .validate_json_list_flag(json_list)
  .spot_validate_time_range_24h(start_time, end_time)

  payload <- .request_signed(
    config,
    "/api/v3/allOrders",
    params = list(
      symbol = symbol,
      orderId = order_id,
      startTime = start_time,
      endTime = end_time,
      limit = limit
    ),
    method = "GET"
  )
  if (isTRUE(json_list)) {
    return(payload)
  }

  .spot_as_orders_dt(payload)
}

#' Get a Binance Spot order list
#'
#' @param order_list_id Optional exchange order-list ID.
#' @param orig_client_order_id Optional order-list client ID.
#' @param config A spot configuration created by [config_spot()].
#'
#' @return A parsed list.
#' @export
spot_get_order_list <- function(
    order_list_id = NULL,
    orig_client_order_id = NULL,
    config = config_spot()) {
  .validate_required_any(order_list_id, orig_client_order_id, arg_names = c("order_list_id", "orig_client_order_id"))
  .validate_optional_scalar_numeric(order_list_id, "order_list_id")
  .validate_optional_scalar_character(orig_client_order_id, "orig_client_order_id")

  .request_signed(
    config,
    "/api/v3/orderList",
    params = list(
      orderListId = order_list_id,
      origClientOrderId = orig_client_order_id
    ),
    method = "GET"
  )
}

#' Get all Binance Spot order lists
#'
#' @param from_id Optional order-list ID to start from.
#' @param start_time Optional start time in milliseconds.
#' @param end_time Optional end time in milliseconds.
#' @param limit Maximum number of order lists to return. Must not exceed
#'   `1000`.
#' @param json_list If `TRUE`, return the parsed list instead of a `data.table`.
#' @param config A spot configuration created by [config_spot()].
#'
#' @return A `data.table` by default, or a parsed list when `json_list = TRUE`.
#' @export
spot_get_all_order_lists <- function(
    from_id = NULL,
    start_time = NULL,
    end_time = NULL,
    limit = 500,
    json_list = FALSE,
    config = config_spot()) {
  .validate_optional_scalar_numeric(from_id, "from_id")
  .validate_optional_scalar_numeric(start_time, "start_time")
  .validate_optional_scalar_numeric(end_time, "end_time")
  .spot_validate_limit(limit)
  .validate_json_list_flag(json_list)

  if (!is.null(from_id) && (!is.null(start_time) || !is.null(end_time))) {
    stop("`from_id` must not be supplied with `start_time` or `end_time`.", call. = FALSE)
  }
  .spot_validate_time_range_24h(start_time, end_time)

  payload <- .request_signed(
    config,
    "/api/v3/allOrderList",
    params = list(
      fromId = from_id,
      startTime = start_time,
      endTime = end_time,
      limit = limit
    ),
    method = "GET"
  )
  if (isTRUE(json_list)) {
    return(payload)
  }

  .spot_as_order_lists_dt(payload)
}

#' Get Binance Spot open order lists
#'
#' @param json_list If `TRUE`, return the parsed list instead of a `data.table`.
#' @param config A spot configuration created by [config_spot()].
#'
#' @return A `data.table` by default, or a parsed list when `json_list = TRUE`.
#' @export
spot_get_open_order_lists <- function(json_list = FALSE, config = config_spot()) {
  .validate_json_list_flag(json_list)

  payload <- .request_signed(
    config,
    "/api/v3/openOrderList",
    params = list(),
    method = "GET"
  )
  if (isTRUE(json_list)) {
    return(payload)
  }

  .spot_as_order_lists_dt(payload)
}

#' Get Binance Spot account trades
#'
#' @param symbol Trading pair symbol, for example `"BTCUSDT"`.
#' @param order_id Optional exchange order ID.
#' @param start_time Optional start time in milliseconds.
#' @param end_time Optional end time in milliseconds.
#' @param from_id Optional trade ID to start from.
#' @param limit Maximum number of trades to return. Must not exceed `1000`.
#' @param json_list If `TRUE`, return the parsed list instead of a `data.table`.
#' @param config A spot configuration created by [config_spot()].
#'
#' @return A `data.table` by default, or a parsed list when `json_list = TRUE`.
#' @export
spot_get_account_trades <- function(
    symbol,
    order_id = NULL,
    start_time = NULL,
    end_time = NULL,
    from_id = NULL,
    limit = 500,
    json_list = FALSE,
    config = config_spot()) {
  .validate_symbol(symbol)
  .validate_optional_scalar_numeric(order_id, "order_id")
  .validate_optional_scalar_numeric(start_time, "start_time")
  .validate_optional_scalar_numeric(end_time, "end_time")
  .validate_optional_scalar_numeric(from_id, "from_id")
  .spot_validate_limit(limit)
  .validate_json_list_flag(json_list)

  if (!is.null(order_id) && (!is.null(start_time) || !is.null(end_time))) {
    stop("`order_id` must not be supplied with `start_time` or `end_time`.", call. = FALSE)
  }
  if (!is.null(from_id) && (!is.null(start_time) || !is.null(end_time))) {
    stop("`from_id` must not be supplied with `start_time` or `end_time`.", call. = FALSE)
  }
  .spot_validate_time_range_24h(start_time, end_time)

  payload <- .request_signed(
    config,
    "/api/v3/myTrades",
    params = list(
      symbol = symbol,
      orderId = order_id,
      startTime = start_time,
      endTime = end_time,
      fromId = from_id,
      limit = limit
    ),
    method = "GET"
  )
  if (isTRUE(json_list)) {
    return(payload)
  }

  .spot_as_trades_dt(payload)
}

#' Get Binance Spot unfilled order counts
#'
#' @param json_list If `TRUE`, return the parsed list instead of a `data.table`.
#' @param config A spot configuration created by [config_spot()].
#'
#' @return A `data.table` by default, or a parsed list when `json_list = TRUE`.
#' @export
spot_get_unfilled_order_count <- function(json_list = FALSE, config = config_spot()) {
  .validate_json_list_flag(json_list)

  payload <- .request_signed(
    config,
    "/api/v3/rateLimit/order",
    params = list(),
    method = "GET"
  )
  if (isTRUE(json_list)) {
    return(payload)
  }

  counts_dt <- .maybe_as_dt(payload)
  .coerce_numeric_cols(counts_dt, c("intervalNum", "limit", "count"))
}

#' Get Binance Spot prevented matches
#'
#' @param symbol Trading pair symbol, for example `"BTCUSDT"`.
#' @param prevented_match_id Optional prevented-match ID.
#' @param order_id Optional exchange order ID.
#' @param from_prevented_match_id Optional prevented-match ID to start from.
#' @param limit Maximum number of records to return. Must not exceed `1000`.
#' @param json_list If `TRUE`, return the parsed list instead of a `data.table`.
#' @param config A spot configuration created by [config_spot()].
#'
#' @return A `data.table` by default, or a parsed list when `json_list = TRUE`.
#' @export
spot_get_prevented_matches <- function(
    symbol,
    prevented_match_id = NULL,
    order_id = NULL,
    from_prevented_match_id = NULL,
    limit = 500,
    json_list = FALSE,
    config = config_spot()) {
  .validate_symbol(symbol)
  .validate_optional_scalar_numeric(prevented_match_id, "prevented_match_id")
  .validate_optional_scalar_numeric(order_id, "order_id")
  .validate_optional_scalar_numeric(from_prevented_match_id, "from_prevented_match_id")
  .spot_validate_limit(limit)
  .validate_json_list_flag(json_list)

  .validate_required_any(prevented_match_id, order_id, arg_names = c("prevented_match_id", "order_id"))
  .validate_at_most_one(prevented_match_id, order_id, arg_names = c("prevented_match_id", "order_id"))
  if (!is.null(from_prevented_match_id) && is.null(order_id)) {
    stop("`from_prevented_match_id` requires `order_id`.", call. = FALSE)
  }
  if (!is.null(from_prevented_match_id) && !is.null(prevented_match_id)) {
    stop("`from_prevented_match_id` must not be supplied with `prevented_match_id`.", call. = FALSE)
  }

  payload <- .request_signed(
    config,
    "/api/v3/myPreventedMatches",
    params = list(
      symbol = symbol,
      preventedMatchId = prevented_match_id,
      orderId = order_id,
      fromPreventedMatchId = from_prevented_match_id,
      limit = limit
    ),
    method = "GET"
  )
  if (isTRUE(json_list)) {
    return(payload)
  }

  matches_dt <- .maybe_as_dt(payload)
  matches_dt <- .coerce_numeric_cols(
    matches_dt,
    c("preventedMatchId", "takerOrderId", "makerOrderId", "tradeGroupId", "price", "makerPreventedQuantity")
  )
  .normalize_time_cols(matches_dt, "transactTime")
}

#' Get Binance Spot allocations
#'
#' @param symbol Trading pair symbol, for example `"BTCUSDT"`.
#' @param start_time Optional start time in milliseconds.
#' @param end_time Optional end time in milliseconds.
#' @param from_allocation_id Optional allocation ID to start from.
#' @param limit Maximum number of records to return. Must not exceed `1000`.
#' @param order_id Optional exchange order ID.
#' @param json_list If `TRUE`, return the parsed list instead of a `data.table`.
#' @param config A spot configuration created by [config_spot()].
#'
#' @return A `data.table` by default, or a parsed list when `json_list = TRUE`.
#' @export
spot_get_allocations <- function(
    symbol,
    start_time = NULL,
    end_time = NULL,
    from_allocation_id = NULL,
    limit = 500,
    order_id = NULL,
    json_list = FALSE,
    config = config_spot()) {
  .validate_symbol(symbol)
  .validate_optional_scalar_numeric(start_time, "start_time")
  .validate_optional_scalar_numeric(end_time, "end_time")
  .validate_optional_scalar_numeric(from_allocation_id, "from_allocation_id")
  .spot_validate_limit(limit)
  .validate_optional_scalar_numeric(order_id, "order_id")
  .validate_json_list_flag(json_list)

  if (!is.null(from_allocation_id) && (!is.null(start_time) || !is.null(end_time))) {
    stop("`from_allocation_id` must not be supplied with `start_time` or `end_time`.", call. = FALSE)
  }
  if (!is.null(order_id) && (!is.null(start_time) || !is.null(end_time))) {
    stop("`order_id` must not be supplied with `start_time` or `end_time`.", call. = FALSE)
  }
  .spot_validate_time_range_24h(start_time, end_time)

  payload <- .request_signed(
    config,
    "/api/v3/myAllocations",
    params = list(
      symbol = symbol,
      startTime = start_time,
      endTime = end_time,
      fromAllocationId = from_allocation_id,
      limit = limit,
      orderId = order_id
    ),
    method = "GET"
  )
  if (isTRUE(json_list)) {
    return(payload)
  }

  allocations_dt <- .maybe_as_dt(payload)
  allocations_dt <- .coerce_numeric_cols(
    allocations_dt,
    c("allocationId", "orderId", "orderListId", "price", "qty", "quoteQty", "commission")
  )
  .normalize_time_cols(allocations_dt, "time")
}

#' Get Binance Spot commission rates
#'
#' @param symbol Trading pair symbol, for example `"BTCUSDT"`.
#' @param config A spot configuration created by [config_spot()].
#'
#' @return A parsed list.
#' @export
spot_get_commission_rates <- function(symbol, config = config_spot()) {
  .validate_symbol(symbol)

  .request_signed(
    config,
    "/api/v3/account/commission",
    params = list(symbol = symbol),
    method = "GET"
  )
}

#' Get Binance Spot order amendments
#'
#' @param symbol Trading pair symbol, for example `"BTCUSDT"`.
#' @param order_id Exchange order ID.
#' @param from_execution_id Optional execution ID to start from.
#' @param limit Maximum number of records to return. Must not exceed `1000`.
#' @param json_list If `TRUE`, return the parsed list instead of a `data.table`.
#' @param config A spot configuration created by [config_spot()].
#'
#' @return A `data.table` by default, or a parsed list when `json_list = TRUE`.
#' @export
spot_get_order_amendments <- function(
    symbol,
    order_id,
    from_execution_id = NULL,
    limit = 500,
    json_list = FALSE,
    config = config_spot()) {
  .validate_symbol(symbol)
  .validate_optional_scalar_numeric(from_execution_id, "from_execution_id")
  .spot_validate_limit(limit)
  .validate_json_list_flag(json_list)
  .validate_optional_scalar_numeric(order_id, "order_id")
  if (is.null(order_id)) {
    stop("`order_id` must be supplied.", call. = FALSE)
  }

  payload <- .request_signed(
    config,
    "/api/v3/order/amendments",
    params = list(
      symbol = symbol,
      orderId = order_id,
      fromExecutionId = from_execution_id,
      limit = limit
    ),
    method = "GET"
  )
  if (isTRUE(json_list)) {
    return(payload)
  }

  amendments_dt <- .maybe_as_dt(payload)
  amendments_dt <- .coerce_numeric_cols(
    amendments_dt,
    c("orderId", "executionId", "origQty", "newQty")
  )
  .normalize_time_cols(amendments_dt, "time")
}

#' Get Binance Spot relevant account filters
#'
#' @param symbol Trading pair symbol, for example `"BTCUSDT"`.
#' @param config A spot configuration created by [config_spot()].
#'
#' @return A parsed list.
#' @export
spot_get_relevant_filters <- function(symbol, config = config_spot()) {
  .validate_symbol(symbol)

  .request_signed(
    config,
    "/api/v3/myFilters",
    params = list(symbol = symbol),
    method = "GET"
  )
}

#' @noRd
.spot_validate_limit <- function(limit, max = 1000L, arg = "limit") {
  .validate_positive_integerish(limit, arg)
  if (limit > max) {
    stop(sprintf("`%s` must be less than or equal to %d.", arg, max), call. = FALSE)
  }
  invisible(limit)
}

#' @noRd
.spot_validate_time_range_24h <- function(start_time, end_time) {
  if (is.null(start_time) || is.null(end_time)) {
    return(invisible(TRUE))
  }
  if (end_time < start_time) {
    stop("`end_time` must be greater than or equal to `start_time`.", call. = FALSE)
  }
  if ((end_time - start_time) > 24 * 60 * 60 * 1000) {
    stop("The time between `start_time` and `end_time` must not exceed 24 hours.", call. = FALSE)
  }
  invisible(TRUE)
}

#' @noRd
.spot_as_orders_dt <- function(payload) {
  orders_dt <- .maybe_as_dt(payload)
  orders_dt <- .coerce_numeric_cols(
    orders_dt,
    c(
      "orderId", "orderListId", "price", "origQty", "executedQty",
      "cummulativeQuoteQty", "stopPrice", "icebergQty", "origQuoteOrderQty"
    )
  )
  .normalize_order_time_cols(orders_dt)
}

#' @noRd
.spot_as_order_lists_dt <- function(payload) {
  lists_dt <- .maybe_as_dt(payload)
  lists_dt <- .coerce_numeric_cols(lists_dt, c("orderListId"))
  .normalize_time_cols(lists_dt, "transactionTime")
}

#' @noRd
.spot_as_trades_dt <- function(payload) {
  trades_dt <- .maybe_as_dt(payload)
  trades_dt <- .coerce_numeric_cols(
    trades_dt,
    c("id", "orderId", "orderListId", "price", "qty", "quoteQty", "commission")
  )
  .normalize_time_cols(trades_dt, "time")
}
