test_that("maybe_as_dt returns data.table by default", {
  x <- list(
    list(symbol = "BTCUSDT", filters = list(list(filterType = "PRICE_FILTER"))),
    list(symbol = "ETHUSDT", filters = list(list(filterType = "LOT_SIZE")))
  )

  dt <- binxr:::.maybe_as_dt(x)

  expect_s3_class(dt, "data.table")
  expect_true(is.list(dt$filters))
  expect_equal(nrow(dt), 2L)
})

test_that("json_list flag preserves original parsed list", {
  x <- list(list(symbol = "BTCUSDT"))

  out <- binxr:::.maybe_as_dt(x, json_list = TRUE)

  expect_identical(out, x)
})
