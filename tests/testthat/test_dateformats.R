context("dateformats")

testin <- '%Y-%M-%d'
testv <- c('%Y', '%M', '%d' )
testout <- data.frame(abbrevs = c("%d", "%M", "%Y"),
                      category = c("day", "time", "year"),
                      description = c("Day of the month as decimal number (01-31).",
                                      "Minute as decimal number (00-59).",
                                      "Year with century."))

test_that("dateformats returns correct dataframe",  {
    expect_equal(translate_datestr(testin),
                 testout)
    expect_equal(posix_dt_format(testv), testout)
})
