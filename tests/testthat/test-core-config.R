test_that("public configs can be created without credentials", {
  cfg <- config_futures(api_key = "", secret_key = "")

  expect_s3_class(cfg, "binxr_config")
  expect_identical(cfg$product, "futures")
  expect_null(cfg$api_key)
  expect_null(cfg$secret_key)
  expect_equal(cfg$base_url, "https://fapi.binance.com")
})

test_that("signed config validation requires both credentials", {
  cfg <- config_spot(api_key = "", secret_key = "")

  expect_error(
    binxr:::.validate_signed_config(cfg),
    "Signed endpoints require both `api_key` and `secret_key`"
  )
})

test_that("legacy config constructors stay compatible", {
  cfg <- binxr_config_futures(api_key = "k", secret_key = "s")

  expect_identical(cfg$product, "futures")
  expect_identical(cfg$api_key, "k")
  expect_identical(cfg$secret_key, "s")
})
