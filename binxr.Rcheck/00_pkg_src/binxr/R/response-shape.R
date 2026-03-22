#' @noRd
.maybe_as_dt <- function(x, json_list = FALSE) {
  .validate_json_list_flag(json_list)
  if (isTRUE(json_list)) {
    return(x)
  }
  .as_dt_preserve_lists(x)
}

#' @noRd
.as_dt_preserve_lists <- function(x) {
  if (inherits(x, "data.table")) {
    return(data.table::copy(x))
  }

  if (is.data.frame(x)) {
    return(data.table::as.data.table(x))
  }

  if (is.list(x) && length(x) && all(vapply(x, is.list, logical(1)))) {
    return(data.table::rbindlist(x, fill = TRUE))
  }

  if (is.list(x)) {
    return(data.table::as.data.table(list(value = list(x))))
  }

  data.table::data.table(value = x)
}

#' @noRd
.normalize_time_cols <- function(dt, cols, tz = Sys.timezone()) {
  if (!inherits(dt, "data.table")) {
    dt <- data.table::as.data.table(dt)
  }

  for (col in intersect(cols, names(dt))) {
    data.table::set(
      dt,
      j = col,
      value = as.POSIXct(as.numeric(dt[[col]]) / 1000, origin = "1970-01-01", tz = tz)
    )
  }
  dt
}

#' @noRd
.coerce_numeric_cols <- function(dt, cols) {
  if (!inherits(dt, "data.table")) {
    dt <- data.table::as.data.table(dt)
  }

  for (col in intersect(cols, names(dt))) {
    data.table::set(dt, j = col, value = as.numeric(dt[[col]]))
  }
  dt
}

#' @noRd
.normalize_order_time_cols <- function(dt, tz = Sys.timezone()) {
  .normalize_time_cols(dt, c("time", "updateTime", "workingTime", "transactTime"), tz = tz)
}
