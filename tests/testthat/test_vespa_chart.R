test_that("Does code run without error, warning, message, or other condition?", {
  expect_no_condition(vespa_chart(vespadata_2019_2021))
})
