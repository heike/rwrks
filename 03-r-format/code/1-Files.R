## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(message= FALSE, warning = FALSE)

## ----message=FALSE, warning=FALSE----------------------------------------
library(readr)
midwest <- read_csv("http://heike.github.io/rwrks/03-r-format/data/midwest.csv")
head(midwest)

## ---- echo=FALSE---------------------------------------------------------
midwest_names <- read_csv("http://heike.github.io/rwrks/03-r-format/data/midwest.csv", n_max= 2, col_names = FALSE)
midwest_data <- read_csv("http://heike.github.io/rwrks/03-r-format/data/midwest.csv", skip = 2, col_names = FALSE)

## ---- warning=FALSE, message=FALSE---------------------------------------
library(lubridate)
library(tidyverse)
values <- c(midwest_data$X3, midwest_data$X5, midwest_data$X7, 
            midwest_data$X9, midwest_data$X11)
dates <- c(paste(midwest_data$X1, midwest_data$X2, sep = "-"), 
           paste(midwest_data$X1, midwest_data$X4, sep = "-"),
           paste(midwest_data$X1, midwest_data$X6, sep = "-"),
           paste(midwest_data$X1, midwest_data$X8, sep = "-"),
           paste(midwest_data$X1, midwest_data$X10, sep = "-"))

dates <- dates[!is.na(values)]
values <- values[!is.na(values)]

dates <- ymd(dates)

midwest_gas <- data_frame(date = dates, price = values)
midwest_gas <- arrange(midwest_gas, dates)

## ---- warning=FALSE, message=FALSE, fig.width=7, fig.height=4------------
library(ggplot2)
ggplot(midwest_gas, aes(x = date, y = price)) + geom_line()

## ---- eval=FALSE---------------------------------------------------------
## library(readxl)
## 
## midwest2 <- read_excel("midwest.xls")
## 
## head(midwest2)

## ----midwest, echo=FALSE-------------------------------------------------
library(readxl)

midwest2 <- read_excel("../data/midwest.xls")

head(midwest2)

## ---- eval=FALSE---------------------------------------------------------
## library(readxl)
## 
## midwest2 <- read_excel("midwest.xls", skip = 1)
## names(midwest2)[1] <- "Year-Month"
## head(midwest2)

## ----midwest2, echo=FALSE------------------------------------------------
library(readxl)

midwest2 <- read_excel("../data/midwest.xls", skip = 1)
names(midwest2)[1] <- "Year-Month"
head(midwest2)


