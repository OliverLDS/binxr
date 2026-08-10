#' Place a Binance Options block trade order
#'
#' This endpoint is intended for eligible Options market-maker accounts. Binance
#' currently supports one leg per block trade order.
#'
#' @param legs A single-element list of block-order leg parameters using Binance
#'   REST names, such as `symbol`, `side`, `type`, `quantity`, and `price`.
#' @param liquidity One of `"MAKER"` or `"TAKER"`.
#' @param config An options configuration created by [config_options()].
#'
#' @return A parsed list.
#' @export
options_place_block_trade_order <- function(
    legs,
    liquidity = c("MAKER", "TAKER"),
    config = config_options()) {
  .options_validate_block_trade_legs(legs)
  liquidity <- match.arg(liquidity)
  .request_signed(
    config,
    "/eapi/v1/block/order/create",
    params = list(
      liquidity = liquidity,
      legs = as.character(jsonlite::toJSON(legs, auto_unbox = TRUE))
    ),
    method = "POST"
  )
}

#' Extend a Binance Options block trade order
#'
#' Extends the block-order expiry by 30 minutes from the current time.
#'
#' @param block_order_matching_key Block trade matching key.
#' @param config An options configuration created by [config_options()].
#'
#' @return A parsed list.
#' @export
options_extend_block_trade_order <- function(block_order_matching_key, config = config_options()) {
  .validate_scalar_character(block_order_matching_key, "block_order_matching_key")
  .request_signed(
    config,
    "/eapi/v1/block/order/create",
    params = list(blockOrderMatchingKey = block_order_matching_key),
    method = "PUT"
  )
}

#' Cancel a Binance Options block trade order
#'
#' @param block_order_matching_key Block trade matching key.
#' @param config An options configuration created by [config_options()].
#'
#' @return A parsed list.
#' @export
options_cancel_block_trade_order <- function(block_order_matching_key, config = config_options()) {
  .validate_scalar_character(block_order_matching_key, "block_order_matching_key")
  .request_signed(
    config,
    "/eapi/v1/block/order/create",
    params = list(blockOrderMatchingKey = block_order_matching_key),
    method = "DELETE"
  )
}

#' Get Binance Options block trade orders
#'
#' This endpoint is intended for eligible Options market-maker accounts.
#'
#' @param block_order_matching_key Optional block trade matching key.
#' @param underlying Optional underlying symbol, for example `"BTCUSDT"`.
#' @param startTime Optional start time in milliseconds since Unix epoch.
#' @param endTime Optional end time in milliseconds since Unix epoch.
#' @param json_list If `TRUE`, return the parsed list instead of a `data.table`.
#' @param config An options configuration created by [config_options()].
#'
#' @return A `data.table` by default, or a parsed list when `json_list = TRUE`.
#' @export
options_get_block_trade_orders <- function(
    block_order_matching_key = NULL,
    underlying = NULL,
    startTime = NULL,
    endTime = NULL,
    json_list = FALSE,
    config = config_options()) {
  .validate_optional_scalar_character(block_order_matching_key, "block_order_matching_key")
  if (!is.null(underlying)) .validate_symbol(underlying, "underlying")
  .validate_optional_scalar_numeric(startTime, "startTime")
  .validate_optional_scalar_numeric(endTime, "endTime")
  .validate_json_list_flag(json_list)
  payload <- .request_signed(
    config,
    "/eapi/v1/block/order/orders",
    params = list(
      blockOrderMatchingKey = block_order_matching_key,
      underlying = underlying,
      startTime = startTime,
      endTime = endTime
    ),
    method = "GET"
  )
  .maybe_as_dt(payload, json_list)
}

#' Accept a Binance Options block trade order
#'
#' @param block_order_matching_key Block trade matching key.
#' @param config An options configuration created by [config_options()].
#'
#' @return A parsed list.
#' @export
options_accept_block_trade_order <- function(block_order_matching_key, config = config_options()) {
  .validate_scalar_character(block_order_matching_key, "block_order_matching_key")
  .request_signed(
    config,
    "/eapi/v1/block/order/execute",
    params = list(blockOrderMatchingKey = block_order_matching_key),
    method = "POST"
  )
}

#' Get Binance Options block trade details
#'
#' @param block_order_matching_key Block trade matching key.
#' @param config An options configuration created by [config_options()].
#'
#' @return A parsed list.
#' @export
options_get_block_trade_details <- function(block_order_matching_key, config = config_options()) {
  .validate_scalar_character(block_order_matching_key, "block_order_matching_key")
  .request_signed(
    config,
    "/eapi/v1/block/order/execute",
    params = list(blockOrderMatchingKey = block_order_matching_key),
    method = "GET"
  )
}

