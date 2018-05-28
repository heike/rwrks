## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
library(tidyverse)
data(french_fries, package="reshape2")

## ----echo = FALSE--------------------------------------------------------
read.csv("../data/preg.csv")

## ----echo = FALSE--------------------------------------------------------
read.csv("../data/preg2.csv")

## ----fig.width=3, fig.height=3.7,echo=FALSE, fig.align="center"----------
library(png)
library(grid)
img <- readPNG("images/tablelong2.png")
 grid.raster(img)

## ---- echo=TRUE, eval=FALSE----------------------------------------------
## french_fries <- read_csv("frenchfries.csv")
## head(french_fries)

## ---- echo=TRUE----------------------------------------------------------
french_fries <- read_csv("../data/frenchfries.csv")
head(french_fries)

## ---- fig.width=7, fig.height=3, warning=FALSE---------------------------
library(ggplot2)

ggplot(french_fries) + 
  geom_boxplot(aes(x="1_buttery", y=buttery), fill = "cyan4") +
  geom_boxplot(aes(x = "2_grassy", y = grassy), fill = "darkorange2") +
  geom_boxplot(aes(x = "3_painty", y = painty), fill = "darkorchid1") +
  geom_boxplot(aes(x = "4_potato", y = potato), fill = "chartreuse3") +
  geom_boxplot(aes(x = "5_rancid", y = rancid), fill = "deeppink") +
  xlab("variable") + ylab("rating")

## ---- echo=TRUE----------------------------------------------------------

french_fries_long <- french_fries %>% 
  gather(key = variable, value = rating, potato:painty)
head(french_fries_long)


## ---- fig.width=7, fig.height=4, warning=FALSE---------------------------
ggplot(french_fries_long) + 
  geom_boxplot(aes(x = variable, y = rating, fill = variable))


## ------------------------------------------------------------------------
head(french_fries_long)

## ---- warning = FALSE----------------------------------------------------
french_fries_wide <- french_fries_long %>% 
  spread(key = variable, value = rating)

head(french_fries_wide)

## ------------------------------------------------------------------------
french_fries_wide <- french_fries_long %>% 
  spread(key = rep, value = rating)

head(french_fries_wide)

## ----fig.height=4, warning=FALSE-----------------------------------------
french_fries_wide %>%
  ggplot(aes(x = `1`, y = `2`)) + 
  geom_point() +
  facet_wrap(~variable) + 
  geom_abline(colour = "grey50")

## ------------------------------------------------------------------------
df <- data.frame(x = c(NA, "a.b", "a.d", "b.c"))
df
df %>% separate(x, into = c("A", "B"))

## ---- results='hold', message=FALSE--------------------------------------
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

## ------------------------------------------------------------------------
flights <- read.csv("http://heike.github.io/rwrks/03-r-format/data/flights.csv")

## ------------------------------------------------------------------------
billboard <- read.csv("http://heike.github.io/rwrks/03-r-format/data/billboard.csv")

