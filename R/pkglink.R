#' @title pkglink
#' @description provides Rmarkdown-formatted CRAN link for a given
#'     quoted package name
#'
#' \code{pkglink(pkgname)}
#' @name pkglink
#' @return String containing hyperlink to CRAN page for the given
#'     package
#' @param pkgname Quoted package name
#'
#' @examples
#' \dontrun{
#'
#' ## Create inline hyperlink
#' `r pkglink('dplyr')`
#' ## Create multiple inline hyperlinks, in alphabetical order
#' `r lapply(sort(c('dplyr', 'ggplot2', 'derivmkts')), pkglink)`
#' #' ## Create multiple inline hyperlinks in supplied order
#' `r knitr::combine_words(lapply(c('dplyr', 'ggplot2', 'derivmkts'), pkglink))`
#' }


#' @export
pkglink = function(pkgname) {
    paste('[', pkgname, '](http://cran.r-project.org/web/packages/',
          pkgname,'/index.html)', sep='')
}
