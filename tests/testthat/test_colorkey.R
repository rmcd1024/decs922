context("Colorkey name filters")

test_that("colorkey filters colors correctly",  {
    expect_equal(colorkey('orange'),
                 grep('orange', colors(), value = TRUE))
    expect_equal(colorkey('', excludetext = 'grey'),
                 grep('grey', colors(), invert = TRUE,  value = TRUE))
})
