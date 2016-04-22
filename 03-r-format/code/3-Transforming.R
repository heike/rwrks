french_fries <- read.csv("http://heike.github.io/rwrks/03-r-format/data/frenchfries.csv")
head(french_fries)

library(ggplot2)

qplot("1_buttery", buttery, data = french_fries, fill = I("red"), geom = "boxplot") +
    geom_boxplot(aes(x = "2_grassy", y = grassy), fill = I("orange")) +
    geom_boxplot(aes(x = "3_painty", y = painty), fill = I("yellow")) +
    geom_boxplot(aes(x = "4_potato", y = potato), fill = I("green")) +
    geom_boxplot(aes(x = "5_rancid", y = rancid), fill = I("blue")) +
    xlab("variable") + ylab("rating")

library(tidyr)

french_fries_long <- gather(french_fries, key = variable, value = rating, potato:painty)
head(french_fries_long)

qplot(variable, rating, data = french_fries_long, fill = variable, geom = "boxplot")

head(french_fries_long)

french_fries_wide <- spread(french_fries_long, key = variable, value = rating)
head(french_fries_wide)

billboard <- read.csv("http://heike.github.io/rwrks/03-r-format/data/billboard.csv")

library(dplyr)

french_fries_split <- group_by(french_fries_long, variable) # SPLIT
french_fries_apply <- summarise(french_fries_split, rating = mean(rating, na.rm = TRUE)) # APPLY + COMBINE
french_fries_apply

french_fries %>%
    gather(key = variable, value = rating, potato:painty) %>%
    group_by(variable) %>%
    summarise(rating = mean(rating, na.rm = TRUE))

french_fries %>%
    filter(subject == 3, time == 1)

french_fries %>%
    arrange(desc(rancid)) %>%
    head

french_fries %>%
    select(time, treatment, subject, rep, potato) %>%
    head

french_fries %>%
    mutate(rancid2 = rancid^2) %>%
    head

french_fries %>%
    group_by(time, treatment) %>%
    summarise(mean_rancid = mean(rancid), sd_rancid = sd(rancid))

flights <- read.csv("http://heike.github.io/rwrks/03-r-format/data/flights.csv")

library(lubridate)

now()
today()
now() + hours(4)
today() - days(2)

ymd("2013-05-14")
mdy("05/14/2013")
dmy("14052013")
ymd_hms("2013:05:14 14:50:30", tz = "America/Chicago")

flights$date <- ymd(paste(flights$year, flights$month, flights$day, sep = "-"))
delay.dat <- flights %>% 
    group_by(date) %>% 
    summarise(dep_delay = mean(dep_delay, na.rm = TRUE))

qplot(date, dep_delay, geom = "line", data = delay.dat)
