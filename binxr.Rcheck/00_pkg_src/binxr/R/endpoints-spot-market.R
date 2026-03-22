#' Get Binance Spot order book
#'
#' @param symbol Trading pair symbol, for example `"BTCUSDT"`.
#' @param limit Optional order book depth limit.
#' @param symbol_status Optional trading status filter.
#' @param config A spot configuration created by [config_spot()].
#'
#' @return A parsed list.
#' @export
spot_get_order_book <- function(symbol, limit = NULL, symbol_status = NULL, config = config_spot()) {
  .validate_symbol(symbol)
  .validate_optional_scalar_numeric(limit, "limit")
  .validate_optional_scalar_character(symbol_status, "symbol_status")

  .request_public(
    config,
    "/api/v3/depth",
    query = list(
      symbol = symbol,
      limit = limit,
      symbolStatus = symbol_status
    )
  )
}

#' Get Binance Spot recent trades
#'
#' @param symbol Trading pair symbol, for example `"BTCUSDT"`.
#' @param limit Maximum number of rows to return.
#' @param json_list If `TRUE`, return the parsed list instead of a `data.table`.
#' @param config A spot configuration created by [config_spot()].
#'
#' @return A `data.table` by default, or a parsed list when `json_list = TRUE`.
#' @export
spot_get_recent_trades <- function(symbol, limit = 500, json_list = FALSE, config = config_spot()) {
  .validate_symbol(symbol)
  .validate_positive_integerish(limit, "limit")

  payload <- .request_public(
    config,
    "/api/v3/trades",
    query = list(
      symbol = symbol,
      limit = limit
    )
  )

  .spot_market_maybe_tabular(payload, json_list = json_list)
}

#' Get Binance Spot historical trades
#'
#' @param symbol Trading pair symbol, for example `"BTCUSDT"`.
#' @param limit Maximum number of rows to return.
#' @param fromId Optional trade identifier to fetch from.
#' @param json_list If `TRUE`, return the parsed list instead of a `data.table`.
#' @param config A spot configuration created by [config_spot()].
#'
#' @return A `data.table` by default, or a parsed list when `json_list = TRUE`.
#' @export
spot_get_historical_trades <- function(
    symbol,
    limit = 500,
    fromId = NULL,
    json_list = FALSE,
    config = config_spot()) {
  .validate_symbol(symbol)
  .validate_positive_integerish(limit, "limit")
  .validate_optional_scalar_numeric(fromId, "fromId")

  payload <- .request_public(
    config,
    "/api/v3/historicalTrades",
    query = list(
      symbol = symbol,
      limit = limit,
      fromId = fromId
    )
  )

  .spot_market_maybe_tabular(payload, json_list = json_list)
}

#' Get Binance Spot aggregate trades
#'
#' @param symbol Trading pair symbol, for example `"BTCUSDT"`.
#' @param fromId Optional aggregate trade identifier to fetch from, inclusive.
#' @param startTime Optional start time in milliseconds since Unix epoch, inclusive.
#' @param endTime Optional end time in milliseconds since Unix epoch, inclusive.
#' @param limit Maximum number of rows to return.
#' @param json_list If `TRUE`, return the parsed list instead of a `data.table`.
#' @param config A spot configuration created by [config_spot()].
#'
#' @return A `data.table` by default, or a parsed list when `json_list = TRUE`.
#' @export
spot_get_aggregate_trades <- function(
    symbol,
    fromId = NULL,
    startTime = NULL,
    endTime = NULL,
    limit = 500,
    json_list = FALSE,
    config = config_spot()) {
  .validate_symbol(symbol)
  .validate_optional_scalar_numeric(fromId, "fromId")
  .validate_optional_scalar_numeric(startTime, "startTime")
  .validate_optional_scalar_numeric(endTime, "endTime")
  .validate_positive_integerish(limit, "limit")

  payload <- .request_public(
    config,
    "/api/v3/aggTrades",
    query = list(
      symbol = symbol,
      fromId = fromId,
      startTime = startTime,
      endTime = endTime,
      limit = limit
    )
  )

  .spot_market_maybe_tabular(payload, json_list = json_list)
}

