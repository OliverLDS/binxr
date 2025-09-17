#' Round price and quantity to exchange increments
#'
#' @param exchangeInfo list Exchange info from `get_fapi_exchange_info()`.
#' @param symbol character Trading pair symbol, e.g., "ETHUSDT".
#' @param price numeric|NULL Price to round (tick size applied).
#' @param quantity numeric|NULL Quantity to round (step size applied).
#' @param round_dir character Direction: "down" or "up".
#' @return list A list with elements `price` and `quantity`.
#' @export
util_round_price_qty <- function(exchangeInfo, symbol, price = NULL, quantity = NULL, round_dir = c("down","up")) {
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
    if (round_dir == "down") floor((x + 1e-12)/inc) * inc
    else                     ceiling((x - 1e-12)/inc) * inc
  }
  list(price = round_inc(price, tick), quantity = round_inc(quantity, step))
}
