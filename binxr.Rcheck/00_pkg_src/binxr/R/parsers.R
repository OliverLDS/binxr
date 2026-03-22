#' (Optional) Coerce account to data.frames
#' @param account get_account() result
#' @return list(assets=..., positions=...)
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
