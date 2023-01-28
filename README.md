decs922 R package
================

This is a package of odds and ends originally created for the class Data
Exploration, DECS-922, now DECS-461, at the [Kellogg School of
Management](https://www.kellogg.northwestern.edu/).

    ## Loading soln_notes chunk engine

# Document production

-   Templates to perform routine setup steps to produce beamer slides
    and pdf homework assignments. Upon package installation these become
    automatically available from RStudio’s `rmarkdown` templates list,
    as templates named “`decs922 Beamer presentation`” and
    “`decs922   homework submissions`”.

    Note that the `decs922 homework submission` template contains a
    mini-tutorial concerning aspects of producing a document with
    markdown, including examples of cross-referencing of tables and
    figures.

-   A `knitr` chunk engine, `soln_notes`, which allows you to insert
    optional text within a standalone chunk with the engine
    `soln_notes`. When evaluated, the text will be rendered in italic
    and (by default) preceded by `Solution notes:`. The goal is to make
    it easier to create homework solutions. The implementation is
    currently functional but buggy.

-   **`nbsp`** which takes a string as input and returns the string with
    spaces replaced by non-breaking spaces.

# Utility functions

-   **`translate_datestr`** parses a string for POSIX date codes and
    returns documentation for the codes (taken from `?strftime`).

    ``` r
    translate_datestr('%Y-%M-%d')
    ```

        ##   abbrevs category                           short_description
        ## 1      %d      day Day of the month as decimal number (01-31).
        ## 2      %M     time           Minute as decimal number (00-59).
        ## 3      %Y     year                          Year with century.

-   **`data_summary`** reports for a data set the number of
    observations, number of missing values, the class of each variable,
    and various summary statistics. I view this as pedagogical, as there
    are *many* similar functions available, such as `summary`,
    `psych::describe`, etc. Using the built-in dataset `iris`:

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

-   **`wordle_assist`** finds 5-letter words that match against excluded
    letters and positional included letters (a vector named with the
    letter, with positive values specifying confirmed positions and
    negative values specifying positional exclusions). The function
    matches against the length-5 words in the [`words`
    package](https://CRAN.R-project.org/package=words). For example,
    suppose you have played `arose`, `until` and `chump`, and you’ve
    learned that there is an `s` in position 1 but not in position 4;
    there is an `h` in position 2; and there is an `o` in position 3.
    Enter that information like this:

    ``` r
    wordle_assist(no = 'areuntilcump', yes = list(s = c(1, -4), h = 2, o = 3))
    ```

        ## [1] "shogs" "shojo" "shook" "shoos" "shows" "showy"

    The function returns the remaining possible words.

-   **`wordle_sub`** given 1 to 5 letters, return 5-letter words
    containing those letters, in any order.

    ``` r
    wordle_sub(ltrs='cawk')
    ```

        ## [1] "wacke" "wacko" "wacks" "wacky" "whack" "wrack"

-   **`colorkey`** given a regex, returns matching values from
    `colors()`. For example, to find a version of “orange” which does
    not contain “red” in the color name:

    ``` r
    colorkey(colortext = 'orange', excludetext = 'red')
    ```

    <img src="README_files/figure-gfm/unnamed-chunk-6-1.png" width="70%" />
