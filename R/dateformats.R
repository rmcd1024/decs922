#' @title Date formatting strings
#'
#' @description \code{posix_dt_format} returns all or a portion of a
#'     data frame describing POSIX date
#'     strings. \code{translate_datestr} accepts a string and extracts
#'     the POSIX date codes, returning the portion of the data frame
#'     documenting those codes.
#'

#' @name dateformats
#' @aliases posix_dt_format translate_datestr
#'
#' @return Returns a data frame with POSIX date-time codes, code
#'     categories, and descriptions, all of which are extracted from
#'     \code{?strftime}.
#'
#' @usage
#' posix_dt_format(v, short_description)
#' translate_datestr(datetimestr)
#'
#' @param v A vector of POSIX date-time codes, \code{NULL} by default
#' @param short_description boolean, whether to return short or long
#'     code descriptions.
#' @param datetimestr string containing codes to be matched
#'
#' @examples
#'
#' posix_dt_format(v=c('%B', '%m', '%Y', '%y'))
#'
#' ## why isn't this string working?
#' translate_datestr(datetimestr = '%Y-%M-%d')
#'
#'
#'

#' @export
posix_dt_format <- function(v = NULL, short_description = TRUE) {
    abbrevs <- c("%a", "%A", "%b", "%B", "%c", "%C", "%d", "%D", "%e",
                 "%F", "%g", "%G", "%h", "%H", "%I", "%j", "%m", "%M",
                 "%n", "%p", "%r", "%R", "%S", "%t", "%T", "%u", "%U",
                 "%V", "%w", "%W", "%x", "%X", "%y", "%Y", "%z", "%Z")

    category <- c("day", "day", "month", "month",
                  "date-time", "year", "day", "date", "day", "date",
                  "year", "year", "month", "time", "time", "day",
                  "month", "time", "formatting", "time", "time",
                  "time", "time", "formatting", "time", "day", "week",
                  "week", "day", "week", "date", "time", "year",
                  "year", "time", "time")
    description_short <-
        c("Abbreviated weekday name in the current locale on this platform.",
      "Full weekday name in the current locale.",
      "Abbreviated month name in the current locale on this platform.",
      "Full month name in the current locale.",
      "Century (00-99): the integer part of the year divided by 100.",
      "Date and time.  Locale-specific on output, `%a %b %e %H:%M:%S %Y` on input.",
      "Day of the month as decimal number (01-31).",
      "Date format such as `%m/%d/%y`",
      "Day of the month as decimal number (1-31), with a leading space for a single-digit number.",
      "Equivalent to %Y-%m-%d (the ISO 8601 date format).",
      "The last two digits of the week-based year",
      "The week-based year (see `%V`) as a decimal number.",
      "Equivalent to `%b.",
      "Hours as decimal number (00-23).",
      "Hours as decimal number (01-12).",
      "Day of year as decimal number (001-366) (366 only in leap year)",
      "Month as decimal number (01-12).",
      "Minute as decimal number (00-59).",
      "Newline on output, arbitrary whitespace on input.",
      "AM/PM indicator in the locale.  Used with `%I` and *not* with `%H`.",
      "For output, the 12-hour clock time (using the locale's AM or PM. For input, equivalent to `%I:%M:%S %p`.",
      "Equivalent to `%H:%M`.",
      "Second as integer (00-61), allowing for up to two leap-seconds.",
      "Tab on output, arbitrary whitespace on input.",
      "Equivalent to `%H:%M:%S`.",
      "Weekday as a decimal number (1-7, Monday is 1).",
      "Week of the year as decimal number (00-53) using Sunday as the first day 1 of the week (and typically with the first Sunday of the year as day 1 of week 1).  The US convention.",
      "Week of the year as decimal number (01-53) as defined in ISO 8601.",
      "Weekday as decimal number (0-6, Sunday is 0).",
      "Week of the year as decimal number (00-53) using Monday as the first day of week (and typically with the first Monday of the year as day 1 of week 1).  The UK convention.",
      "Date.  Locale-specific on output, `%y/%m/%d` on input.",
      "Time.  Locale-specific on output, `%H:%M:%S` on input.",
      "Year without century (00-99).  On input, values 00 to 68 are prefixed by 20 and 69 to 99 by 19 (expect this to change at some point)`.",
      "Year with century.",
      "Signed offset in hours and minutes from UTC, so `-0800` is 8 hours behind UTC. Values up to `+1400` are accepted.",
      "(Output only.)  Time zone abbreviation as a character string")

        description_long <-
    c("Abbreviated weekday name in the current locale on this platform.  (Also matches full name on input: in some locales there are no abbreviations of names.)",
      "Full weekday name in the current locale.  (Also matches abbreviated name on input.)",
      "Abbreviated month name in the current locale on this platform.  (Also matches full name on input: in some locales there are no abbreviations of names.)",
      "Full month name in the current locale.  (Also matches abbreviated name on input.)",
      "Date and time.  Locale-specific on output, `%a %b %e %H:%M:%S %Y` on input.",
      "Century (00-99): the integer part of the year divided by 100.",
      "Day of the month as decimal number (01-31).",
      "Date format such as `%m/%d/%y`: the C99 standard says it should be that exact format (but not all OSes comply).",
      "Day of the month as decimal number (1-31), with a leading space for a single-digit number.",
      "Equivalent to %Y-%m-%d (the ISO 8601 date format).",
      "The last two digits of the week-based year (see `%V`). (Accepted but ignored on input.)",
      "The week-based year (see `%V`) as a decimal number. (Accepted but ignored on input.)",
      "Equivalent to `%b.",
      "Hours as decimal number (00-23).  As a special exception strings such as `24:00:00` are accepted for input, since ISO 8601 allows these.",
      "Hours as decimal number (01-12).",
      "Day of year as decimal number (001-366): For input, 366 is only valid in a leap year.",
      "Month as decimal number (01-12).",
      "Minute as decimal number (00-59).",
      "Newline on output, arbitrary whitespace on input.",
      "AM/PM indicator in the locale.  Used in conjunction with `%I` and *not* with `%H`.  An empty string in some locales (for example on some OSes, non-English European locales including Russia). The behaviour is undefined if used for input in such a locale. Some platforms accept `%P` for output, which uses a lower-case version (`%p` may also use lower case): others will output `P`.",
      "For output, the 12-hour clock time (using the locale's AM or PM): only defined in some locales, and on some OSes misleading in locales which do not define an AM/PM indicator. For input, equivalent to `%I:%M:%S %p`.",
      "Equivalent to `%H:%M`.",
      "Second as integer (00-61), allowing for up to two leap-seconds (but POSIX-compliant implementations will ignore leap seconds).",
      "Tab on output, arbitrary whitespace on input.",
      "Equivalent to `%H:%M:%S`.",
      "Weekday as a decimal number (1-7, Monday is 1).",
      "Week of the year as decimal number (00-53) using Sunday as the first day 1 of the week (and typically with the first Sunday of the year as day 1 of week 1).  The US convention.",
      "Week of the year as decimal number (01-53) as defined in ISO 8601.  If the week (starting on Monday) containing 1 January has four or more days in the new year, then it is considered week 1.  Otherwise, it is the last week of the previous year, and the next week is week 1.  (Accepted but ignored on input.)",
      "Weekday as decimal number (0-6, Sunday is 0).",
      "Week of the year as decimal number (00-53) using Monday as the first day of week (and typically with the first Monday of the year as day 1 of week 1).  The UK convention.",
      "Date.  Locale-specific on output, `%y/%m/%d` on input.",
      "Time.  Locale-specific on output, `%H:%M:%S` on input.",
      "Year without century (00-99).  On input, values 00 to 68 are prefixed by 20 and 69 to 99 by 19 - that is the behaviour specified by the 2018 POSIX standard, but it does also say `it is expected that in a future version the default century inferred from a 2-digit year will change`.",
      "Year with century.  Note that whereas there was no zero in the original Gregorian calendar, ISO 8601:2004 defines it to be valid (interpreted as 1BC): see <URL: https://en.wikipedia.org/wiki/0_(year)>.  However, the standards also say that years before 1582 in its calendar should only be used with agreement of the parties involved. For input, only years `0:9999` are accepted.",
      "Signed offset in hours and minutes from UTC, so `-0800` is 8 hours behind UTC. Values up to `+1400` are accepted. (Standard only for output.  For input R currently supports it on all platforms.)",
      "(Output only.)  Time zone abbreviation as a character string (empty if not available).  This may not be reliable when a time zone has changed abbreviations over the years.")

    if(short_description) {
        tmp <- description_short
    } else {
        tmp <- description_long
    }

    if (length(v) == 0) {
        ## return full data frame
        date_help <- data.frame("abbrevs" = abbrevs,
                                "category" = category,
                                "description" = tmp)
    } else {
        ## return only matches
        m <- which(abbrevs %in% v)
        ## print(m)
        date_help <- data.frame("abbrevs" = abbrevs[m],
                                "category" = category[m],
                                "description" = tmp[m])
    }
    return(date_help)
}

#' @export
translate_datestr <- function(datetimestr) {
    ##datetimestr <- 'The date is "%Y-%M-%d"'
    out <- unlist(gregexpr('%[A-z]',  datetimestr))
    length(out)
    matches <- vector(mode = 'character')
    for (i in 1:length(out))  {
        ##print(substr(S,  out[i],  out[i]+1 ))
        matches <- c(matches, substr(datetimestr,
                                     out[i],  out[i]+1 ))
    }
    ##print(matches )
    posix_dt_format(v = matches)

}