#' Get Binance Spot klines
#'
#' @param symbol Trading pair symbol, for example `"BTCUSDT"`.
#' @param interval Kline interval string.
#' @param startTime Optional start time in milliseconds since Unix epoch.
#' @param endTime Optional end time in milliseconds since Unix epoch.
#' @param timeZone Optional timezone string accepted by Binance.
#' @param limit Maximum number of rows to return.
#' @param json_list If `TRUE`, return the parsed list instead of a `data.table`.
#' @param config A spot configuration created by [config_spot()].
#'
#' @return A `data.table` by default, or a parsed list when `json_list = TRUE`.
#' @export
spot_get_klines <- function(
    symbol,
    interval,
    startTime = NULL,
    endTime = NULL,
    timeZone = NULL,
    limit = 500,
    json_list = FALSE,
    config = config_spot()) {
  .validate_symbol(symbol)
  .validate_scalar_character(interval, "interval")
  .validate_optional_scalar_numeric(startTime, "startTime")
  .validate_optional_scalar_numeric(endTime, "endTime")
  .validate_optional_scalar_character(timeZone, "timeZone")
  .validate_positive_integerish(limit, "limit")

  payload <- .request_public(
    config,
    "/api/v3/klines",
    query = list(
      symbol = symbol,
      interval = interval,
      startTime = startTime,
      endTime = endTime,
      timeZone = timeZone,
      limit = limit
    )
  )

  if (isTRUE(json_list)) {
    return(payload)
  }

  .spot_klines_to_dt(payload)
}

#' Get Binance Spot UI klines
#'
#' @inheritParams spot_get_klines
#'
#' @return A `data.table` by default, or a parsed list when `json_list = TRUE`.
#' @export
spot_get_ui_klines <- function(
    symbol,
    interval,
    startTime = NULL,
    endTime = NULL,
    timeZone = NULL,
    limit = 500,
    json_list = FALSE,
    config = config_spot()) {
  .validate_symbol(symbol)
  .validate_scalar_character(interval, "interval")
  .validate_optional_scalar_numeric(startTime, "startTime")
  .validate_optional_scalar_numeric(endTime, "endTime")
  .validate_optional_scalar_character(timeZone, "timeZone")
  .validate_positive_integerish(limit, "limit")

  payload <- .request_public(
    config,
    "/api/v3/uiKlines",
    query = list(
      symbol = symbol,
      interval = interval,
      startTime = startTime,
      endTime = endTime,
      timeZone = timeZone,
      limit = limit
    )
  )

  if (isTRUE(json_list)) {
    return(payload)
  }

  .spot_klines_to_dt(payload)
}

#' Get Binance Spot average price
#'
#' @param symbol Trading pair symbol, for example `"BTCUSDT"`.
#' @param config A spot configuration created by [config_spot()].
#'
#' @return A parsed list.
#' @export
spot_get_average_price <- function(symbol, config = config_spot()) {
  .validate_symbol(symbol)
  .request_public(config, "/api/v3/avgPrice", query = list(symbol = symbol))
}

#' Get Binance Spot 24-hour ticker statistics
#'
#' @param symbol Optional trading pair symbol.
#' @param symbols Optional character vector of trading pair symbols.
#' @param type One of `"FULL"` or `"MINI"`.
#' @param symbol_status Optional trading status filter.
#' @param json_list If `TRUE`, return the parsed list instead of converting
#'   array responses to `data.table`.
#' @param config A spot configuration created by [config_spot()].
#'
#' @return A parsed list for single-symbol requests, or a `data.table` for
#'   multi-symbol/all-symbol requests unless `json_list = TRUE`.
#' @export
spot_get_24hr_ticker <- function(
    symbol = NULL,
    symbols = NULL,
    type = c("FULL", "MINI"),
    symbol_status = NULL,
    json_list = FALSE,
    config = config_spot()) {
  type <- match.arg(type)
  query <- .spot_symbol_selector_query(
    symbol = symbol,
    symbols = symbols,
    symbol_status = symbol_status
  )
  payload <- .request_public(
    config,
    "/api/v3/ticker/24hr",
    query = c(query, list(type = type))
  )
  .spot_market_maybe_tabular(payload, json_list = json_list)
}

