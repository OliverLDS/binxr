#' Get Binance Futures server time
#'
#' @param config list binxr futures configuration.
#' @return POSIXct Current server time.
#' @export
get_fapi_system_time <- function(config = binxr_config_futures()) {
  .ms_to_datetime(.binxr_now(config))
}

#' Get Binance Futures exchange info
#'
#' @param config list binxr futures configuration.
#' @return list Exchange info (symbols, assets); returned invisibly.
#' @export
get_fapi_exchange_info <- function(config = binxr_config_futures()) {
  ei <- .public_get(config, "/fapi/v1/exchangeInfo")
  names(ei$symbols) <- vapply(ei$symbols, `[[`, "", "symbol")
  names(ei$assets) <- vapply(ei$assets, `[[`, "", "asset")
  invisible(ei)
}

#' Get Binance Futures mark price (premium index)
#'
#' @param symbol character|NULL Trading pair symbol like "ETHUSDT"; NULL for all.
#' @param config list binxr futures configuration.
#' @return list Parsed JSON from `/fapi/v1/premiumIndex`.
#' @export
get_fapi_mark_price <- function(symbol = NULL, config = binxr_config_futures()) {
  q <- if (is.null(symbol)) NULL else list(symbol = symbol)
  .public_get(config, "/fapi/v1/premiumIndex", q)
}

#' Get Binance Spot mark price
#'
#' @param symbol character|NULL Trading pair symbol like "ETHUSDT"; NULL for all.
#' @param config list binxr spot configuration.
#' @return list Parsed JSON from `/api/v3/ticker/price`.
#' @export
get_spot_mark_price <- function(symbol = NULL, config = binxr_config_spot()) {
  q <- if (is.null(symbol)) NULL else list(symbol = symbol)
  .public_get(config, "/api/v3/ticker/price", q)
}

#' Get Binance Futures klines
#'
#' @param symbol character Trading pair symbol, e.g., "ETHUSDT".
#' @param interval character Kline interval.
#' @param startTime numeric|NULL Start time in ms since epoch.
#' @param endTime numeric|NULL End time in ms since epoch.
#' @param limit integer Number of rows (max 1500 depending on interval; default 500).
#' @param config list binxr futures configuration.
#' @return data.table Data table of klines with time columns converted to POSIXct.
#' @export
get_fapi_klines <- function(
    symbol, interval, startTime = NULL, endTime = NULL, limit = 500,
    config = binxr_config_futures()) {
  q <- list(
    symbol = symbol, interval = interval, limit = limit,
    startTime = startTime, endTime = endTime
  )
  kline_dt <- data.table::rbindlist(.public_get(config, "/fapi/v1/klines", q))
  names(kline_dt) <- c('datetime', 'open', 'high', 'low', 'close', 'volume', 'datetime_close', 'quote_asset_volume', 'num_trades', 'taker_buy_base_vol', 'taker_buy_quote_vol', 'ignore')
  data.table::set(kline_dt, j = 'datetime', value = .ms_to_datetime(kline_dt$datetime))
  data.table::set(kline_dt, j = 'datetime_close', value = .ms_to_datetime(kline_dt$datetime_close))
  kline_dt
}
