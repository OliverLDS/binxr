#' Create a Binance futures configuration
#'
#' @param api_key character API key. Leave `NULL` for unsigned/public requests.
#' @param secret_key character Secret key. Leave `NULL` for unsigned/public requests.
#' @param base_url character Base URL for the Binance Futures API.
#' @param recv_window integer recvWindow in milliseconds used for signed requests.
#' @param timeout numeric request timeout in seconds.
#' @param verbose logical whether to enable verbose request debugging in future helpers.
#'
#' @return A `binxr_config` list.
#' @export
config_futures <- function(
    api_key = Sys.getenv("BINX_API_KEY", unset = ""),
    secret_key = Sys.getenv("BINX_SECRET_KEY", unset = ""),
    base_url = "https://fapi.binance.com",
    recv_window = 10000L,
    timeout = 30,
    verbose = FALSE) {
  .new_config(
    product = "futures",
    api_key = api_key,
    secret_key = secret_key,
    base_url = base_url,
    recv_window = recv_window,
    timeout = timeout,
    verbose = verbose
  )
}

#' Create a Binance spot configuration
#'
#' @param api_key character API key. Leave `NULL` for unsigned/public requests.
#' @param secret_key character Secret key. Leave `NULL` for unsigned/public requests.
#' @param base_url character Base URL for the Binance Spot API.
#' @param recv_window integer recvWindow in milliseconds used for signed requests.
#' @param timeout numeric request timeout in seconds.
#' @param verbose logical whether to enable verbose request debugging in future helpers.
#'
#' @return A `binxr_config` list.
#' @export
config_spot <- function(
    api_key = Sys.getenv("BINX_API_KEY", unset = ""),
    secret_key = Sys.getenv("BINX_SECRET_KEY", unset = ""),
    base_url = "https://api.binance.com",
    recv_window = 10000L,
    timeout = 30,
    verbose = FALSE) {
  .new_config(
    product = "spot",
    api_key = api_key,
    secret_key = secret_key,
    base_url = base_url,
    recv_window = recv_window,
    timeout = timeout,
    verbose = verbose
  )
}

#' Backward-compatible futures config constructor
#'
#' @inheritParams config_futures
#' @return A `binxr_config` list.
#' @export
binxr_config_futures <- function(
    api_key = Sys.getenv("BINX_API_KEY", unset = ""),
    secret_key = Sys.getenv("BINX_SECRET_KEY", unset = ""),
    base = "https://fapi.binance.com",
    recvWindow = 10000L) {
  config_futures(
    api_key = api_key,
    secret_key = secret_key,
    base_url = base,
    recv_window = recvWindow
  )
}

#' Backward-compatible spot config constructor
#'
#' @inheritParams config_spot
#' @return A `binxr_config` list.
#' @export
binxr_config_spot <- function(
    api_key = Sys.getenv("BINX_API_KEY", unset = ""),
    secret_key = Sys.getenv("BINX_SECRET_KEY", unset = ""),
    base = "https://api.binance.com",
    recvWindow = 10000L) {
  config_spot(
    api_key = api_key,
    secret_key = secret_key,
    base_url = base,
    recv_window = recvWindow
  )
}

#' @noRd
.new_config <- function(
    product,
    api_key,
    secret_key,
    base_url,
    recv_window,
    timeout,
    verbose) {
  api_key <- .normalize_secret(api_key)
  secret_key <- .normalize_secret(secret_key)

  .validate_one_of(product, c("spot", "futures", "options"), "product")
  .validate_scalar_character(base_url, "base_url")
  .validate_positive_number(timeout, "timeout")
  .validate_positive_integerish(recv_window, "recv_window")
  .validate_scalar_logical(verbose, "verbose")

  structure(
    list(
      product = product,
      base_url = base_url,
      base = base_url,
      api_key = api_key,
      secret_key = secret_key,
      recv_window = as.integer(recv_window),
      recvWindow = as.integer(recv_window),
      timeout = as.numeric(timeout),
      verbose = verbose
    ),
    class = "binxr_config"
  )
}

#' @noRd
.normalize_secret <- function(x) {
  if (is.null(x) || identical(x, "")) {
    return(NULL)
  }
  .validate_scalar_character(x, deparse(substitute(x)))
  x
}
