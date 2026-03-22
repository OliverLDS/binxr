#' Test Binance Options connectivity
#'
#' @param config An options configuration created by [config_options()].
#'
#' @return A parsed list.
#' @export
options_ping <- function(config = config_options()) {
  .request_public(config, "/eapi/v1/ping")
}

#' Get Binance Options server time
#'
#' @param config An options configuration created by [config_options()].
#'
#' @return A `POSIXct` timestamp.
#' @export
options_get_server_time <- function(config = config_options()) {
  .ms_to_datetime(.binance_server_time(config))
}

#' Get Binance Options exchange info
#'
#' @param config An options configuration created by [config_options()].
#'
#' @return A parsed list. Option symbol and asset lists are named when present.
#' @export
options_get_exchange_info <- function(config = config_options()) {
  payload <- .request_public(config, "/eapi/v1/exchangeInfo")
  if (!is.null(payload$optionSymbols)) {
    names(payload$optionSymbols) <- vapply(payload$optionSymbols, `[[`, "", "symbol")
  }
  if (!is.null(payload$optionAssets)) {
    names(payload$optionAssets) <- vapply(payload$optionAssets, `[[`, "", "name")
  }
  payload
}

#' Get Binance Options order book
#'
#' @param symbol Option symbol, for example `"BTC-200730-9000-C"`.
#' @param limit Optional depth limit. One of `10`, `20`, `50`, `100`, `500`, or
#'   `1000`.
#' @param config An options configuration created by [config_options()].
#'
#' @return A parsed list.
#' @export
options_get_order_book <- function(symbol, limit = NULL, config = config_options()) {
  .validate_symbol(symbol)
  if (!is.null(limit)) {
    .validate_positive_integerish(limit, "limit")
    if (!(limit %in% c(10L, 20L, 50L, 100L, 500L, 1000L))) {
      stop("`limit` must be one of: 10, 20, 50, 100, 500, 1000.", call. = FALSE)
    }
  }

  .request_public(config, "/eapi/v1/depth", query = list(symbol = symbol, limit = limit))
}

#' Get Binance Options recent trades
#'
#' @param symbol Option symbol, for example `"BTC-200730-9000-C"`.
#' @param limit Maximum number of trades to return. Must not exceed `500`.
#' @param json_list If `TRUE`, return the parsed list instead of a `data.table`.
#' @param config An options configuration created by [config_options()].
#'
#' @return A `data.table` by default, or a parsed list when `json_list = TRUE`.
#' @export
options_get_recent_trades <- function(symbol, limit = 100, json_list = FALSE, config = config_options()) {
  .validate_symbol(symbol)
  .options_validate_limit(limit, max = 500)
  .validate_json_list_flag(json_list)

  payload <- .request_public(config, "/eapi/v1/trades", query = list(symbol = symbol, limit = limit))
  if (isTRUE(json_list)) {
    return(payload)
  }

  .options_as_trades_dt(payload)
}

#' Get Binance Options recent block trades
#'
#' @param symbol Optional option symbol.
#' @param limit Maximum number of trades to return. Must not exceed `500`.
#' @param json_list If `TRUE`, return the parsed list instead of a `data.table`.
#' @param config An options configuration created by [config_options()].
#'
#' @return A `data.table` by default, or a parsed list when `json_list = TRUE`.
#' @export
options_get_recent_block_trades <- function(symbol = NULL, limit = 100, json_list = FALSE, config = config_options()) {
  if (!is.null(symbol)) {
    .validate_symbol(symbol)
  }
  .options_validate_limit(limit, max = 500)
  .validate_json_list_flag(json_list)

  payload <- .request_public(config, "/eapi/v1/blockTrades", query = list(symbol = symbol, limit = limit))
  if (isTRUE(json_list)) {
    return(payload)
  }

  .options_as_trades_dt(payload)
}

#' Get Binance Options klines
#'
#' @param symbol Option symbol, for example `"BTC-200730-9000-C"`.
#' @param interval Kline interval string.
#' @param startTime Optional start time in milliseconds since Unix epoch.
#' @param endTime Optional end time in milliseconds since Unix epoch.
#' @param limit Maximum number of rows to return. Must not exceed `1500`.
#' @param json_list If `TRUE`, return the parsed list instead of a `data.table`.
#' @param config An options configuration created by [config_options()].
#'
#' @return A `data.table` by default, or a parsed list when `json_list = TRUE`.
#' @export
options_get_klines <- function(
    symbol,
    interval,
    startTime = NULL,
    endTime = NULL,
    limit = 500,
    json_list = FALSE,
    config = config_options()) {
  .validate_symbol(symbol)
  .validate_scalar_character(interval, "interval")
  .options_validate_limit(limit, max = 1500)
  .validate_optional_scalar_numeric(startTime, "startTime")
  .validate_optional_scalar_numeric(endTime, "endTime")
  .validate_json_list_flag(json_list)

  payload <- .request_public(
    config,
    "/eapi/v1/klines",
    query = list(symbol = symbol, interval = interval, startTime = startTime, endTime = endTime, limit = limit)
  )
  if (isTRUE(json_list)) {
    return(payload)
  }

  .futures_as_klines_dt(payload)
}

