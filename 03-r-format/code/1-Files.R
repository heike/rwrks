midwest <- read.csv("http://heike.github.io/rwrks/03-r-format/data/midwest.csv")

head(midwest)
str(midwest)

?read.table

midwest_names <- read.table("http://heike.github.io/rwrks/03-r-format/data/midwest.csv", nrows = 2, sep = ",", stringsAsFactors = FALSE)
midwest_data <- read.table("http://heike.github.io/rwrks/03-r-format/data/midwest.csv", skip = 2, sep = ",", stringsAsFactors = FALSE)

values <- c(midwest_data$V3, midwest_data$V5, midwest_data$V7, 
            midwest_data$V9, midwest_data$V11)
dates <- c(paste(midwest_data$V1, midwest_data$V2, sep = "-"), 
           paste(midwest_data$V1, midwest_data$V4, sep = "-"),
           paste(midwest_data$V1, midwest_data$V6, sep = "-"),
           paste(midwest_data$V1, midwest_data$V8, sep = "-"),
           paste(midwest_data$V1, midwest_data$V10, sep = "-"))

dates <- dates[!is.na(values)]
values <- values[!is.na(values)]

library(lubridate)
dates <- ymd(dates)

midwest_gas <- data.frame(date = dates, price = values)
midwest_gas <- midwest_gas[with(midwest_gas, order(date)), ]

library(ggplot2)
qplot(date, price, data = midwest_gas, geom = "line")

library(readxl)
midwest2 <- read_excel("midwest.xls")
head(midwest2)
