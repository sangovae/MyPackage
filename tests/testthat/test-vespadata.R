test_that("Whether vespa_data works with a single year as input", {
  year = sample(seq(2017,2024), 1)
  expect_no_condition(vespa_data(year))
})
