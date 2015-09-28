jsFormatInt <- function() {
    paste0("function(x){",
           "var y = Math.round(x);",
           "var z = y.toString().replace(/",
           "\\B(?=(\\d{3})+(?!\\d))/g, ',');",
           "return z;}")
}