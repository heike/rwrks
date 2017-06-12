## ------------------------------------------------------------------------
foo <- function(arg1, arg2, ...) {
    # Code goes here
    return(output)
}

## ------------------------------------------------------------------------
mymean <- function(data) {
    ans <- sum(data) / length(data)
    return(ans)
}

## ---- eval=FALSE---------------------------------------------------------
## if (condition) {
##     # Some code that runs if condition is TRUE
## } else {
##     # Some code that runs if condition is FALSE
## }

## ------------------------------------------------------------------------
mymean <- function(data) {
    if (!is.numeric(data)) {
        stop("Numeric input is required")
    } else {
        ans <- sum(data) / length(data)
        return(ans)
    }
}

## ------------------------------------------------------------------------
for (i in 1:3) {
    print(i)
}

## ------------------------------------------------------------------------
tips <- read.csv("http://heike.github.io/rwrks/01-r-intro/data/tips.csv")

id <- c("total_bill", "tip", "size")
for (colname in id) {
    print(colname)
}

for(colname in id) {
    print(paste(colname, mymean(tips[, colname])))
}

## ------------------------------------------------------------------------
i <- 1
while (i <= 5) {
    print(i)
    i <- i + 1
}

## ---- eval=FALSE, echo=FALSE---------------------------------------------
## # \begin{frame}
## #     \frametitle{What you've learned!}
## #     \begin{itemize}
## #         \item Use R for scientific/statistical calculations
## #         \item Be able to create or read in data and have the ability to manipulate the data accordingly
## #         \item Have the ability to explore data set characteristics and calculate summary statistics for real data sets
## #         \item Use the help functionality to find the functions you need to do what you want to do
## #         \item Install, use, and search for helpful external packages
## #         \item How to use basic programming constructs to make working with data easier
## #   \end{itemize}
## # \end{frame}
## #
## #
## # \begin{frame}
## #     \frametitle{Questions?}
## #     \begin{itemize}
## #         \item Any Questions???
## #   \end{itemize}
## # \end{frame}
## #
## #
## #
## # \begin{frame}
## #     \frametitle{Feedback Survey}
## #     \begin{itemize}
## #         \item Please let us know how we did with the feedback survey!
## #     \item  \url{http://heike.wufoo.com/forms/r-workshop-your-opinion-matters/}
## #   \end{itemize}
## # \end{frame}

