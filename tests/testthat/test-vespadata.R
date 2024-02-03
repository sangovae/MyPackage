test_that("Whether vespa_data works with a single year as input", {

  year = sample(seq(2017,2024))
  expect(dim(vespa_data(2017))!=0)

})
