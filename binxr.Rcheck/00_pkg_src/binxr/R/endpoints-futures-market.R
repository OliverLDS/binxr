#' Get Binance Futures server time
#'
#' @param config A futures configuration created by [config_futures()].
#'
#' @return A `POSIXct` timestamp.
#' @export
futures_get_server_time <- function(config = config_futures()) {
  .ms_to_datetime(.binance_server_time(config))
}

#' @rdname futures_get_server_time
#' @export
get_fapi_system_time <- function(config = binxr_config_futures()) {
  .binxr_deprecate_alias("get_fapi_system_time", "futures_get_server_time")
  futures_get_server_time(config = config)
}

#' Get Binance Futures exchange info
#'
#' @param config A futures configuration created by [config_futures()].
#'
#' @return A parsed list. Symbol and asset lists are named when present.
#' @export
futures_get_exchange_info <- function(config = config_futures()) {
  payload <- .request_public(config, "/fapi/v1/exchangeInfo")
  if (!is.null(payload$symbols)) {
    names(payload$symbols) <- vapply(payload$symbols, `[[`, "", "symbol")
  }
  if (!is.null(payload$assets)) {
    names(payload$assets) <- vapply(payload$assets, `[[`, "", "asset")
  }
  payload
}

#' @rdname futures_get_exchange_info
#' @export
get_fapi_exchange_info <- function(config = binxr_config_futures()) {
  .binxr_deprecate_alias("get_fapi_exchange_info", "futures_get_exchange_info")
  futures_get_exchange_info(config = config)
}

#' Get Binance Futures mark price
#'
#' @param symbol Optional trading pair symbol such as `"ETHUSDT"`. If `NULL`,
#'   returns all symbols.
#' @param config A futures configuration created by [config_futures()].
#'
#' @return A parsed list.
#' @export
futures_get_mark_price <- function(symbol = NULL, config = config_futures()) {
  if (!is.null(symbol)) {
    .validate_symbol(symbol)
  }
  .request_public(config, "/fapi/v1/premiumIndex", query = list(symbol = symbol))
}

#' @rdname futures_get_mark_price
#' @export
get_fapi_mark_price <- function(symbol = NULL, config = binxr_config_futures()) {
  .binxr_deprecate_alias("get_fapi_mark_price", "futures_get_mark_price")
  futures_get_mark_price(symbol = symbol, config = config)
}

