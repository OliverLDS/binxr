#' Round price and quantity to exchange increments
#'
#' @param exchangeInfo Exchange info from [futures_get_exchange_info()].
#' @param symbol Trading pair symbol, for example `"ETHUSDT"`.
#' @param price Optional price to round using the symbol tick size.
#' @param quantity Optional quantity to round using the symbol step size.
#' @param round_dir Direction: `"down"` or `"up"`.
#'
#' @return A list with elements `price` and `quantity`.
#' @export
round_price_qty <- function(exchangeInfo, symbol, price = NULL, quantity = NULL, round_dir = c("down", "up")) {
  round_dir <- match.arg(round_dir)
  s <- exchangeInfo$symbols[[symbol]]
  if (is.null(s)) stop("symbol not found in exchangeInfo")
  tick <- 1
  step <- 1
  for (f in s$filters) {
    if (f$filterType == "PRICE_FILTER") tick <- as.numeric(f$tickSize)
    if (f$filterType == "LOT_SIZE") step <- as.numeric(f$stepSize)
  }
  round_inc <- function(x, inc) {
    if (is.null(x)) return(NULL)
    if (round_dir == "down") floor((x + 1e-12) / inc) * inc
    else ceiling((x - 1e-12) / inc) * inc
  }
  list(price = round_inc(price, tick), quantity = round_inc(quantity, step))
}

#' @rdname round_price_qty
#' @export
util_round_price_qty <- function(exchangeInfo, symbol, price = NULL, quantity = NULL, round_dir = c("down", "up")) {
  round_price_qty(
    exchangeInfo = exchangeInfo,
    symbol = symbol,
    price = price,
    quantity = quantity,
    round_dir = round_dir
  )
}