#' Get Binance Options account block trades
#'
#' This endpoint is intended for eligible Options market-maker accounts.
#'
#' @param underlying Optional underlying symbol, for example `"BTCUSDT"`.
#' @param startTime Optional start time in milliseconds since Unix epoch.
#' @param endTime Optional end time in milliseconds since Unix epoch.
#' @param json_list If `TRUE`, return the parsed list instead of a `data.table`.
#' @param config An options configuration created by [config_options()].
#'
#' @return A `data.table` by default, or a parsed list when `json_list = TRUE`.
#' @export
options_get_account_block_trades <- function(
    underlying = NULL,
    startTime = NULL,
    endTime = NULL,
    json_list = FALSE,
    config = config_options()) {
  if (!is.null(underlying)) .validate_symbol(underlying, "underlying")
  .validate_optional_scalar_numeric(startTime, "startTime")
  .validate_optional_scalar_numeric(endTime, "endTime")
  .validate_json_list_flag(json_list)
  payload <- .request_signed(
    config,
    "/eapi/v1/block/user-trades",
    params = list(underlying = underlying, startTime = startTime, endTime = endTime),
    method = "GET"
  )
  .maybe_as_dt(payload, json_list)
}

#' Get Binance Options market maker protection configuration
#'
#' This endpoint is available only to eligible Options market-maker accounts.
#'
#' @param underlying Underlying symbol, for example `"BTCUSDT"`.
#' @param config An options configuration created by [config_options()].
#'
#' @return A parsed list.
#' @export
options_get_market_maker_protection <- function(underlying, config = config_options()) {
  .validate_symbol(underlying, "underlying")
  .request_signed(config, "/eapi/v1/mmp", params = list(underlying = underlying), method = "GET")
}

#' Set Binance Options market maker protection configuration
#'
#' This endpoint is available only to eligible Options market-maker accounts.
#'
#' @param underlying Underlying symbol, for example `"BTCUSDT"`.
#' @param window_time_ms MMP evaluation interval in milliseconds.
#' @param frozen_time_ms MMP freeze time in milliseconds. Set to `0` to require
#'   a manual reset after MMP triggers.
#' @param quantity_limit Maximum quantity within an MMP interval.
#' @param delta_limit Maximum net delta within an MMP interval.
#' @param config An options configuration created by [config_options()].
#'
#' @return A parsed list.
#' @export
options_set_market_maker_protection <- function(
    underlying,
    window_time_ms,
    frozen_time_ms,
    quantity_limit,
    delta_limit,
    config = config_options()) {
  .validate_symbol(underlying, "underlying")
  .validate_positive_integerish(window_time_ms, "window_time_ms")
  .options_validate_nonnegative_number(frozen_time_ms, "frozen_time_ms")
  .validate_positive_number(quantity_limit, "quantity_limit")
  .validate_positive_number(delta_limit, "delta_limit")
  .request_signed(
    config,
    "/eapi/v1/mmpSet",
    params = list(
      underlying = underlying,
      windowTimeInMilliseconds = window_time_ms,
      frozenTimeInMilliseconds = frozen_time_ms,
      qtyLimit = quantity_limit,
      deltaLimit = delta_limit
    ),
    method = "POST"
  )
}

#' Reset Binance Options market maker protection
#'
#' This endpoint is available only to eligible Options market-maker accounts.
#'
#' @param underlying Underlying symbol, for example `"BTCUSDT"`.
#' @param config An options configuration created by [config_options()].
#'
#' @return A parsed list.
#' @export
options_reset_market_maker_protection <- function(underlying, config = config_options()) {
  .validate_symbol(underlying, "underlying")
  .request_signed(config, "/eapi/v1/mmpReset", params = list(underlying = underlying), method = "POST")
}

#' @noRd
.options_validate_block_trade_legs <- function(legs) {
  if (!is.list(legs) || length(legs) != 1L || !is.list(legs[[1L]])) {
    stop("`legs` must be a single-element list containing one block-order leg.", call. = FALSE)
  }
  invisible(legs)
}

#' @noRd
.options_validate_nonnegative_number <- function(x, arg) {
  if (!is.numeric(x) || length(x) != 1L || is.na(x) || x < 0) {
    stop(sprintf("`%s` must be a non-negative number.", arg), call. = FALSE)
  }
  invisible(x)
}
