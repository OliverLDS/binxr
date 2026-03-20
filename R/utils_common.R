#' @import data.table
#' @importFrom rlang %||%
NULL

#' Convert milliseconds to POSIXct
#'
#' @param ms numeric Milliseconds since Unix epoch.
#' @return POSIXct Converted timestamp.
#' @noRd
.ms_to_datetime <- function(ms) {
  as.POSIXct(ms / 1000, origin = "1970-01-01", tz = Sys.timezone())
}