#' Get Binance Spot trading day ticker statistics
#'
#' @param symbol Optional trading pair symbol.
#' @param symbols Optional character vector of trading pair symbols.
#' @param timeZone Optional timezone string accepted by Binance.
#' @param type One of `"FULL"` or `"MINI"`.
#' @param symbol_status Optional trading status filter.
#' @param json_list If `TRUE`, return the parsed list instead of converting
#'   array responses to `data.table`.
#' @param config A spot configuration created by [config_spot()].
#'
#' @return A parsed list for single-symbol requests, or a `data.table` for
#'   multi-symbol requests unless `json_list = TRUE`.
#' @export
spot_get_trading_day_ticker <- function(
    symbol = NULL,
    symbols = NULL,
    timeZone = NULL,
    type = c("FULL", "MINI"),
    symbol_status = NULL,
    json_list = FALSE,
    config = config_spot()) {
  type <- match.arg(type)
  .validate_optional_scalar_character(timeZone, "timeZone")
  query <- .spot_symbol_selector_query(
    symbol = symbol,
    symbols = symbols,
    symbol_status = symbol_status,
    require_any = TRUE
  )
  payload <- .request_public(
    config,
    "/api/v3/ticker/tradingDay",
    query = c(
      query,
      list(
        timeZone = timeZone,
        type = type
      )
    )
  )
  .spot_market_maybe_tabular(payload, json_list = json_list)
}

#' Get Binance Spot rolling window ticker statistics
#'
#' @param symbol Optional trading pair symbol.
#' @param symbols Optional character vector of trading pair symbols.
#' @param windowSize Optional rolling window size such as `"1m"`, `"4h"`, or `"7d"`.
#' @param type One of `"FULL"` or `"MINI"`.
#' @param symbol_status Optional trading status filter.
#' @param json_list If `TRUE`, return the parsed list instead of converting
#'   array responses to `data.table`.
#' @param config A spot configuration created by [config_spot()].
#'
#' @return A parsed list for single-symbol requests, or a `data.table` for
#'   multi-symbol requests unless `json_list = TRUE`.
#' @export
spot_get_rolling_window_ticker <- function(
    symbol = NULL,
    symbols = NULL,
    windowSize = NULL,
    type = c("FULL", "MINI"),
    symbol_status = NULL,
    json_list = FALSE,
    config = config_spot()) {
  type <- match.arg(type)
  .validate_optional_window_size(windowSize, "windowSize")
  query <- .spot_symbol_selector_query(
    symbol = symbol,
    symbols = symbols,
    symbol_status = symbol_status,
    require_any = TRUE
  )
  payload <- .request_public(
    config,
    "/api/v3/ticker",
    query = c(
      query,
      list(
        windowSize = windowSize,
        type = type
      )
    )
  )
  .spot_market_maybe_tabular(payload, json_list = json_list)
}

#' Get Binance Spot ticker price
#'
#' @param symbol Optional trading pair symbol.
#' @param symbols Optional character vector of trading pair symbols.
#' @param symbol_status Optional trading status filter.
#' @param json_list If `TRUE`, return the parsed list instead of converting
#'   array responses to `data.table`.
#' @param config A spot configuration created by [config_spot()].
#'
#' @return A parsed list for single-symbol requests, or a `data.table` for
#'   multi-symbol/all-symbol requests unless `json_list = TRUE`.
#' @export
spot_get_ticker_price <- function(
    symbol = NULL,
    symbols = NULL,
    symbol_status = NULL,
    json_list = FALSE,
    config = config_spot()) {
  query <- .spot_symbol_selector_query(
    symbol = symbol,
    symbols = symbols,
    symbol_status = symbol_status
  )
  payload <- .request_public(config, "/api/v3/ticker/price", query = query)
  .spot_market_maybe_tabular(payload, json_list = json_list)
}

#' @rdname spot_get_ticker_price
#' @export
get_spot_mark_price <- function(symbol = NULL, config = binxr_config_spot()) {
  .binxr_deprecate_alias("get_spot_mark_price", "spot_get_ticker_price")
  spot_get_ticker_price(symbol = symbol, config = config)
}

