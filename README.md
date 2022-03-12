decs922 R package
================
Robert McDonald

This is a package of odds and ends originally created for the class Data
Exploration, DECS-922, at the [Kellogg School of
Management](https://www.kellogg.northwestern.edu/). The package
currently contains

-   templates to produce slides and homework assignments; upon package
    installation these are automatically available from RStudio’s
    `rmarkdown` templates list. These are a work in progress

-   a chunk engine, `soln_notes`, which allows you insert optional text
    within a standalone chunk. When evaluated, the text will be rendered
    in italic and preceded (by default) by `Solution notes`. The
    implementation is functional but buggy.

-   the function `colorkey`, which assists with finding an appropriate
    colorname as defined by R. For example, to find a version of
    “orange” which does not contain “red” in the color name, do this:

    ``` r
    library(decs922)
    ```

        ## Loading soln_notes chunk engine

    ``` r
    colorkey(colortext = 'orange', excludetext = 'red')
    ```

    <img src="README_files/figure-gfm/unnamed-chunk-1-1.png" width="70%" />

-   the function `data_summary`, which reports for a data set the number
    of observations, number of missing values, the class of each
    variable, and various summary statistics. Note that there are many
    similar functions available, such as `summary`, `psych::describe`,
    etc. For example, using the built-in dataset `iris`:

    ``` r
    data_summary(iris)
    ```

        ##              Sepal.Length Sepal.Width Petal.Length Petal.Width Species
        ## N                     150         150          150         150     150
        ## Unique                 35          23           43          22       3
        ## Missing                 0           0            0           0       0
        ## Class             numeric     numeric      numeric     numeric  factor
        ## Mean                5.843       3.057        3.758       1.199    <NA>
        ## StdDev              0.828       0.436        1.765       0.762    <NA>
        ## Minimum               4.3           2            1         0.1    <NA>
        ## 5% quantile           4.6       2.345          1.3         0.2    <NA>
        ## 25% quantile          5.1         2.8          1.6         0.3    <NA>
        ## Median                5.8           3         4.35         1.3    <NA>
        ## 75% quantile          6.4         3.3          5.1         1.8    <NA>
        ## 95% quantile        7.255         3.8          6.1         2.3    <NA>
        ## Maximum               7.9         4.4          6.9         2.5    <NA>

-   the function `translate_datestr`, which parses a string for POSIX
    date codes and returns documentation for the codes (taken from
    `?strftime`).

    ``` r
    translate_datestr('%Y-%M-%d')
    ```

        ##   abbrevs category                           short_description
        ## 1      %d      day Day of the month as decimal number (01-31).
        ## 2      %M     time           Minute as decimal number (00-59).
        ## 3      %Y     year                          Year with century.

-   `wordle_assist`, which finds 5-letter words that match positional
    inclusions (positive named vector specifying position) and
    exclusions (negative named vector specifying positions. Relies on
    the length-5 words in the [`words`
    package](https://CRAN.R-project.org/package=words)

    ``` r
    wordle_assist(no = 'areuntilcump', yes = list(s = c(1, -4), h = 2, o = 3))
    ```

        ## [1] "shogs" "shojo" "shook" "shoos" "shows" "showy"
