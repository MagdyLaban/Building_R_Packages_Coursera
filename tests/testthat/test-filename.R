test_that("filename validation", {
    fn <- make_filename(2013)
    df <- fars_read(fn)
    expect_that(df, is_a('tbl_df'))
    expect_that(nrow(df), is_more_than(0))
})
