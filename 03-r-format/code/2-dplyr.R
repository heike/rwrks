## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
data(baseball, package = "plyr")

## ----message = FALSE, warning=FALSE, eval = FALSE------------------------
## library(tidyverse)
## french_fries <- read_csv("frenchfries.csv")
## french_fries %>%
##   filter(subject == 3, time == 1) %>%
##   head(3)

## ----message = FALSE, warning=FALSE, echo = FALSE------------------------
library(tidyverse)
french_fries <- read_csv("../data/frenchfries.csv")
french_fries %>% 
  filter(subject == 3, time == 1) %>% 
  head(3)

## ----arr.desc------------------------------------------------------------
french_fries %>% 
  arrange(desc(rancid), potato) %>% 
  head(3)

## ----arr.asce------------------------------------------------------------
french_fries %>% 
  arrange(rancid, potato) %>% 
  head(3)

## ------------------------------------------------------------------------
french_fries %>% 
  select(time, treatment, subject, rep, potato) %>%
  head()

## ------------------------------------------------------------------------
french_fries %>%
    summarise(mean_rancid = mean(rancid, na.rm=TRUE), 
              sd_rancid = sd(rancid, na.rm = TRUE))

## ------------------------------------------------------------------------
french_fries %>%
    group_by(time, treatment) %>%
    summarise(mean_rancid = mean(rancid), 
              sd_rancid = sd(rancid))

## ------------------------------------------------------------------------
french_fries %>%
    mutate(awful = (buttery+potato)/2 - (grassy+painty+rancid)/3,
           time = as.numeric(time)) %>% 
  glimpse()

## ------------------------------------------------------------------------
french_fries$awful

## ---- eval = FALSE-------------------------------------------------------
## 
## french_fries %>% tally()
## french_fries %>% summarize(n=n())
## 

## ---- eval=FALSE---------------------------------------------------------
## french_fries %>% count(time, subject)
## french_fries %>% group_by(time, subject) %>% summarize(n=n())
## 

## ----fig.width = 4.5, fig.height=4.5-------------------------------------
reps <- french_fries %>% 
  group_by(time, subject, treatment) %>%
  summarise(potato_diff = diff(potato),
            potato = mean(potato))

reps

## ----fig.height=4, warning=FALSE-----------------------------------------
reps %>% 
  ggplot(aes(x = potato, y = potato_diff, colour = as.numeric(time))) + 
  facet_wrap(~subject) +
  geom_hline(aes(yintercept=0)) +
  geom_point() 

## ----fig.height=4, warning=FALSE-----------------------------------------
GGally::ggpairs(data = french_fries[ ,5:9])

## ----warning=FALSE-------------------------------------------------------
ChickPlus <- ChickWeight %>% 
  group_by(Chick) %>% 
  mutate(gain = weight - weight[Time == 0])

## ----echo=FALSE, eval=FALSE----------------------------------------------
## ChickPlus %>%
##   filter(Chick == 1) %>%
##   select(-Diet) %>%
##   glimpse()

## ----fig.height=4--------------------------------------------------------
ChickPlus %>% 
  ggplot(aes(x = Time, y = gain, group = Chick)) + 
  geom_line(aes(color=Diet)) +
  facet_wrap(~Diet)


