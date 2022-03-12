#' @title colorkey
#'
#' @description \code{colorkey} produces a plot showing all standard R
#'     colornames (as returned by \code{colors}) matching a regular
#'     expression. Matching is case insensitive. If output is assigned
#'     to a variable, the variable contains the list of colors. By
#'     default, returns all colors.
#'
#' \code{colorkey(colortext)}
#' 
#' @name colorkey
#'
#' @importFrom grDevices colors
#' @importFrom graphics par text
#' @importFrom stats na.omit
#' @return By default creates a plot and otherwise returns
#'     nothing. Assigned output is a character vector of the matching
#'     color names.
#'
#' @param colortext Regular expression to match values returned by
#'     \code{colors()}
#' @param excludetext Regular expression to match values to be
#'     \emph{excluded} from the list created by filtering on
#'     \code{colortext}. 
#' @usage colorkey(colortext, excludetext)
#'
#' 
#' @examples
#' \dontrun{
#'
#' ## color names containing "red"
#' colorkey('blue')
#' colorkey('blue', excludetext = 'light|dark')
#' ## color names containing "red" but  
#' ## color names starting with "bl" or "gr"
#' colorkey('^(gr)|^(bl)')
#' 
#' ## plots colors starting with "bl" and then either "u" or "a", and
#' ## returns the name in the variable `namelist`
#' namelist <- colorkey('^bl[ua]')
#' 
#' }

#' @export
colorkey <- function(colortext='', excludetext = '') {
    cols <- grep(colortext, grDevices::colors(), value=TRUE,
                 ignore.case = TRUE)
    title_excl_str <- ''
    if (excludetext != '') {
        cols <- grep(excludetext, cols, invert = TRUE, value = TRUE,
                     ignore.case = TRUE)
        title_excl_str <- paste0('and excluding "', excludetext, '"')
    }
    l = length(cols)
    wid = ceiling(sqrt(l))
    ht = ifelse(l <= wid*(wid-1), wid-1, wid)
    df <- data.frame(x=1:wid, y=1:(wid*ht), z=1:(wid*ht))
    cols <- c(cols, rep(NA, max(0, ht*wid-l)))
    size <- c(rep(10, l), rep(0, max(0, ht*wid-l)))
    par(mar = rep(2, 4))
    title <- paste0(l, ' colors containing "',
                    colortext, '" ', title_excl_str)
    plot(df$x, df$y, col = cols, cex = 4, pch = 20, xaxt = "n",
         yaxt = "n", xlim = c(0.5, wid+0.5), ylim = c(-2.5, ht*(ht+1)),
         main = title)
    text(df$x, df$y - 0.25*ht,  cols)
    return(invisible(as.vector(na.omit(cols))))
}
