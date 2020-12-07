decs922
================
Robert McDonald

This is a small package for the class Data Exploration, DECS-922, at the
[Kellogg School of Management](https://www.kellogg.northwestern.edu/).
The package currently contains

-   templates to produce slides and homework assignments; upon package
    installation these are automatically available from RStudio’s
    `rmarkdown` templates list.
-   the function `colorkey`, which assists with finding an appropriate
    colorname as defined by R.

For example, to find a version of “orange” which does not contain “red”
in the color name, do this:

``` r
library(decs922)
colorkey(colortext = 'orange', excludetext = 'red')
```

<img src="README_files/figure-gfm/unnamed-chunk-1-1.png" width="70%" />
