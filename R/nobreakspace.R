#' @title Non-breaking spaces
#' @description Inserts non-breaking space in Rmarkdown. 
#'
#' \code{nbsp(str, verb=TRUE)}
#' @name nbsp
#' @return Replaces spaces with `&nbsp;` and optionally formats as
#'     verbatim
#' @param str Character string
#' @param verb Boolean to quote as verbatim
#'
#' @examples
#' \dontrun{
#'
#' ## Create inline hyperlink
#' s = "File|Import Dataset"
#' `r nbsp(s)`
#' `r nbsp(s, verb=FALSE)`
#' }


#' @export
nbsp <- function(str, verb = TRUE) {
    substr <- '&nbsp;'
    substrverb <- '`&nbsp;`'
    if (verb) {
        str <- gsub(' ', substrverb, str)
    } else {
        str <- gsub(' ', substr, str)
    }
    return(str)
}
