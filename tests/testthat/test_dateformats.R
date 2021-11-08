context("dateformats")

testin <- '%Y-%M-%d'
testv <- c('%Y', '%M', '%d' )
testout <- data.frame(abbrevs = c("%d", "%M", "%Y"),
                      category = c("day", "time", "year"),
                      short_description = c("Day of the month as decimal number (01-31).",
                                            "Minute as decimal number (00-59).",
                                            "Year with century."),
                      row.names = NULL)

testouttd <- translate_datestr(testin)
rownames(testouttd) <- NULL

testp_d_f <- posix_dt_format(syms = testv)
rownames(testp_d_f) <- NULL
test_that("dateformats returns correct dataframe",  {
    expect_equal(testouttd, testout)
    expect_equal(testp_d_f, testout)
})
