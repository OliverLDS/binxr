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
