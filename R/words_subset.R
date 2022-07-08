#' @title words_subset
#'
#' @description \code{words_subset} returns 5-letter words that
#'     contain specified letters. Error if more than 5 letters are
#'     supplied
#'
#' @name words_subset
#'
#' @return Returns a vector of 5-letter words meeting supplied match
#'     criteria
#'
#' @param ltrs letters in the word. These should be specified as a
#'     character string, for example, \code{'aeontfd'}
#'
#' @param words vector of admissible possible words. By default, uses
#'     the length-5 words from the `words` package.
#'
#' @examples
#'
#' words_subset(ltrs = 'cawk')
#'
#'


#' @export
words_subset <- function(ltrs = NULL, words = words5) {
    lltrs <- nchar(ltrs)
    if (lltrs > 0 && lltrs < 6) {
        tmp <- words5
        ltrsv <- strsplit(ltrs, '')[[1]]
        for (i in ltrsv) {
            tmp <- grep(i, tmp, value = TRUE)
        }
    } else {
        stop('Number of letters must be between 1 and 5, inclusive')
    }
    tmp
}


