### Introduction and Setup

# install shiny:
install.packages("shiny")
library(shiny)

# install other required packages for this workshop:
tmp <- installed.packages()
workshop.packages <- c("ggplot2", "plyr", "lubridate")
to.install <- workshop.packages[which(!workshop.packages%in%tmp[,1])]
if(length(to.install)>0){
  install.packages(to.install)
}  else {
  library(ggplot2)
  library(plyr)
  library(lubridate)
  qplot(x=0, y=0, label="Good to go!", geom="text") + theme_bw() + theme(axis.text=element_blank(), axis.title=element_blank(), axis.ticks=element_blank())
}

# download example apps
if (!file.exists("shinyApps")) {
  tmp <- tempfile(fileext = ".zip")
  download.file("http://heike.github.io/rwrks/06-r-shiny/Code/Applets.zip", tmp, quiet = TRUE)
  unzip(tmp, exdir = "shinyApps")
  unlink(tmp)
}