library(testthat)
library(binxr)

if (inherits(try(loadNamespace("waldo"), silent = TRUE), "try-error")) {
  assignInNamespace(
    "waldo_compare",
    function(x, y, ..., x_arg = "x", y_arg = "y") {
      if (identical(x, y)) {
        character()
      } else {
        paste0(x_arg, " is not identical to ", y_arg)
      }
    },
    ns = "testthat"
  )
}

test_check("binxr")
