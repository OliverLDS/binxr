#' Get Binance server time (ms)
#'
#' @param config list binxr configuration.
#' @return numeric Server time in milliseconds.
#' @noRd
.binxr_now <- function(config) {
  req <- httr2::request(paste0(config$base, "/fapi/v1/time"))
  httr2::resp_body_json(httr2::req_perform(req))$serverTime
}

#' Build query string from named list
#'
#' @param kv list Named list of parameters; NULL values are skipped.
#' @return character Query string without leading '?'.
#' @noRd
.qs_build <- function(kv) {
  keys <- names(kv)
  keys <- keys[!vapply(kv, is.null, TRUE)]
  paste(vapply(keys, function(k) paste0(k, "=", kv[[k]]), character(1L)), collapse = "&")
}

#' HMAC-SHA256 helper
#'
#' @param secret character Secret key.
#' @param msg character Message to sign.
#' @return character Hex digest.
#' @noRd
.hmac256 <- function(secret, msg) {
  digest::hmac(key = secret, object = msg, algo = "sha256")
}

#' Perform signed request to Binance
#'
#' @param config list binxr configuration.
#' @param endpoint character API endpoint path (e.g., "/fapi/v1/order").
#' @param params list Query/body parameters.
#' @param method character HTTP method, one of "GET", "POST", "DELETE".
#' @return list Parsed JSON response.
#' @noRd
.signed_req <- function(config, endpoint, params, method = c("GET", "POST", "DELETE")) {
  method <- match.arg(method)
  # add recvWindow & timestamp if not given
  if (is.null(params$recvWindow)) params$recvWindow <- config$recvWindow
  if (is.null(params$timestamp)) params$timestamp <- .binxr_now(config)
  qs <- .qs_build(params)
  sig <- .hmac256(config$secret_key, qs)
  url <- paste0(config$base, endpoint, "?", qs, "&signature=", sig)
  req <- httr2::request(url) |>
    httr2::req_headers("X-MBX-APIKEY" = config$api_key) |>
    httr2::req_method(method)
  resp <- tryCatch(httr2::req_perform(req), error = function(e) e)
  .parse_response(resp)
}

#' Perform public GET request
#'
#' @param config list binxr configuration.
#' @param path character API path (e.g., "/fapi/v1/time").
#' @param query list Optional query parameters.
#' @return list Parsed JSON response.
#' @noRd
.public_get <- function(config, path, query = NULL) {
  url <- paste0(config$base, path)
  if (!is.null(query) && length(query)) {
    qs <- .qs_build(query)
    url <- paste0(url, "?", qs)
  }
  resp <- tryCatch(httr2::req_perform(httr2::request(url)), error = function(e) e)
  .parse_response(resp)
}

#' Parse httr2 response or raise error
#'
#' @param resp httr2_response or error.
#' @return list Parsed JSON on success; otherwise throws an error.
#' @noRd
.parse_response <- function(resp) {
  if (inherits(resp, "httr2_response")) {
    status <- httr2::resp_status(resp)
    if (status >= 200 && status < 300) {
      return(httr2::resp_body_json(resp))
    }
    # try parse binance error
    body <- try(httr2::resp_body_string(resp), silent = TRUE)
    msg <- paste0("HTTP ", status)
    if (!inherits(body, "try-error") && nzchar(body)) {
      jb <- try(jsonlite::fromJSON(body), silent = TRUE)
      if (!inherits(jb, "try-error") && length(jb)) {
        if (!is.null(jb$code) || !is.null(jb$msg)) {
          msg <- paste0(msg, " | code=", jb$code %||% "?", ", msg=", jb$msg %||% body)
        } else {
          msg <- paste0(msg, " | ", body)
        }
      }
    }
    stop(msg, call. = FALSE)
  } else if (inherits(resp, "error")) {
    stop(conditionMessage(resp), call. = FALSE)
  } else {
    stop("Unknown response type", call. = FALSE)
  }
}


#' Create binxr futures config
#'
#' @param api_key character API key.
#' @param secret_key character Secret key.
#' @param base character Base URL for Binance Futures API.
#' @param recvWindow integer recvWindow in milliseconds.
#' @return list Configuration list for futures requests.
#' @export
binxr_config_futures <- function(
    api_key = Sys.getenv("BINX_API_KEY"),
    secret_key = Sys.getenv("BINX_SECRET_KEY"),
    base = "https://fapi.binance.com",
    recvWindow = 10000) {
  stopifnot(nzchar(api_key), nzchar(secret_key))
  list(api_key = api_key, secret_key = secret_key, base = base, recvWindow = recvWindow)
}

#' Create binxr spot config
#'
#' @param api_key character API key.
#' @param secret_key character Secret key.
#' @param base character Base URL for Binance Spot API.
#' @param recvWindow integer recvWindow in milliseconds.
#' @return list Configuration list for spot requests.
#' @export
binxr_config_spot <- function(
    api_key = Sys.getenv("BINX_API_KEY"),
    secret_key = Sys.getenv("BINX_SECRET_KEY"),
    base = "https://api.binance.com",
    recvWindow = 10000) {
  stopifnot(nzchar(api_key), nzchar(secret_key))
  list(api_key = api_key, secret_key = secret_key, base = base, recvWindow = recvWindow)
}
