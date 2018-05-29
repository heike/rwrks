foo <- function(arg1, arg2, ...) {
    # Code goes here
    return(output)
}
mymean <- function(data) {
    ans <- sum(data) / length(data)
    return(ans)
}
## if (condition) {
##     # Some code that runs if condition is TRUE
## } else {
##     # Some code that runs if condition is FALSE
## }
mymean <- function(data) {
    if (!is.numeric(data)) {
        stop("Numeric input is required")
    } else {
        ans <- sum(data) / length(data)
        return(ans)
    }
}
for (i in 1:3) {
    print(i)
}
final_shed <- read.csv("http://heike.github.io/rwrks/01-r-intro/data/final_shedding.csv")

id <- c("pig_weight", "total_shedding", "daily_shedding")
for (colname in id) {
    print(colname)
}

# this does NOT work if the csv is read in using read_csv
for(colname in id) {
    print(paste(colname, mymean(final_shed[, colname])))
}
i <- 1
while (i <= 5) {
    print(i)
    i <- i + 1
}
