#' @title data_summary
#'
#' @description \code{data_summary} reports, for a data frame, the
#'     number of observations, number of missing, class of each
#'     variable, and summary statistics, including mean, standard
#'     deviation, and various quantiles, including the minimum,
#'     median, and maximum.
#'
#' \code{data_summary(d)}
#'
#' @name data_summary
#'
#' @importFrom stats sd quantile
#' @return By default creates a plot and otherwise returns
#'     nothing. Assigned output is a character vector of the matching
#'     color names.
#'
#' @param d A data frame
#' @param numdigits number of digits for formatted output
#' @usage data_summary(d, numdigits)
#'
#' @examples
#'
#' data_summary(iris)
#'


num_summaries <- function(dcol, fns_to_compute,
                          numdigits = 3) {
    probs <- c(0, .05,  .25,  .5,  .75,  .95, 1)
    names(probs) <- c('Minimum', '5% quantile', '25% quantile',
                      'Median', '75% quantile', '95% quantile',
                      'Maximum')
    isposix <- grepl('POSIX',  class(dcol))[1]
    isnumeric <- grepl('numeric|integer', class(dcol))[1]
    if (isposix | isnumeric) {
        outf <-
            mapply(function(foo, ...)
                if (isposix) {
                    foo(dcol, na.rm = TRUE)
                } else {
                    round(foo(dcol, na.rm = TRUE),
                          digits = numdigits)
                },
                fns_to_compute, SIMPLIFY = TRUE)
        outq <- quantile(dcol, probs = probs, na.rm = TRUE)
        ##if (isposix) outq <- as.Date(as.numeric(outq),  origin = '1970-1-1' )
        names(outq) <- names(probs)
        out <- c(outf, outq)
    } else {
        out <- rep(NA, length(fns_to_compute)+length(probs))
        names(out) <- c(names(fns_to_compute), names(probs))
    }
    return(out)
}


#' @export
data_summary <- function(d, numdigits = 3) {
    fns_to_compute = c(Mean = mean,
                       StdDev = sd)
    N <- mapply(length, d, SIMPLIFY = TRUE)
    Unique <- mapply(function(x) length(unique(x)), d, SIMPLIFY = TRUE)
    Missing <- mapply(function(x) sum(is.na(x)),  d)
    Class <- mapply(function(x) paste(class(x), collapse = ' + '), d)
    out <- mapply(function(x) num_summaries(x, fns_to_compute, numdigits), d)
    return(as.data.frame(rbind(N, Unique, Missing, Class, out)))
}

