knitr::opts_chunk$set(echo = TRUE)
data(baseball, package = "plyr")
ss <- subset(baseball, id == "sosasa01")
head(ss)
mean(ss$h / ss$ab)
## result <- rep(NA, length(indexset))
## for(i in indexset){
##   ... some statements ...
##   result[i] <- ...
## }
players <- unique(baseball$id)
n <- length(players)

ba <- rep(NA, n)

for(i in 1:n) {
  career <- subset(baseball, id == players[i])
  ba[i] <- with(career, mean(h / ab, na.rm = TRUE))
}

summary(ba)
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
library(tidyverse)
data(french_fries, package = "reshape2")
french_fries %>%
    filter(subject == 3, time == 1)
french_fries %>%
    arrange(desc(rancid), potato) %>%
    head
french_fries %>%
    select(time, treatment, subject, rep, potato) %>%
    head
french_fries %>%
    summarise(mean_rancid = mean(rancid, na.rm=TRUE), 
              sd_rancid = sd(rancid, na.rm = TRUE))
french_fries %>%
    group_by(time, treatment) %>%
    summarise(mean_rancid = mean(rancid), sd_rancid = sd(rancid))
french_fries %>%
    mutate(
      awful = (buttery+potato)/2 - (grassy+painty+rancid)/3
    ) %>% glimpse()
french_fries$awful
french_fries %>% 
  ggplot(aes(x = time)) + geom_bar() + facet_wrap(~subject) 
dim(french_fries) # too few rows - should be 720 = 12 x 10 x 6

# if subjects come, they give all six evaluations
french_fries %>% group_by(time, subject) %>% summarize(n = n()) %>% summary()
# not all subjects come all the time:
french_fries %>% group_by(subject) %>% summarize(n = n()) %>% arrange(n)
reps <- french_fries %>% group_by(time, subject, treatment) %>%
  summarise(
    potato_diff = diff(potato),
    potato = mean(potato)
  )
reps
reps %>% 
  ggplot(aes(x = potato, y = potato_diff, colour = as.numeric(time))) + 
  facet_wrap(~subject) +
  geom_hline(aes(yintercept=0)) +
  geom_point() 
french_fries %>% 
  ggplot(aes(x = potato, y = buttery)) + geom_point() +
  theme(aspect.ratio=1) + xlim(c(0,15)) + ylim(c(0,15)) +
  geom_abline(colour = "grey50")
ffm <- french_fries %>% group_by(time) %>% summarise(
  potato = mean(potato,  na.rm=TRUE),
  buttery = mean(buttery,  na.rm=TRUE),
  painty = mean(painty,  na.rm=TRUE)
)
ffm %>%
  ggplot(aes(x = time, y = potato)) + geom_point(colour = "blue") +
  geom_point(aes(y = buttery), colour = "forestgreen") +
  geom_point(aes(y = painty), colour = "red") +
  ylab("Score")
