context("wordle_assist")

test_that("wordle_assist returns correct words",  {
    expect_equal(wordle_assist(no = 'areuntilcumpgjw',
                               yes = list(s = c(1, -4), h = 2, o = 3)),
                 c('shook', 'shoos'))
})
