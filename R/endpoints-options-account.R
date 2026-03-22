#' Get Binance Options margin account information
#'
#' @param config An options configuration created by [config_options()].
#'
#' @return A parsed list.
#' @export
options_get_margin_account <- function(config = config_options()) {
  .request_signed(config, "/eapi/v1/marginAccount", params = list(), method = "GET")
}

#' Get Binance Options funding flow
#'
#' @param currency Asset type. Currently Binance supports `"USDT"`.
#' @param recordId Optional record ID to start from.
#' @param startTime Optional start time in milliseconds since Unix epoch.
#' @param endTime Optional end time in milliseconds since Unix epoch.
#' @param limit Maximum number of rows to return. Must not exceed `1000`.
#' @param json_list If `TRUE`, return the parsed list instead of a `data.table`.
#' @param config An options configuration created by [config_options()].
#'
#' @return A `data.table` by default, or a parsed list when `json_list = TRUE`.
#' @export
options_get_funding_flow <- function(
    currency = "USDT",
    recordId = NULL,
    startTime = NULL,
    endTime = NULL,
    limit = 100,
    json_list = FALSE,
    config = config_options()) {
  .validate_scalar_character(currency, "currency")
  .validate_optional_scalar_numeric(recordId, "recordId")
  .validate_optional_scalar_numeric(startTime, "startTime")
  .validate_optional_scalar_numeric(endTime, "endTime")
  .options_validate_limit(limit, max = 1000)
  .validate_json_list_flag(json_list)

  payload <- .request_signed(
    config,
    "/eapi/v1/bill",
    params = list(currency = currency, recordId = recordId, startTime = startTime, endTime = endTime, limit = limit),
    method = "GET"
  )
  if (isTRUE(json_list)) {
    return(payload)
  }

  bill_dt <- .maybe_as_dt(payload)
  bill_dt <- .coerce_numeric_cols(bill_dt, c("id", "amount"))
  .normalize_time_cols(bill_dt, "createDate")
}
