knitr::opts_chunk$set(echo = TRUE)
library(tidyverse)
data(french_fries, package="reshape2")
read.csv("../data/preg.csv")
read.csv("../data/preg2.csv")
library(ggplot2)

ggplot(french_fries) + 
  geom_boxplot(aes(x="1_buttery", y=buttery), fill = "cyan4") +
  geom_boxplot(aes(x = "2_grassy", y = grassy), fill = "darkorange2") +
  geom_boxplot(aes(x = "3_painty", y = painty), fill = "darkorchid1") +
  geom_boxplot(aes(x = "4_potato", y = potato), fill = "chartreuse3") +
  geom_boxplot(aes(x = "5_rancid", y = rancid), fill = "deeppink") +
  xlab("variable") + ylab("rating")
preg2 <- read.csv("../data/preg2.csv")
preg2 %>% gather(key = patient, value = score, 2:4) %>% 
  mutate(patient = gsub("\\.", " ", patient))
french_fries_long <- french_fries %>% gather(key = variable, value = rating, potato:painty)
french_fries_long
ggplot(french_fries_long) + geom_boxplot(aes(x=variable, y=rating, fill = variable))
head(french_fries_long)
french_fries_wide <- french_fries_long %>% spread(key = variable, value = rating)

head(french_fries_wide)
french_fries_long %>% spread(key = rep, value = rating)
french_fries_long %>% spread(key = rep, value = rating) %>%
  ggplot(aes(x = `1`, y = `2`)) + geom_point() +
  facet_wrap(~variable) + geom_abline(colour = "grey50")
df <- data.frame(x = c(NA, "a.b", "a.d", "b.c"))
df
df %>% separate(x, into = c("A", "B"))
billboard <- read.csv("http://heike.github.io/rwrks/03-r-format/data/billboard.csv")
occupation <- read.csv("../data/occupation-1870.csv")

# combine all of the variables (except for State) 
# into a single variable
occupation <- occupation %>% 
  gather(key="Occ.gender", value="Number", 2:11)
occupation
# split Occ.gender into two variables
occupation <- occupation %>% 
  separate(Occ.gender, into = c("Occupation", "Gender"))
occupation
# now spread the data again
occ2 <- occupation %>% spread(Gender, Number)
occ2
occ2 %>% 
  ggplot(aes(x = Male, y = Female)) + geom_point() + 
  facet_wrap(~Occupation)
library(lubridate)

now()
today()
now() + hours(4)
today() - days(2)
ymd("2013-05-14")
mdy("05/14/2013")
dmy("14052013")
ymd_hms("2013:05:14 14:50:30", tz = "America/Chicago")
flights <- read.csv("http://heike.github.io/rwrks/03-r-format/data/flights.csv")
