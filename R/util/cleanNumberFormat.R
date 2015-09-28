cleanNumberFormat <- function(x, type, digits = 0) {
    if (type == "int") {
        y <- format(round(x, digits), nsmall = digits, big.mark = ",")
        y <- trimws(y)
    } else if (type == "dlr") {
        y <- format(round(x, digits), nsmall = digits, big.mark = ",")
        y <- trimws(y)
        y <- paste0("$", y)
    } else if (type == "pct") {
        y <- format(100*round(x, digits + 2), nsmall = digits, big.mark = ",")
        y <- trimws(y)
        y <- paste0(y, "%")
    } else {
        y <- x
    }
    return(y)
}