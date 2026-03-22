#' @noRd
.binance_server_time <- function(config) {
  .validate_public_config(config)

  path <- switch(
    config$product,
    spot = "/api/v3/time",
    futures = "/fapi/v1/time",
    options = "/eapi/v1/time",
    stop(sprintf("Unsupported product `%s`.", config$product), call. = FALSE)
  )

  .request_public(config, path)$serverTime
}

#' @noRd
.request_public <- function(config, path, query = NULL) {
  .validate_public_config(config)
  .validate_scalar_character(path, "path")

  req <- httr2::request(paste0(config$base_url, path)) |>
    httr2::req_timeout(config$timeout)

  if (!is.null(query)) {
    req <- httr2::req_url_query(req, !!!.compact_query(query))
  }

  .perform_request(req, method = "GET", endpoint = path, product = config$product)
}

#' @noRd
.request_signed <- function(config, path, params = NULL, method = c("GET", "POST", "PUT", "DELETE")) {
  .validate_signed_config(config)
  .validate_scalar_character(path, "path")
  method <- match.arg(method)

  params <- .compact_query(params %||% list())
  if (is.null(params$recvWindow)) {
    params$recvWindow <- config$recv_window
  }
  if (is.null(params$timestamp)) {
    params$timestamp <- .binance_server_time(config)
  }

  signature <- .build_signature(config$secret_key, params)

  req <- httr2::request(paste0(config$base_url, path)) |>
    httr2::req_timeout(config$timeout) |>
    httr2::req_headers("X-MBX-APIKEY" = config$api_key) |>
    httr2::req_method(method) |>
    httr2::req_url_query(!!!params, signature = signature)

  .perform_request(req, method = method, endpoint = path, product = config$product)
}

#' @noRd
.perform_request <- function(req, method, endpoint, product) {
  resp <- tryCatch(httr2::req_perform(req), error = function(e) e)
  .parse_response(resp, endpoint = endpoint, method = method, product = product)
}

#' @noRd
.build_signature <- function(secret, params) {
  payload <- .encode_query(params)
  digest::hmac(key = secret, object = payload, algo = "sha256")
}

#' @noRd
.compact_query <- function(params) {
  if (is.null(params)) {
    return(list())
  }
  if (!is.list(params)) {
    stop("`params`/`query` must be a named list.", call. = FALSE)
  }
  keep <- !vapply(params, is.null, logical(1))
  params[keep]
}

#' @noRd
.encode_query <- function(params) {
  params <- .compact_query(params)
  if (!length(params)) {
    return("")
  }

  names(params) <- names(params) %||% rep.int("", length(params))
  pieces <- Map(
    function(key, value) {
      if (length(value) != 1L) {
        stop(sprintf("Query parameter `%s` must have length 1.", key), call. = FALSE)
      }
      paste0(
        utils::URLencode(key, reserved = TRUE),
        "=",
        utils::URLencode(as.character(value), reserved = TRUE)
      )
    },
    names(params),
    params
  )
  paste(unlist(pieces, use.names = FALSE), collapse = "&")
}

#' @noRd
.parse_response <- function(resp, endpoint = NA_character_, method = NA_character_, product = NA_character_) {
  if (inherits(resp, "httr2_response")) {
    status <- httr2::resp_status(resp)
    body <- tryCatch(httr2::resp_body_string(resp), error = function(e) "")

    if (status >= 200 && status < 300) {
      if (!nzchar(body)) {
        return(list())
      }
      return(httr2::resp_body_json(resp, simplifyVector = FALSE))
    }

    payload <- tryCatch(jsonlite::fromJSON(body, simplifyVector = FALSE), error = function(e) NULL)
    code <- payload$code %||% NA
    msg <- payload$msg %||% body %||% "Unknown Binance API error"

    stop(
      structure(
        list(
          message = sprintf(
            "%s %s failed [%s] code=%s: %s",
            method %||% "HTTP",
            endpoint %||% "<unknown>",
            status,
            code,
            msg
          ),
          status = status,
          code = code,
          api_message = msg,
          endpoint = endpoint,
          method = method,
          product = product
        ),
        class = c("binxr_api_error", "error", "condition")
      )
    )
  }

  if (inherits(resp, "error")) {
    stop(
      structure(
        list(
          message = conditionMessage(resp),
          endpoint = endpoint,
          method = method,
          product = product
        ),
        class = c("binxr_transport_error", "error", "condition")
      )
    )
  }

  stop("Unknown response type.", call. = FALSE)
}

#' @noRd
.binxr_now <- function(config) {
  .binance_server_time(config)
}

#' @noRd
.signed_req <- function(config, endpoint, params, method = c("GET", "POST", "PUT", "DELETE")) {
  .request_signed(config, endpoint, params = params, method = method)
}

#' @noRd
.public_get <- function(config, path, query = NULL) {
  .request_public(config, path, query = query)
}

#' @noRd
.qs_build <- function(kv) {
  .encode_query(kv)
}

#' @noRd
.hmac256 <- function(secret, msg) {
  digest::hmac(key = secret, object = msg, algo = "sha256")
}
