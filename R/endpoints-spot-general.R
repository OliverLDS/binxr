#' Test Binance Spot API connectivity
#'
#' @param config A spot configuration created by [config_spot()].
#'
#' @return An empty parsed list on success.
#' @export
spot_ping <- function(config = config_spot()) {
  .request_public(config, "/api/v3/ping")
}

#' Get Binance Spot server time
#'
#' @param config A spot configuration created by [config_spot()].
#'
#' @return A `POSIXct` timestamp.
#' @export
spot_get_server_time <- function(config = config_spot()) {
  .ms_to_datetime(.binance_server_time(config))
}

#' Get Binance Spot exchange information
#'
#' @param symbol Optional trading pair symbol.
#' @param symbols Optional character vector of trading pair symbols.
#' @param permissions Optional character vector of permission strings.
#' @param show_permission_sets Logical flag forwarded as `showPermissionSets`.
#' @param symbol_status Optional trading status filter.
#' @param config A spot configuration created by [config_spot()].
#'
#' @return A parsed list.
#' @export
spot_get_exchange_info <- function(
    symbol = NULL,
    symbols = NULL,
    permissions = NULL,
    show_permission_sets = TRUE,
    symbol_status = NULL,
    config = config_spot()) {
  .validate_optional_scalar_character(symbol, "symbol")
  .validate_optional_character_vector(symbols, "symbols")
  .validate_optional_character_vector(permissions, "permissions")
  .validate_scalar_logical(show_permission_sets, "show_permission_sets")
  .validate_optional_scalar_character(symbol_status, "symbol_status")

  if (!is.null(symbol_status) && (!is.null(symbol) || !is.null(symbols))) {
    stop("`symbol_status` cannot be used with `symbol` or `symbols`.", call. = FALSE)
  }

  payload <- .request_public(
    config,
    "/api/v3/exchangeInfo",
    query = list(
      symbol = symbol,
      symbols = .json_array_param(symbols),
      permissions = .json_array_param(permissions),
      showPermissionSets = tolower(as.character(show_permission_sets)),
      symbolStatus = symbol_status
    )
  )

  if (!is.null(payload$symbols) && is.list(payload$symbols) && all(vapply(payload$symbols, is.list, logical(1)))) {
    names(payload$symbols) <- vapply(payload$symbols, `[[`, "", "symbol")
  }
  payload
}

#' Get Binance Spot execution rules
#'
#' @param symbol Optional trading pair symbol.
#' @param symbols Optional character vector of trading pair symbols.
#' @param symbol_status Optional trading status filter.
#' @param config A spot configuration created by [config_spot()].
#'
#' @return A parsed list.
#' @export
spot_get_execution_rules <- function(
    symbol = NULL,
    symbols = NULL,
    symbol_status = NULL,
    config = config_spot()) {
  .validate_optional_scalar_character(symbol, "symbol")
  .validate_optional_character_vector(symbols, "symbols")
  .validate_optional_scalar_character(symbol_status, "symbol_status")
  .validate_at_most_one(symbol, symbols, symbol_status, arg_names = c("symbol", "symbols", "symbol_status"))

  .request_public(
    config,
    "/api/v3/executionRules",
    query = list(
      symbol = symbol,
      symbols = .json_array_param(symbols),
      symbolStatus = symbol_status
    )
  )
}

#' @noRd
.json_array_param <- function(x) {
  if (is.null(x)) {
    return(NULL)
  }
  jsonlite::toJSON(unname(x), auto_unbox = FALSE)
}
