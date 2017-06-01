#packages <- c("gridExtra", "lubridate",
#              "maps","ggmap", "mapproj", "dplyr", "devtools")
packages <- c("gridExtra", "lubridate",
              "ggmap", "sf", "dplyr", "devtools")
install.packages(packages)
devtools::install_github("hrbrmstr/albersusa")
devtools::install_github("tidyverse/ggplot2")
library(ggplot2)
library(lubridate)
library(maps)
library(ggmap)
library(dplyr)

today()
qplot(rnorm(100), rnorm(100), colour=factor(rbinom(100, 1, 0.5)))
qplot(rnorm(100), rnorm(100), colour=rbinom(100, 5, 0.2))
