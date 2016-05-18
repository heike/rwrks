data(baseball, package = "plyr")
help(baseball, package = "plyr")
head(baseball)

ss <- subset(baseball, id == "sosasa01")
head(ss)
mean(ss$h / ss$ab)

players <- unique(baseball$id)
n <- length(players)

ba <- rep(NA, n)

for(i in 1:n) {
  career <- subset(baseball, id == players[i])
  ba[i] <- with(career, mean(h / ab, na.rm = TRUE))
}

# do the same thing in a different way! (just for fun, because there's usually more than 1 way to do everything in R)

ba2 <- NULL

# check out the players object to see what's going on here
for(name in players) {
  career <- subset(baseball, id == name)
  ba1 <- with(career, mean(h / ab, na.rm = TRUE))
  ba2 <- c(ba2, ba1)
}

summary(ba2)

summary(ba) == summary(ba2)

players <- unique(baseball$id)
n <- length(players)

ba <- rep(NA, n)

head(ba)

players <- unique(baseball$id)

ba <- rep(NA, length(players))

for(i in 1:1) {
  career <- subset(baseball, id == players[i])
  ba[i] <- with(career, mean(h / ab, na.rm = TRUE))
}

head(ba)

players <- unique(baseball$id)

ba <- rep(NA, length(players))

for(i in 1:2) {
  career <- subset(baseball, id == players[i])
  ba[i] <- with(career, mean(h / ab, na.rm = TRUE))
}

head(ba)

library(dplyr)

baseball <- read.csv("http://heike.github.io/rwrks/03-r-format/data/baseball.csv")

summarise(baseball,
          ba = mean(h / ab, na.rm = TRUE),
          games = sum(g, na.rm = TRUE),
          hr = sum(hr, na.rm = TRUE),
          ab = sum(ab, na.rm = TRUE))

summarise(subset(baseball, id == "sosasa01"), 
          ba = mean(h / ab, na.rm = TRUE),
          games = sum(g, na.rm = TRUE),
          hr = sum(hr, na.rm = TRUE),
          ab = sum(ab, na.rm = TRUE))

careers <- summarise(group_by(baseball, id),
                 ba = mean(h / ab, na.rm = TRUE),
                 games = sum(g, na.rm = TRUE),
                 homeruns = sum(hr, na.rm = TRUE),
                 atbats = sum(ab, na.rm = TRUE))

head(careers)
