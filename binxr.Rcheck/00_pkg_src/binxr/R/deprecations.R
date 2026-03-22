#' @noRd
.binxr_deprecate_alias <- function(old, new) {
  .Deprecated(new = new, package = "binxr", old = old)
  invisible(NULL)
}
