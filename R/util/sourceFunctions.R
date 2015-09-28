sourceFunctions <- function(x) {
    for (i in 1:length(x)) {
        source(x[i])
    }
}
