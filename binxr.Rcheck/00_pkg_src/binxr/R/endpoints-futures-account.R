#' Get Binance Futures account info
#'
#' @param config A futures configuration created by [config_futures()].
#'
#' @return A parsed list.
#' @export
futures_get_account <- function(config = config_futures()) {
  .request_signed(config, "/fapi/v2/account", params = list(), method = "GET")
}

#' @rdname futures_get_account
#' @export
get_fapi_account <- function(config = binxr_config_futures()) {
  .binxr_deprecate_alias("get_fapi_account", "futures_get_account")
  futures_get_account(config = config)
}

#' Get Binance Futures position risk
#'
#' @param json_list If `TRUE`, return the parsed list instead of a `data.table`.
#' @param config A futures configuration created by [config_futures()].
#'
#' @return A `data.table` by default, or a parsed list when `json_list = TRUE`.
#' @export
futures_get_position_risk <- function(json_list = FALSE, config = config_futures()) {
  payload <- .request_signed(config, "/fapi/v2/positionRisk", params = list(), method = "GET")
  if (isTRUE(json_list)) {
    return(payload)
  }

  risk_dt <- .maybe_as_dt(payload)
  risk_dt <- .coerce_numeric_cols(
    risk_dt,
    c("positionAmt", "entryPrice", "breakEvenPrice", "markPrice", "unRealizedProfit",
      "liquidationPrice", "isolatedMargin", "notional", "isolatedWallet", "adl")
  )
  .normalize_time_cols(risk_dt, "updateTime")
}

#' @rdname futures_get_position_risk
#' @export
get_fapi_account_position_risk <- function(config = binxr_config_futures()) {
  .binxr_deprecate_alias("get_fapi_account_position_risk", "futures_get_position_risk")
  futures_get_position_risk(config = config)
}

#' Get standardized Binance Futures positions
#'
#' @param acc Optional account payload from [futures_get_account()]. If `NULL`,
#'   account data is fetched.
#' @param json_list If `TRUE`, return the parsed list instead of a `data.table`.
#' @param config A futures configuration created by [config_futures()].
#'
#' @return A `data.table` by default, or a parsed list when `json_list = TRUE`.
#' @export
futures_get_positions <- function(acc = NULL, json_list = FALSE, config = config_futures()) {
  if (is.null(acc)) {
    acc <- futures_get_account(config = config)
  }
  positions <- acc$positions %||% list()
  if (isTRUE(json_list)) {
    return(positions)
  }

  pos_dt <- .maybe_as_dt(positions)
  pos_dt <- .coerce_numeric_cols(
    pos_dt,
    c(
      "positionAmt", "initialMargin", "maintMargin", "entryPrice", "breakEvenPrice",
      "unrealizedProfit", "positionInitialMargin", "openOrderInitialMargin",
      "isolatedMargin", "notional", "isolatedWallet", "bidNotional", "askNotional"
    )
  )
  if ("leverage" %in% names(pos_dt)) {
    data.table::set(pos_dt, j = "leverage", value = as.integer(pos_dt$leverage))
  }
  .normalize_time_cols(pos_dt, "updateTime")
}

#' @rdname futures_get_positions
#' @export
get_fapi_account_positions <- function(acc = NULL, config = binxr_config_futures()) {
  .binxr_deprecate_alias("get_fapi_account_positions", "futures_get_positions")
  futures_get_positions(acc = acc, config = config)
}

#' Get Binance Futures account summary
#'
#' @param acc Optional account payload from [futures_get_account()]. If `NULL`,
#'   account data is fetched.
#' @param json_list If `TRUE`, return the parsed list instead of a `data.table`.
#' @param config A futures configuration created by [config_futures()].
#'
#' @return A one-row `data.table` by default, or a parsed list when
#'   `json_list = TRUE`.
#' @export
futures_get_account_summary <- function(acc = NULL, json_list = FALSE, config = config_futures()) {
  if (is.null(acc)) {
    acc <- futures_get_account(config = config)
  }

  summary_list <- list(
    totalWalletBalance = as.numeric(acc$totalWalletBalance),
    totalUnrealizedProfit = as.numeric(acc$totalUnrealizedProfit),
    totalInitialMargin = as.numeric(acc$totalInitialMargin),
    totalMaintMargin = as.numeric(acc$totalMaintMargin),
    availableBalance = as.numeric(acc$availableBalance),
    maxWithdrawAmount = as.numeric(acc$maxWithdrawAmount)
  )

  if (isTRUE(json_list)) {
    return(summary_list)
  }

  data.table::as.data.table(summary_list)
}

#' @rdname futures_get_account_summary
#' @export
get_fapi_account_summary <- function(acc = NULL, config = binxr_config_futures()) {
  .binxr_deprecate_alias("get_fapi_account_summary", "futures_get_account_summary")
  futures_get_account_summary(acc = acc, config = config)
}

#' Get Binance Futures balances
#'
#' @param json_list If `TRUE`, return the parsed list instead of a `data.table`.
#' @param config A futures configuration created by [config_futures()].
#'
#' @return A `data.table` by default, or a parsed list when `json_list = TRUE`.
#' @export
futures_get_balance <- function(json_list = FALSE, config = config_futures()) {
  payload <- .request_signed(config, "/fapi/v3/balance", params = list(), method = "GET")
  if (isTRUE(json_list)) {
    return(payload)
  }

  balance_dt <- .maybe_as_dt(payload)
  balance_dt <- .coerce_numeric_cols(
    balance_dt,
    c("balance", "crossWalletBalance", "crossUnPnl", "availableBalance", "maxWithdrawAmount")
  )
  .normalize_time_cols(balance_dt, "updateTime")
}

#' Get Binance Futures position mode
#'
#' @param config A futures configuration created by [config_futures()].
#'
#' @return A parsed list.
#' @export
futures_get_position_mode <- function(config = config_futures()) {
  .request_signed(config, "/fapi/v1/positionSide/dual", params = list(), method = "GET")
}

#' Get Binance Futures multi-assets mode
#'
#' @param config A futures configuration created by [config_futures()].
#'
#' @return A parsed list.
#' @export
futures_get_multi_assets_mode <- function(config = config_futures()) {
  .request_signed(config, "/fapi/v1/multiAssetsMargin", params = list(), method = "GET")
}

#' Get Binance Futures commission rate
#'
#' @param symbol Trading pair symbol, for example `"ETHUSDT"`.
#' @param config A futures configuration created by [config_futures()].
#'
#' @return A parsed list.
#' @export
futures_get_commission_rate <- function(symbol, config = config_futures()) {
  .validate_symbol(symbol)
  .request_signed(config, "/fapi/v1/commissionRate", params = list(symbol = symbol), method = "GET")
}

#' Get Binance Futures order rate limits
#'
#' @param json_list If `TRUE`, return the parsed list instead of a `data.table`.
#' @param config A futures configuration created by [config_futures()].
#'
#' @return A `data.table` by default, or a parsed list when `json_list = TRUE`.
#' @export
futures_get_order_rate_limit <- function(json_list = FALSE, config = config_futures()) {
  payload <- .request_signed(config, "/fapi/v1/rateLimit/order", params = list(), method = "GET")
  if (isTRUE(json_list)) {
    return(payload)
  }

  .coerce_numeric_cols(.maybe_as_dt(payload), c("intervalNum", "limit"))
}