#' Get Binance Spot book ticker
#'
#' @param symbol Optional trading pair symbol.
#' @param symbols Optional character vector of trading pair symbols.
#' @param symbol_status Optional trading status filter.
#' @param json_list If `TRUE`, return the parsed list instead of converting
#'   array responses to `data.table`.
#' @param config A spot configuration created by [config_spot()].
#'
#' @return A parsed list for single-symbol requests, or a `data.table` for
#'   multi-symbol/all-symbol requests unless `json_list = TRUE`.
#' @export
spot_get_book_ticker <- function(
    symbol = NULL,
    symbols = NULL,
    symbol_status = NULL,
    json_list = FALSE,
    config = config_spot()) {
  query <- .spot_symbol_selector_query(
    symbol = symbol,
    symbols = symbols,
    symbol_status = symbol_status
  )
  payload <- .request_public(config, "/api/v3/ticker/bookTicker", query = query)
  .spot_market_maybe_tabular(payload, json_list = json_list)
}

#' Get Binance Spot reference price
#'
#' @param symbol Trading pair symbol, for example `"BTCUSDT"`.
#' @param config A spot configuration created by [config_spot()].
#'
#' @return A parsed list.
#' @export
spot_get_reference_price <- function(symbol, config = config_spot()) {
  .validate_symbol(symbol)
  .request_public(config, "/api/v3/referencePrice", query = list(symbol = symbol))
}

#' Get Binance Spot reference price calculation metadata
#'
#' @param symbol Trading pair symbol, for example `"BTCUSDT"`.
#' @param symbol_status Optional trading status filter.
#' @param config A spot configuration created by [config_spot()].
#'
#' @return A parsed list.
#' @export
spot_get_reference_price_calculation <- function(
    symbol,
    symbol_status = NULL,
    config = config_spot()) {
  .validate_symbol(symbol)
  .validate_optional_scalar_character(symbol_status, "symbol_status")

  .request_public(
    config,
    "/api/v3/referencePrice/calculation",
    query = list(
      symbol = symbol,
      symbolStatus = symbol_status
    )
  )
}

#' @noRd
.spot_symbol_selector_query <- function(
    symbol = NULL,
    symbols = NULL,
    symbol_status = NULL,
    require_any = FALSE) {
  .validate_optional_scalar_character(symbol, "symbol")
  .validate_optional_character_vector(symbols, "symbols")
  .validate_optional_scalar_character(symbol_status, "symbol_status")
  .validate_at_most_one(symbol, symbols, arg_names = c("symbol", "symbols"))
  if (isTRUE(require_any)) {
    .validate_required_any(symbol, symbols, arg_names = c("symbol", "symbols"))
  }

  list(
    symbol = symbol,
    symbols = .json_array_param(symbols),
    symbolStatus = symbol_status
  )
}

#' @noRd
.validate_optional_window_size <- function(x, arg) {
  if (is.null(x)) {
    return(invisible(x))
  }
  .validate_scalar_character(x, arg)
  valid_pattern <- "^(?:([1-9]|[1-5][0-9])m|([1-9]|1[0-9]|2[0-3])h|([1-7])d)$"
  if (!grepl(valid_pattern, x)) {
    stop(
      sprintf("`%s` must be one of 1m-59m, 1h-23h, or 1d-7d.", arg),
      call. = FALSE
    )
  }
  invisible(x)
}

#' @noRd
.spot_market_maybe_tabular <- function(payload, json_list = FALSE) {
  if (isTRUE(json_list)) {
    return(payload)
  }
  if (is.list(payload) && length(payload) && all(vapply(payload, is.list, logical(1)))) {
    return(.maybe_as_dt(payload))
  }
  payload
}

#' @noRd
.spot_klines_to_dt <- function(payload) {
  kline_dt <- data.table::rbindlist(payload)
  names(kline_dt) <- c(
    "datetime", "open", "high", "low", "close", "volume",
    "datetime_close", "quote_asset_volume", "num_trades",
    "taker_buy_base_vol", "taker_buy_quote_vol", "ignore"
  )
  kline_dt <- .normalize_time_cols(kline_dt, c("datetime", "datetime_close"))
  .coerce_numeric_cols(
    kline_dt,
    c("open", "high", "low", "close", "volume", "quote_asset_volume",
      "num_trades", "taker_buy_base_vol", "taker_buy_quote_vol", "ignore")
  )
}
