## By sourcing this file, you can set `allitalic` as the chunk type
## (instead of `r`) and the text in the chunk will render in all
## italic.

## This seems to work with bullets
knitr::knit_engines$set(allitalic = function(options, debug = TRUE) {
    ## the source code is in options$code
    ## Still have to look for bullets and handle them as a special case.
    ##
    ## A line is either first in a group, last in a group, or in the middle
    ## The group can be text or bullet
    ##
    ## Convert multi-line bullet text into one long line
    charset <- "[[:alnum:][:punct:]]"
    itemstr <- "^\\s*[-\\*|0-9].?\\s+"
    tmp <- options
    if (debug) save(tmp, file = '/tmp/Rdata.rds')
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

    ## Get rid of white space at beginning of non-item lines
    dummy <- !options$isitem & !options$isitem2 & !options$blank

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

