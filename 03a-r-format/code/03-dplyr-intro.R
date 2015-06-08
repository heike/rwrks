## ----knitr-setup, include=FALSE, echo=FALSE------------------------------
setwd("../")
require(knitr)
library(highlight)
opts_chunk$set(cache=T, autodep=T, background = 'white', size='scriptsize', tidy=FALSE, fig.path='figures/fig-')
options(width=55)

## ----plyr-demo, echo=T, eval=F-------------------------------------------
## library(plyr)
## help(baseball)
## head(baseball)

## ----plyr-demo-out, echo=F, eval=T, include=T, size='tiny', comment=NA----
options(width=100)
library(plyr)
help(baseball)
head(baseball)

## ----subsets, echo=T, eval=F---------------------------------------------
## ss <- subset(baseball, id=="sosasa01")
## head(ss)

## ----subsets-out, echo=F, eval=T, include=T, size='tiny', comment=NA-----
options(width=100)
ss <- subset(baseball, id=="sosasa01")
head(ss)

## ----subsets-mean, echo=T, eval=T----------------------------------------
mean(ss$h/ss$ab)

## ----subsets2, echo=T, eval=F--------------------------------------------
## ss <- subset(baseball, id=="sosasa01")
## head(ss)

## ----subsets-out2, echo=F, eval=T, include=T, size='tiny', comment=NA----
options(width=100)
ss <- subset(baseball, id=="sosasa01")
head(ss)

## ----subsets-mean2, echo=T, eval=T---------------------------------------
mean(ss$h/ss$ab)

## ----baseballforloop, echo=c(-1)-----------------------------------------
options(width=80)
# Index set
players <- unique(baseball$id)
n <- length(players)

# Place to store data
ba <- rep(NA, n)

# Loop
for(i in 1:n){
  career <- subset(baseball, id==players[i])
  ba[i] <- with(career, mean(h/ab, na.rm=T))
}

# Results
summary(ba)

## ----baseballforloop-i0, echo=c(-1)--------------------------------------
options(width=80)
# Index set
players <- unique(baseball$id)
n <- length(players)

# Place to store data
ba <- rep(NA, n)

head(ba)

## ----baseballforloop-i1, echo=c(-1)--------------------------------------
options(width=80)
# Index set
players <- unique(baseball$id)
n <- length(players)

# Place to store data
ba <- rep(NA, n)

# Loop
for(i in 1:1){
  career <- subset(baseball, id==players[i])
  ba[i] <- with(career, mean(h/ab, na.rm=T))
}
i
head(ba)

## ----baseballforloop-i2, echo=c(-1)--------------------------------------
options(width=80)
# Index set
players <- unique(baseball$id)
n <- length(players)

# Place to store data
ba <- rep(NA, n)

# Loop
for(i in 1:2){
  career <- subset(baseball, id==players[i])
  ba[i] <- with(career, mean(h/ab, na.rm=T))
}
i
head(ba)

## ----baseball-summarize-example, warning=FALSE---------------------------
library(dplyr)
baseball <- read.csv("data/baseball.csv")
summarise(baseball, ab=mean(h/ab, na.rm=T))

summarise(baseball,
          ba = mean(h/ab, na.rm=T),
          games = sum(g, na.rm=T),
          hr = sum(hr, na.rm=T),
          ab = sum(ab, na.rm=T))

summarise(subset(baseball, id=="sosasa01"), 
          ba = mean(h/ab, na.rm=T),
          games = sum(g, na.rm=T),
          hr = sum(hr, na.rm=T),
          ab = sum(ab, na.rm=T))

## ----ddply-summarize-example, warning=FALSE------------------------------
careers <- summarise(group_by(baseball, id),
                 ba = mean(h/ab, na.rm=T),
                 games = sum(g, na.rm=T),
                 homeruns = sum(hr, na.rm=T),
                 atbats = sum(ab, na.rm=T))

head(careers)

