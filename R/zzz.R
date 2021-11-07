
##.onLoad <- function(libname, pkgname){
##    knitr::knit_engines$set(soln_notes = soln_notes)
##}
##

.onAttach <- function(libname, pkgname){
    packageStartupMessage('Loading soln_notes chunk engine')
    knitr::knit_engines$set(soln_notes = .soln_notes)
}