#' Get Binance Futures klines
#'
#' @param symbol Trading pair symbol, for example `"ETHUSDT"`.
#' @param interval Kline interval string.
#' @param startTime Optional start time in milliseconds since Unix epoch.
#' @param endTime Optional end time in milliseconds since Unix epoch.
#' @param limit Maximum number of rows to return.
#' @param json_list If `TRUE`, return the parsed list instead of a `data.table`.
#' @param config A futures configuration created by [config_futures()].
#'
#' @return A `data.table` by default, or a parsed list when `json_list = TRUE`.
#' @export
futures_get_klines <- function(
    symbol,
    interval,
    startTime = NULL,
    endTime = NULL,
    limit = 500,
    json_list = FALSE,
    config = config_futures()) {
  .validate_symbol(symbol)
  .validate_scalar_character(interval, "interval")
  .validate_positive_integerish(limit, "limit")
  .validate_optional_scalar_numeric(startTime, "startTime")
  .validate_optional_scalar_numeric(endTime, "endTime")

  payload <- .request_public(
    config,
    "/fapi/v1/klines",
    query = list(
      symbol = symbol,
      interval = interval,
      limit = limit,
      startTime = startTime,
      endTime = endTime
    )
  )

  if (isTRUE(json_list)) {
    return(payload)
  }

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

#' @rdname futures_get_klines
#' @export
get_fapi_klines <- function(
    symbol,
    interval,
    startTime = NULL,
    endTime = NULL,
    limit = 500,
    config = binxr_config_futures()) {
  .binxr_deprecate_alias("get_fapi_klines", "futures_get_klines")
  futures_get_klines(
    symbol = symbol,
    interval = interval,
    startTime = startTime,
    endTime = endTime,
    limit = limit,
    json_list = FALSE,
    config = config
  )
}

#' Test Binance Futures connectivity
#'
#' @param config A futures configuration created by [config_futures()].
#'
#' @return A parsed list.
#' @export
futures_ping <- function(config = config_futures()) {
  .request_public(config, "/fapi/v1/ping")
}

#' Get Binance Futures order book
#'
#' @param symbol Trading pair symbol, for example `"ETHUSDT"`.
#' @param limit Optional depth limit. One of `5`, `10`, `20`, `50`, `100`,
#'   `500`, or `1000`.
#' @param config A futures configuration created by [config_futures()].
#'
#' @return A parsed list.
#' @export
futures_get_order_book <- function(symbol, limit = NULL, config = config_futures()) {
  .validate_symbol(symbol)
  if (!is.null(limit)) {
    .validate_positive_integerish(limit, "limit")
    if (!(limit %in% c(5L, 10L, 20L, 50L, 100L, 500L, 1000L))) {
      stop("`limit` must be one of: 5, 10, 20, 50, 100, 500, 1000.", call. = FALSE)
    }
  }

  .request_public(config, "/fapi/v1/depth", query = list(symbol = symbol, limit = limit))
}

#' Get Binance Futures recent trades
#'
#' @param symbol Trading pair symbol, for example `"ETHUSDT"`.
#' @param limit Maximum number of trades to return. Must not exceed `1000`.
#' @param json_list If `TRUE`, return the parsed list instead of a `data.table`.
#' @param config A futures configuration created by [config_futures()].
#'
#' @return A `data.table` by default, or a parsed list when `json_list = TRUE`.
#' @export
futures_get_recent_trades <- function(symbol, limit = 500, json_list = FALSE, config = config_futures()) {
  .validate_symbol(symbol)
  .futures_validate_limit(limit)
  .validate_json_list_flag(json_list)

  payload <- .request_public(config, "/fapi/v1/trades", query = list(symbol = symbol, limit = limit))
  if (isTRUE(json_list)) {
    return(payload)
  }

  trades_dt <- .maybe_as_dt(payload)
  trades_dt <- .coerce_numeric_cols(trades_dt, c("id", "price", "qty", "quoteQty"))
  .normalize_time_cols(trades_dt, "time")
}

#' Get Binance Futures aggregate trades
#'
#' @param symbol Trading pair symbol, for example `"ETHUSDT"`.
#' @param fromId Optional aggregate trade ID.
#' @param startTime Optional start time in milliseconds since Unix epoch.
#' @param endTime Optional end time in milliseconds since Unix epoch.
#' @param limit Maximum number of trades to return. Must not exceed `1000`.
#' @param json_list If `TRUE`, return the parsed list instead of a `data.table`.
#' @param config A futures configuration created by [config_futures()].
#'
#' @return A `data.table` by default, or a parsed list when `json_list = TRUE`.
#' @export
futures_get_aggregate_trades <- function(
    symbol,
    fromId = NULL,
    startTime = NULL,
    endTime = NULL,
    limit = 500,
    json_list = FALSE,
    config = config_futures()) {
  .validate_symbol(symbol)
  .validate_optional_scalar_numeric(fromId, "fromId")
  .validate_optional_scalar_numeric(startTime, "startTime")
  .validate_optional_scalar_numeric(endTime, "endTime")
  .futures_validate_limit(limit)
  .validate_json_list_flag(json_list)

  if (!is.null(fromId) && (!is.null(startTime) || !is.null(endTime))) {
    stop("`fromId` must not be supplied with `startTime` or `endTime`.", call. = FALSE)
  }
  .futures_validate_time_window(startTime, endTime, 60L * 60L * 1000L, "1 hour")

  payload <- .request_public(
    config,
    "/fapi/v1/aggTrades",
    query = list(symbol = symbol, fromId = fromId, startTime = startTime, endTime = endTime, limit = limit)
  )
  if (isTRUE(json_list)) {
    return(payload)
  }

  trades_dt <- .maybe_as_dt(payload)
  trades_dt <- .coerce_numeric_cols(trades_dt, c("a", "p", "q", "f", "l"))
  .normalize_time_cols(trades_dt, "T")
}

#' Get Binance Futures 24hr ticker statistics
#'
#' @param symbol Optional trading pair symbol.
#' @param config A futures configuration created by [config_futures()].
#'
#' @return A parsed list.
#' @export
futures_get_24hr_ticker <- function(symbol = NULL, config = config_futures()) {
  if (!is.null(symbol)) {
    .validate_symbol(symbol)
  }
  .request_public(config, "/fapi/v1/ticker/24hr", query = list(symbol = symbol))
}

#' Get Binance Futures ticker price
#'
#' @param symbol Optional trading pair symbol.
#' @param version One of `"v2"` or `"deprecated"`.
#' @param config A futures configuration created by [config_futures()].
#'
#' @return A parsed list.
#' @export
futures_get_ticker_price <- function(
    symbol = NULL,
    version = c("v2", "deprecated"),
    config = config_futures()) {
  if (!is.null(symbol)) {
    .validate_symbol(symbol)
  }
  version <- match.arg(version)
  path <- if (identical(version, "v2")) "/fapi/v2/ticker/price" else "/fapi/v1/ticker/price"
  .request_public(config, path, query = list(symbol = symbol))
}

#' Get Binance Futures order book ticker
#'
#' @param symbol Optional trading pair symbol.
#' @param config A futures configuration created by [config_futures()].
#'
#' @return A parsed list.
#' @export
futures_get_book_ticker <- function(symbol = NULL, config = config_futures()) {
  if (!is.null(symbol)) {
    .validate_symbol(symbol)
  }
  .request_public(config, "/fapi/v1/ticker/bookTicker", query = list(symbol = symbol))
}

#' Get Binance Futures open interest
#'
#' @param symbol Trading pair symbol, for example `"ETHUSDT"`.
#' @param config A futures configuration created by [config_futures()].
#'
#' @return A parsed list.
#' @export
futures_get_open_interest <- function(symbol, config = config_futures()) {
  .validate_symbol(symbol)
  .request_public(config, "/fapi/v1/openInterest", query = list(symbol = symbol))
}

#' Get Binance Futures funding rate history
#'
#' @param symbol Optional trading pair symbol.
#' @param startTime Optional start time in milliseconds since Unix epoch.
#' @param endTime Optional end time in milliseconds since Unix epoch.
#' @param limit Maximum number of rows to return. Must not exceed `1000`.
#' @param json_list If `TRUE`, return the parsed list instead of a `data.table`.
#' @param config A futures configuration created by [config_futures()].
#'
#' @return A `data.table` by default, or a parsed list when `json_list = TRUE`.
#' @export
futures_get_funding_rate_history <- function(
    symbol = NULL,
    startTime = NULL,
    endTime = NULL,
    limit = 100,
    json_list = FALSE,
    config = config_futures()) {
  if (!is.null(symbol)) {
    .validate_symbol(symbol)
  }
  .validate_optional_scalar_numeric(startTime, "startTime")
  .validate_optional_scalar_numeric(endTime, "endTime")
  .futures_validate_limit(limit)
  .validate_json_list_flag(json_list)

  payload <- .request_public(
    config,
    "/fapi/v1/fundingRate",
    query = list(symbol = symbol, startTime = startTime, endTime = endTime, limit = limit)
  )
  if (isTRUE(json_list)) {
    return(payload)
  }

  rate_dt <- .maybe_as_dt(payload)
  rate_dt <- .coerce_numeric_cols(rate_dt, c("fundingRate", "markPrice"))
  .normalize_time_cols(rate_dt, "fundingTime")
}

#' Get Binance Futures funding info
#'
#' @param symbol Optional trading pair symbol.
#' @param json_list If `TRUE`, return the parsed list instead of a `data.table`.
#' @param config A futures configuration created by [config_futures()].
#'
#' @return A `data.table` by default, or a parsed list when `json_list = TRUE`.
#' @export
futures_get_funding_info <- function(symbol = NULL, json_list = FALSE, config = config_futures()) {
  if (!is.null(symbol)) {
    .validate_symbol(symbol)
  }
  .validate_json_list_flag(json_list)

  payload <- .request_public(config, "/fapi/v1/fundingInfo", query = list(symbol = symbol))
  if (isTRUE(json_list)) {
    return(payload)
  }

  .coerce_numeric_cols(.maybe_as_dt(payload), c("adjustedFundingRateCap", "adjustedFundingRateFloor", "fundingIntervalHours"))
}

#' Get Binance Futures mark price klines
#'
#' @inheritParams futures_get_klines
#'
#' @return A `data.table` by default, or a parsed list when `json_list = TRUE`.
#' @export
futures_get_mark_price_klines <- function(
    symbol, interval, startTime = NULL, endTime = NULL, limit = 500, json_list = FALSE, config = config_futures()) {
  .futures_get_derived_klines("/fapi/v1/markPriceKlines", symbol, interval, startTime, endTime, limit, json_list, config)
}

#' Get Binance Futures index price klines
#'
#' @inheritParams futures_get_klines
#'
#' @return A `data.table` by default, or a parsed list when `json_list = TRUE`.
#' @export
futures_get_index_price_klines <- function(
    symbol, interval, startTime = NULL, endTime = NULL, limit = 500, json_list = FALSE, config = config_futures()) {
  .futures_get_derived_klines("/fapi/v1/indexPriceKlines", symbol, interval, startTime, endTime, limit, json_list, config)
}

#' Get Binance Futures premium index klines
#'
#' @inheritParams futures_get_klines
#'
#' @return A `data.table` by default, or a parsed list when `json_list = TRUE`.
#' @export
futures_get_premium_index_klines <- function(
    symbol, interval, startTime = NULL, endTime = NULL, limit = 500, json_list = FALSE, config = config_futures()) {
  .futures_get_derived_klines("/fapi/v1/premiumIndexKlines", symbol, interval, startTime, endTime, limit, json_list, config)
}

#' Get Binance Futures continuous contract klines
#'
#' @param pair Futures pair, for example `"BTCUSDT"`.
#' @param contract_type One of `"PERPETUAL"`, `"CURRENT_MONTH"`,
#'   `"NEXT_MONTH"`, `"CURRENT_QUARTER"`, or `"NEXT_QUARTER"`.
#' @param interval Kline interval string.
#' @param startTime Optional start time in milliseconds since Unix epoch.
#' @param endTime Optional end time in milliseconds since Unix epoch.
#' @param limit Maximum number of rows to return. Must not exceed `1500`.
#' @param json_list If `TRUE`, return the parsed list instead of a `data.table`.
#' @param config A futures configuration created by [config_futures()].
#'
#' @return A `data.table` by default, or a parsed list when `json_list = TRUE`.
#' @export
futures_get_continuous_klines <- function(
    pair,
    contract_type = c("PERPETUAL", "CURRENT_MONTH", "NEXT_MONTH", "CURRENT_QUARTER", "NEXT_QUARTER"),
    interval,
    startTime = NULL,
    endTime = NULL,
    limit = 500,
    json_list = FALSE,
    config = config_futures()) {
  .validate_symbol(pair, "pair")
  contract_type <- match.arg(contract_type)
  .validate_scalar_character(interval, "interval")
  .futures_validate_limit(limit, max = 1500)
  .validate_optional_scalar_numeric(startTime, "startTime")
  .validate_optional_scalar_numeric(endTime, "endTime")
  .validate_json_list_flag(json_list)

  payload <- .request_public(
    config,
    "/fapi/v1/continuousKlines",
    query = list(pair = pair, contractType = contract_type, interval = interval, startTime = startTime, endTime = endTime, limit = limit)
  )
  if (isTRUE(json_list)) {
    return(payload)
  }

  .futures_as_klines_dt(payload)
}

#' @noRd
.futures_validate_limit <- function(limit, max = 1000L, arg = "limit") {
  .validate_positive_integerish(limit, arg)
  if (limit > max) {
    stop(sprintf("`%s` must be less than or equal to %d.", arg, max), call. = FALSE)
  }
  invisible(limit)
}

#' @noRd
.futures_validate_time_window <- function(start_time, end_time, max_diff_ms, label) {
  if (is.null(start_time) || is.null(end_time)) {
    return(invisible(TRUE))
  }
  if (end_time < start_time) {
    stop("`endTime` must be greater than or equal to `startTime`.", call. = FALSE)
  }
  if ((end_time - start_time) > max_diff_ms) {
    stop(sprintf("The time between `startTime` and `endTime` must not exceed %s.", label), call. = FALSE)
  }
  invisible(TRUE)
}

#' @noRd
.futures_as_klines_dt <- function(payload) {
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

#' @noRd
.futures_get_derived_klines <- function(path, symbol, interval, startTime, endTime, limit, json_list, config) {
  .validate_symbol(symbol)
  .validate_scalar_character(interval, "interval")
  .futures_validate_limit(limit, max = 1500)
  .validate_optional_scalar_numeric(startTime, "startTime")
  .validate_optional_scalar_numeric(endTime, "endTime")
  .validate_json_list_flag(json_list)

  payload <- .request_public(
    config,
    path,
    query = list(symbol = symbol, interval = interval, startTime = startTime, endTime = endTime, limit = limit)
  )
  if (isTRUE(json_list)) {
    return(payload)
  }

  .futures_as_klines_dt(payload)
}
