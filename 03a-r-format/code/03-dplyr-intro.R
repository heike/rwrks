# ------------------------------------------------------------------------
data(baseball, package = "plyr")
help(baseball, package = "plyr")
head(baseball)

## ----subsets-------------------------------------------------------------
ss <- subset(baseball, id=="sosasa01")
head(ss)
mean(ss$h/ss$ab)

## ----baseballforloop-----------------------------------------------------
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

## ----baseballforloop2----------------------------------------------------
# Index set
players <- unique(baseball$id)
n <- length(players)

# Place to store data
ba <- rep(NA, n)

# Results
head(ba)

## ----baseballforloop3----------------------------------------------------
# Index set
players <- unique(baseball$id)

# Place to store data
ba <- rep(NA, length(players))

for(i in 1:1){ #loop
  career <- subset(baseball, id==players[i])
  ba[i] <- with(career, mean(h/ab, na.rm=T))
}

head(ba)

## ----baseballforloop4----------------------------------------------------
# Index set
players <- unique(baseball$id)

# Place to store data
ba <- rep(NA, length(players))

for(i in 1:2){ #loop
  career <- subset(baseball, id==players[i])
  ba[i] <- with(career, mean(h/ab, na.rm=T))
}

head(ba)

## ----baseball-summarize-example------------------------------------------
library(dplyr)
baseball <- read.csv("../data/baseball.csv")
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

## ----ddply-summarize-example---------------------------------------------
careers <- summarise(group_by(baseball, id),
                 ba = mean(h/ab, na.rm=T),
                 games = sum(g, na.rm=T),
                 homeruns = sum(hr, na.rm=T),
                 atbats = sum(ab, na.rm=T))

head(careers)

