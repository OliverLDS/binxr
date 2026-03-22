test_that("query encoding preserves reserved characters safely", {
  encoded <- binxr:::.encode_query(list(symbol = "BTCUSDT", newClientOrderId = "id with spaces/and?chars"))

  expect_match(encoded, "^symbol=BTCUSDT&newClientOrderId=")
  expect_true(grepl("id%20with%20spaces%2Fand%3Fchars", encoded, fixed = TRUE))
})

test_that("parse_response surfaces structured API errors", {
  resp <- structure(
    list(),
    class = "httr2_response"
  )

  local_mocked_bindings(
    resp_status = function(x) 400L,
    resp_body_string = function(x) '{"code":-1102,"msg":"Mandatory parameter missing"}',
    .package = "httr2"
  )

  expect_error(
    binxr:::.parse_response(resp, endpoint = "/fapi/v1/order", method = "POST", product = "futures"),
    class = "binxr_api_error"
  )
})
