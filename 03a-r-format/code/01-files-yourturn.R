#############
# Your Turn

midwest_names <- read.table("http://heike.github.io/rwrks/03a-r-format/data/01-data/midwest.csv", 
                       header=FALSE, nrows=2, sep=",")

midwest_data <- read.table("http://heike.github.io/rwrks/03a-r-format/data/01-data/midwest.csv", 
                      header=FALSE, skip=2, sep=",")


#############
# Your Turn
# read a SAS xport file published as a webfile

library(foreign)
# download file from http://www.cdc.gov/nchs/nhanes/nhanes2009-2010/exam09_10.htm
# then read:
bp <- read.xport(file.choose())
dim(bp)
summary(bp)
