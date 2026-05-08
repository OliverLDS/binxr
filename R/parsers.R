#' (Optional) Coerce account to data.frames
#' @param account get_account() result
#' @return list(assets=..., positions=...)
#' @examples
#' account <- list(
#'   assets = list(list(asset = "USDT", walletBalance = "10")),
#'   positions = list(list(symbol = "ETHUSDT", positionAmt = "0"))
#' )
#' coerce_account_frames(account)
#' @export
coerce_account_frames <- function(account) {
  to_df <- function(x) {
    if (!length(x)) {
      return(data.frame())
    }
    jsonlite::fromJSON(jsonlite::toJSON(x), simplifyDataFrame = TRUE)
  }
  list(assets = to_df(account$assets), positions = to_df(account$positions))
}
