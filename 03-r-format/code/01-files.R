#########
# Reading files

# read a csv file published as a webfile
midwest <- read.csv("http://heike.github.io/rwrks/03a-r-format/data/01-data/midwest.csv")

# read (and find) a local csv file
# midwest <- read.csv(file.choose())

# reveals awful format
head(midwest)

str(midwest)
# need to work at it a bit more
#########
# Your turn

#########
str(midwest_data)

require(ggplot2)
qplot(V1, V3, data=midwest_data)

#########
# load a library
library("gdata")
# get html page with an overview of the package functionality
help(package="gdata")

#read.xls(xls, sheet = 1, verbose = FALSE, pattern, ..., method = c("csv", "tsv", "tab"), perl = "perl")

midwest2 <- read.xls(file.choose(), sheet=1)
head(midwest2)
