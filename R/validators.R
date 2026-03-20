#' @noRd
.validate_scalar_character <- function(x, arg) {
  if (!is.character(x) || length(x) != 1L || is.na(x) || !nzchar(x)) {
    stop(sprintf("`%s` must be a non-empty character scalar.", arg), call. = FALSE)
  }
  invisible(x)
}

#' @noRd
.validate_optional_scalar_character <- function(x, arg) {
  if (is.null(x)) {
    return(invisible(x))
  }
  .validate_scalar_character(x, arg)
}

#' @noRd
.validate_scalar_logical <- function(x, arg) {
  if (!is.logical(x) || length(x) != 1L || is.na(x)) {
    stop(sprintf("`%s` must be TRUE or FALSE.", arg), call. = FALSE)
  }
  invisible(x)
}

#' @noRd
.validate_optional_scalar_numeric <- function(x, arg) {
  if (is.null(x)) {
    return(invisible(x))
  }
  if (!is.numeric(x) || length(x) != 1L || is.na(x)) {
    stop(sprintf("`%s` must be a numeric scalar when provided.", arg), call. = FALSE)
  }
  invisible(x)
}

#' @noRd
.validate_positive_number <- function(x, arg) {
  if (!is.numeric(x) || length(x) != 1L || is.na(x) || x <= 0) {
    stop(sprintf("`%s` must be a positive number.", arg), call. = FALSE)
  }
  invisible(x)
}

#' @noRd
.validate_positive_integerish <- function(x, arg) {
  if (!is.numeric(x) || length(x) != 1L || is.na(x) || x <= 0 || x != as.integer(x)) {
    stop(sprintf("`%s` must be a positive whole number.", arg), call. = FALSE)
  }
  invisible(x)
}

#' @noRd
.validate_required_any <- function(..., arg_names) {
  values <- list(...)
  present <- !vapply(values, is.null, logical(1))
  if (!any(present)) {
    stop(
      sprintf("Provide at least one of: %s.", paste(arg_names, collapse = ", ")),
      call. = FALSE
    )
  }
  invisible(TRUE)
}

#' @noRd
.validate_one_of <- function(x, choices, arg) {
  if (!is.character(x) || length(x) != 1L || is.na(x) || !(x %in% choices)) {
    stop(
      sprintf("`%s` must be one of: %s.", arg, paste(choices, collapse = ", ")),
      call. = FALSE
    )
  }
  invisible(x)
}

#' @noRd
.validate_symbol <- function(symbol, arg = "symbol") {
  .validate_scalar_character(symbol, arg)
}

#' @noRd
.validate_optional_character_vector <- function(x, arg) {
  if (is.null(x)) {
    return(invisible(x))
  }
  if (!is.character(x) || !length(x) || anyNA(x) || any(!nzchar(x))) {
    stop(sprintf("`%s` must be a non-empty character vector when provided.", arg), call. = FALSE)
  }
  invisible(x)
}

#' @noRd
.validate_at_most_one <- function(..., arg_names) {
  values <- list(...)
  present <- !vapply(values, is.null, logical(1))
  if (sum(present) > 1L) {
    stop(
      sprintf("Only one of %s may be supplied at a time.", paste(arg_names, collapse = ", ")),
      call. = FALSE
    )
  }
  invisible(TRUE)
}

#' @noRd
.validate_config <- function(config, arg = "config") {
  if (!inherits(config, "binxr_config")) {
    stop(sprintf("`%s` must be created by a binxr config constructor.", arg), call. = FALSE)
  }
  invisible(config)
}

#' @noRd
.validate_public_config <- function(config) {
  .validate_config(config)
  invisible(config)
}

#' @noRd
.validate_signed_config <- function(config) {
  .validate_config(config)
  if (is.null(config$api_key) || is.null(config$secret_key)) {
    stop(
      "Signed endpoints require both `api_key` and `secret_key` in `config`.",
      call. = FALSE
    )
  }
  invisible(config)
}

#' @noRd
.validate_json_list_flag <- function(json_list) {
  .validate_scalar_logical(json_list, "json_list")
}
