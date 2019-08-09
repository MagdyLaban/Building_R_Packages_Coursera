test_that("filename validation", {
    filename <- make_filename(2015)
    dataframe <- fars_read(filename)
    expect_that(dataframe, is_a("tbl_df"))
    expect_that(nrow(dataframe), is_more_than(0))
})
