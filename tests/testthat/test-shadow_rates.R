data("us_yield_curve")
sr <- shadow_rates(us_yield_curve, maturity, rates)

test_that("shadow_rates works", {
  expect_s3_class(sr, "tbl")
  expect_equal(ncol(sr), 3L)
  expect_equal(nrow(sr), 55566L)
})
