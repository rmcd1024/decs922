#' @title knitr engine for italicizing chunk
#' @param options This is a list returned from the chunk and contains
#'     all chunk options (these are available as `code$eval`,
#'     `code$echo`, etc.along with the chunk contents (in
#'     options$code). Have to pass chunk options through this list
#'     rather than as arguments to the function.
#'
#' @description Engine to put entire chunk contents (no code) in
#'     italic. Use for problem set solutions. This engine is
#'     automatically available when the package is loaded (see
#'     `zzz.R`). In general the syntax for `knit_engines$set` has to
#'     match what's in `zzz.R`


#' @export
.soln_notes = function(options)
{
    ## the source code is in options$code
    ## Still have to look for bullets and handle them as a special case.
    ##
    ## A line is either first in a group, last in a group, or in the middle
    ## The group can be text or bullet
    ##
    ## Convert multi-line bullet text into one long line
    if (!options$echo) return()  ## don't process if no output
    
    if (is.null(options$debug)) options$debug <- FALSE
    if (is.null(options$title)) {
        title <- '\n ***Solution notes:*** '
    } else title <- options$title
    if (is.null(options$lines)) options$lines <- FALSE
    
    charset <- "[[:alnum:][:punct:]]"
    itemstr <- "^\\s*[-\\*|0-9].?\\s+"
    tmp <- options
    if (options$debug) save(tmp, file = '/tmp/Rdata.rds')
    a <- options$code
    ## identify blank and bullet lines
    options$blank <- !grepl(charset, a)
    options$isitem <- grepl(itemstr, a)

    ## get rid of white space in non-bullet lines
    a[!options$isitem] <- gsub('^\\s+', '', a[!options$isitem])

    ## identify item continuations on a second line
    for (i in seq_along(a)) {
        if (i == 1) {
            options$isitem2[i] <- FALSE
            next
        }
        if (options$isitem[i] | options$blank[i-1] | options$blank[i]) {
            options$isitem2[i] <- FALSE
        } else {
            options$isitem2[i] <-
                (options$isitem[i-1] | options$isitem2[i-1])
        }
    }

    ## Consolidate text for multi-line items
    for (i in rev(seq_along(a))) {
        if (options$isitem2[i]) {
            a[i-1] <- paste(a[i-1], a[i])
            a[i] <- ''
            options$blank[i] <- TRUE
        }
    }

    ## beginning of bullet
    a[options$isitem] <- gsub(paste0('^(', itemstr, ')(', charset, ')'),
                              '\\1\\*\\2', a[options$isitem])
    ## end of bullet
    a[options$isitem] <- gsub('\\s*$', '\\*\n', a[options$isitem])
    
    numlines <- length(options$code )
    ## Handle first line
    if (!options$blank[1] & !options$isitem[1])
        a[1] <- paste0('*',  a[1] )
    ## Handle last line
    if (!options$blank[numlines]) {
        a[numlines] <- paste0(a[numlines], '*')
        if (options$blank[numlines-1])
            a[numlines] <- gsub('^\\s*', '*', a[numlines])
    }

    ## Here: if a line is not blank and not an item and not followed
    ## by text, then we want to end it with a '*'
    for (i in seq_along(a)) {
        if (i %in% c(1, numlines)) next
        if (options$blank[i]) {
            a[[i]] <- '\n'
        } else {
            if (options$blank[min(i+1, numlines)] & !options$isitem[i])
                a[[i]] <- paste0(a[[i]],  '*\n')
            if (options$blank[i-1] & !options$isitem[i])
                a[[i]] <- paste0('*', a[[i]])
        }
        
    }
    a <- gsub('$', ' ', a)
    linestr <- ifelse(options$lines, '***', '')
    if (!is.null(title)) {
        a <- c(paste(linestr, '\n', title, ' '), a, '\n\n', linestr)
    } else {
        a <- c(paste(linestr, '\n', ' '), a, '\n\n', linestr)
    }
    options$code <- a
    if (options$debug) save(options,  file = '/tmp/Rdata2.rds')
    options$code
}


