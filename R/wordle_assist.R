#' @title wordle-assist
#'
#' @description \code{wordle-assist} returns 5-letter words that match
#'     included and excluded letter patterns.
#' @description \code{wordle_sub) returns 5-letter words that contain
#'     the letters specified in `ltrs` and without the letters in `no`
#'
#' @name wordle-assist
#'
#' @return Returns a vector of 5-letter words meeting supplied match
#'     criteria
#'
#' @param no letters not in the word. These should be specified as a
#'     character string, for example, \code{'aeontfd'}
#'
#' @param yes a list of letters included in the word, with positional
#'     information. Correct positions are positive integers and
#'     incorrect positions are negative integers. For example if "a"
#'     is in the second position and not in the fourth, and "y" is in
#'     the fifth, specify \code{yes = list(a = c(2, -4), y = 5)}
#' @param ltrs a character string containing letters that appear in
#'     the word. If more than 5 letters are supplied, will return the
#'     empty set
#'
#' @param words vector of admissible possible words. By default, uses
#'     the length-5 words from the `words` package.
#'
#' @examples
#'
#' wordle_assist(no = 'seuntilmp', yes = list(a = -1, r = -2, o = -3, c = -1, h = -2))
#' wordle_sub(ltrs = 'soar', no='fghbxwkl')
#'



#' @export
wordle_assist <- function(no = NULL, yes = NULL, words = words5) {
    testmode <- FALSE
    if (testmode) {
        no <- 'abc'
        yes <- list(d = c(1,  -2), y = c(-3, 5), e = -1, i = -1, t = -1)
        i <- 2
    }
    if (length(no) >= 1) {
        tmp <- grep(paste0('[', no, ']'), words, invert = TRUE, value = TRUE) 
    } else {
        tmp <- words
    }
    for (i in seq_along(yes)) {
        grid <- rep('.', 5)
        unknown_pos <- yes[[i]][yes[[i]]<0]
        if (length(unknown_pos) > 0) {
            ## all words that contain the letter
            tmp <- grep(names(yes[i]), tmp, value = TRUE)
            grid[-unknown_pos] <- paste0('[^', names(yes[i]), ']')
            ##print(grid)
            tmp <- grep(paste0(grid, collapse = ''), tmp, value = TRUE)
        }
        known_pos <- yes[[i]][yes[[i]]>0]
        if (length(known_pos > 0)) {
            grid[known_pos] <- names(yes[i])
            tmp <- grep(paste0(grid, collapse = ''), tmp, value = TRUE)
        }
    }
    tmp
}


#' @export
wordle_sub <- function(ltrs = 'arose', no = ' ', words = words5) {
    testmode <- FALSE
    if (testmode) {
        ltrs <- 'arose'
        no <- ''
    }
    possibles <- words
    for (i in strsplit(ltrs, split = '')[[1]]) {
        possibles <- grep(i, possibles,  value = TRUE)
    }
    possibles <- grep(paste0('[', no, ']'),  possibles, invert = TRUE, value = TRUE)
    possibles
}
