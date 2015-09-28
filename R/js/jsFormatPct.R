jsFormatPct <- function() {
    paste0("function(x){",
           "var y = Math.round(x*1000)/10;",
           "var pct = '%';",
           "return y.toString().concat(pct);}")
}