#' Get Binance Options mark prices
#'
#' @param symbol Optional option symbol.
#' @param json_list If `TRUE`, return the parsed list instead of a `data.table`.
#' @param config An options configuration created by [config_options()].
#'
#' @return A `data.table` by default, or a parsed list when `json_list = TRUE`.
#' @export
options_get_mark_price <- function(symbol = NULL, json_list = FALSE, config = config_options()) {
  if (!is.null(symbol)) {
    .validate_symbol(symbol)
  }
  .validate_json_list_flag(json_list)

  payload <- .request_public(config, "/eapi/v1/mark", query = list(symbol = symbol))
  if (isTRUE(json_list)) {
    return(payload)
  }

  mark_dt <- .maybe_as_dt(payload)
  .coerce_numeric_cols(
    mark_dt,
    c("markPrice", "bidIV", "askIV", "markIV", "delta", "theta", "gamma", "vega",
      "highPriceLimit", "lowPriceLimit", "riskFreeInterest")
  )
}

#' Get Binance Options underlying index price
#'
#' @param underlying Underlying spot pair, for example `"BTCUSDT"`.
#' @param config An options configuration created by [config_options()].
#'
#' @return A parsed list.
#' @export
options_get_index_price <- function(underlying, config = config_options()) {
  .validate_symbol(underlying, "underlying")
  .request_public(config, "/eapi/v1/index", query = list(underlying = underlying))
}

#' Get Binance Options 24hr ticker statistics
#'
#' @param symbol Optional option symbol.
#' @param json_list If `TRUE`, return the parsed list instead of a `data.table`.
#' @param config An options configuration created by [config_options()].
#'
#' @return A `data.table` by default, or a parsed list when `json_list = TRUE`.
#' @export
options_get_24hr_ticker <- function(symbol = NULL, json_list = FALSE, config = config_options()) {
  if (!is.null(symbol)) {
    .validate_symbol(symbol)
  }
  .validate_json_list_flag(json_list)

  payload <- .request_public(config, "/eapi/v1/ticker", query = list(symbol = symbol))
  if (isTRUE(json_list)) {
    return(payload)
  }

  ticker_dt <- .maybe_as_dt(payload)
  ticker_dt <- .coerce_numeric_cols(
    ticker_dt,
    c("priceChange", "priceChangePercent", "lastPrice", "lastQty", "open", "high", "low",
      "volume", "amount", "bidPrice", "askPrice", "firstTradeId", "tradeCount", "strikePrice", "exercisePrice")
  )
  .normalize_time_cols(ticker_dt, c("openTime", "closeTime"))
}

#' Get Binance Options open interest
#'
#' @param underlying_asset Underlying asset, for example `"BTCUSDT"`.
#' @param expiration Expiration date, for example `"221225"`.
#' @param json_list If `TRUE`, return the parsed list instead of a `data.table`.
#' @param config An options configuration created by [config_options()].
#'
#' @return A `data.table` by default, or a parsed list when `json_list = TRUE`.
#' @export
options_get_open_interest <- function(
    underlying_asset,
    expiration,
    json_list = FALSE,
    config = config_options()) {
  .validate_symbol(underlying_asset, "underlying_asset")
  .validate_scalar_character(expiration, "expiration")
  .validate_json_list_flag(json_list)

  payload <- .request_public(
    config,
    "/eapi/v1/openInterest",
    query = list(underlyingAsset = underlying_asset, expiration = expiration)
  )
  if (isTRUE(json_list)) {
    return(payload)
  }

  oi_dt <- .maybe_as_dt(payload)
  oi_dt <- .coerce_numeric_cols(oi_dt, c("sumOpenInterest", "sumOpenInterestUsd", "timestamp"))
  .normalize_time_cols(oi_dt, "timestamp")
}

#' Get Binance Options historical exercise records
#'
#' @param underlying Optional underlying symbol, for example `"BTCUSDT"`.
#' @param startTime Optional start time in milliseconds since Unix epoch.
#' @param endTime Optional end time in milliseconds since Unix epoch.
#' @param limit Maximum number of rows to return. Must not exceed `100`.
#' @param json_list If `TRUE`, return the parsed list instead of a `data.table`.
#' @param config An options configuration created by [config_options()].
#'
#' @return A `data.table` by default, or a parsed list when `json_list = TRUE`.
#' @export
options_get_exercise_history <- function(
    underlying = NULL,
    startTime = NULL,
    endTime = NULL,
    limit = 100,
    json_list = FALSE,
    config = config_options()) {
  if (!is.null(underlying)) {
    .validate_symbol(underlying, "underlying")
  }
  .validate_optional_scalar_numeric(startTime, "startTime")
  .validate_optional_scalar_numeric(endTime, "endTime")
  .options_validate_limit(limit, max = 100)
  .validate_json_list_flag(json_list)

  payload <- .request_public(
    config,
    "/eapi/v1/exerciseHistory",
    query = list(underlying = underlying, startTime = startTime, endTime = endTime, limit = limit)
  )
  if (isTRUE(json_list)) {
    return(payload)
  }

  history_dt <- .maybe_as_dt(payload)
  history_dt <- .coerce_numeric_cols(history_dt, c("strikePrice", "realStrikePrice"))
  .normalize_time_cols(history_dt, "expiryDate")
}

#' @noRd
.options_validate_limit <- function(limit, max, arg = "limit") {
  .validate_positive_integerish(limit, arg)
  if (limit > max) {
    stop(sprintf("`%s` must be less than or equal to %d.", arg, max), call. = FALSE)
  }
  invisible(limit)
}

#' @noRd
.options_as_trades_dt <- function(payload) {
  trades_dt <- .maybe_as_dt(payload)
  trades_dt <- .coerce_numeric_cols(trades_dt, c("id", "tradeId", "price", "qty", "quoteQty", "side"))
  .normalize_time_cols(trades_dt, "time")
}
