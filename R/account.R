#' Get Binance Futures account info
#'
#' @param config list binxr futures configuration.
#' @return list Parsed JSON from `/fapi/v2/account`.
#' @export
get_fapi_account <- function(config = binxr_config_futures()) {
  .signed_req(config, "/fapi/v2/account", list(), method = "GET")
}

#' Get position risk (Futures)
#'
#' @param config list binxr futures configuration.
#' @return data.table Position risk table (long positions only) with `updateTime` as POSIXct; returned invisibly.
#' @export
get_fapi_account_position_risk <- function(config = binxr_config_futures()) {
  risk_dt <- data.table::rbindlist(.signed_req(config, "/fapi/v2/positionRisk", list(), method = "GET"))
  risk_dt <- risk_dt[(as.numeric(risk_dt$positionAmt) > 0),]
  data.table::set(risk_dt, j = 'updateTime', value = .ms_to_datetime(risk_dt$updateTime))
  invisible(risk_dt)
}


#' Get standardized account positions (Futures)
#'
#' @param acc list|NULL Account object from `get_fapi_account()`; if NULL it will be fetched.
#' @param config list binxr futures configuration.
#' @return data.table Positions with numeric columns coerced and `updateTime` as POSIXct; returned invisibly.
#' @export
get_fapi_account_positions <- function(acc = NULL, config = binxr_config_futures()) {
  if (is.null(acc)) acc <- get_fapi_account(config)
  pos_dt <- data.table::rbindlist(acc$positions)
  num_cols <- c("positionAmt", "initialMargin", "maintMargin", "entryPrice", "breakEvenPrice", 
                "unrealizedProfit", "positionInitialMargin", "openOrderInitialMargin", "isolatedMargin")
  for (col in num_cols) {
    data.table::set(pos_dt, j = col, value = as.numeric(pos_dt[[col]]))
  }
  data.table::set(pos_dt, j = 'leverage', value = as.integer(pos_dt$leverage))
  data.table::set(pos_dt, j = 'updateTime', value = .ms_to_datetime(pos_dt$updateTime))
  pos_dt <- pos_dt[pos_dt$positionAmt > 0 | pos_dt$initialMargin > 0,]
  invisible(pos_dt)
}

#' Get account summary (Futures)
#'
#' @param acc list|NULL Account object from `get_fapi_account()`; if NULL it will be fetched.
#' @param config list binxr futures configuration.
#' @return data.table One-row summary with numeric balances and margins; returned invisibly.
#' @export
get_fapi_account_summary <- function(acc = NULL, config = binxr_config_futures()) {
  if (is.null(acc)) acc <- get_fapi_account(config)
  acc_summary_dt <- data.table::data.table(
    totalWalletBalance   = as.numeric(acc$totalWalletBalance),
    totalUnrealizedProfit= as.numeric(acc$totalUnrealizedProfit),
    totalInitialMargin   = as.numeric(acc$totalInitialMargin),
    totalMaintMargin     = as.numeric(acc$totalMaintMargin),
    availableBalance     = as.numeric(acc$availableBalance),
    maxWithdrawAmount    = as.numeric(acc$maxWithdrawAmount)
  )
  invisible(acc_summary_dt)
}
