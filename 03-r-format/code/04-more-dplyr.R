## ---- echo = FALSE, results='asis'---------------------------------------
library(xtable)
library(reshape2)
library(tidyr)

print(xtable(head(french_fries)), comment = FALSE)

## ---- eval=FALSE---------------------------------------------------------
## library(ggplot2)
## 
## french_sub <- french_fries[french_fries$time == 10,]
## 
## qplot("1_potato", potato, data = french_sub, fill = I("red"), geom = "boxplot") +
##     geom_boxplot(aes(x = "2_buttery", y = buttery), fill = I("orange")) +
##     geom_boxplot(aes(x = "3_grassy", y = grassy), fill = I("yellow")) +
##     geom_boxplot(aes(x = "4_rancid", y = rancid), fill = I("green")) +
##     geom_boxplot(aes(x = "5_painty", y = painty), fill = I("blue")) +
##     xlab("variable") + ylab("rating")

## ---- echo=FALSE---------------------------------------------------------
library(ggplot2)

french_sub <- french_fries[french_fries$time == 10,]

qplot("1_potato", potato, data = french_sub, fill = I("red"), geom = "boxplot") +
    geom_boxplot(aes(x = "2_buttery", y = buttery), fill = I("orange")) +
    geom_boxplot(aes(x = "3_grassy", y = grassy), fill = I("yellow")) +
    geom_boxplot(aes(x = "4_rancid", y = rancid), fill = I("green")) +
    geom_boxplot(aes(x = "5_painty", y = painty), fill = I("blue")) +
    xlab("variable") + ylab("rating")

## ------------------------------------------------------------------------
french_fries_long <- gather(french_fries, key = variable, value = rating, potato:painty)

head(french_fries_long)

## ---- fig.show='hide'----------------------------------------------------
french_fries_long_sub <- french_fries_long[
  french_fries_long$time == 10,]

qplot(variable, rating, data = french_fries_long_sub, fill = variable, geom = "boxplot")

## ---- echo=FALSE---------------------------------------------------------
qplot(variable, rating, data = french_fries_long_sub, fill = variable, geom = "boxplot")

## ------------------------------------------------------------------------
head(french_fries_long)

## ------------------------------------------------------------------------
french_fries_wide <- spread(french_fries_long, key = variable, value = rating)

head(french_fries_wide)

## ------------------------------------------------------------------------
billboard <- read.csv("http://heike.github.io/rwrks/03a-r-format/data/billboard.csv")

## ---- echo=FALSE, fig.width=15, fig.height=5-----------------------------
long_billboard <- gather(billboard, key = week, value = rank, X1:X76)
long_billboard$week <- as.numeric(gsub("X", "", long_billboard$week))

qplot(week, rank, data = long_billboard, geom = "line", colour = artist, group = track)

## ------------------------------------------------------------------------
library(dplyr)

french_fries_split <- group_by(french_fries_long, variable) # SPLIT
french_fries_apply <- summarise(french_fries_split, rating = mean(rating, na.rm = TRUE)) # APPLY + COMBINE
french_fries_apply

## ------------------------------------------------------------------------
french_fries %>%
    gather(key = variable, value = rating, potato:painty) %>%
    group_by(variable) %>%
    summarise(rating = mean(rating, na.rm = TRUE))

## ------------------------------------------------------------------------
french_fries %>%
    filter(subject == 3, time == 1)

## ------------------------------------------------------------------------
french_fries %>%
    arrange(desc(rancid)) %>%
    head

## ------------------------------------------------------------------------
french_fries %>%
    select(time, treatment, subject, rep, potato) %>%
    head

## ------------------------------------------------------------------------
french_fries %>%
    mutate(rancid2 = rancid^2) %>%
    head

## ------------------------------------------------------------------------
french_fries %>%
    group_by(time, treatment) %>%
    summarise(mean_rancid = mean(rancid), sd_rancid = sd(rancid))

## ------------------------------------------------------------------------
flights <- read.csv("http://heike.github.io/rwrks/03a-r-format/data/flights.csv")

## ---- results='hold'-----------------------------------------------------
library(lubridate)

now()
today()
now() + hours(4)
today() - days(2)

## ---- results='hold'-----------------------------------------------------
ymd("2013-05-14")
mdy("05/14/2013")
dmy("14052013")
ymd_hms("2013:05:14 14:50:30", tz = "America/Chicago")

## ---- echo=FALSE---------------------------------------------------------
flights$date <- ymd(paste(flights$year, flights$month, flights$day, sep = "-"))
delay.dat <- flights %>% group_by(date) %>% summarise(dep_delay = mean(dep_delay, na.rm = TRUE))

qplot(date, dep_delay, geom = "line", data = delay.dat)

