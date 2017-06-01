## ---- eval=FALSE---------------------------------------------------------
## library(dplyr)
## library(albersusa)
## library(sf)

## ----alt1, eval = FALSE, echo=FALSE--------------------------------------
## library(ggplot2)
## states <- map_data("state")
## head(states)

## ------------------------------------------------------------------------
# XX REPLACE WITH SF AND ALBERS USA IF IT WORKS ON LAB COMPUTERS XX
library(ggplot2)
library(albersusa)
library(sf)
states <- usa_sf("laea")
head(states)

## ---- fig.height=4, fig.width=7------------------------------------------
qplot(long, lat, geom = "point", data = states)

## ---- fig.height=4, fig.width=7------------------------------------------
qplot(long, lat, geom = "path", data = states, group = group) + 
    coord_map()

## ---- fig.height=4, fig.width=7------------------------------------------
ggplot(data = states) + geom_sf()

## ------------------------------------------------------------------------
statereg <- read.csv("http://heike.github.io/rwrks/02-r-graphics/data/statereg.csv", stringsAsFactors = FALSE)

head(statereg)

## ------------------------------------------------------------------------
states$name <- tolower(states$name)
states.class.map <- left_join(states, statereg, by = c("name" = "State"))
glimpse(states.class.map)

## ----alt2, eval = FALSE, echo = FALSE, fig.height=4, fig.width=7---------
## qplot(long, lat, geom = "polygon", data = states.class.map,
##       group = group, fill = StateGroups, colour = I("black")) +
##     coord_map()

## ---- fig.height=4, fig.width=7------------------------------------------
ggplot(data = states.class.map) + geom_sf(aes(fill = StateGroups))

## ------------------------------------------------------------------------
states.stats <- read.csv("http://heike.github.io/rwrks/02-r-graphics/data/states.stats.csv", stringsAsFactors = FALSE)
glimpse(states.stats)

## ------------------------------------------------------------------------
states.map <- left_join(states, states.stats, by = c("name" = "state.name"))
glimpse(states.map)

## ----alt3, echo = FALSE, eval = FALSE, fig.height=3, fig.width=7---------
## qplot(long, lat, geom = "polygon", data = states.map,
##       group = group, fill = avg.qlrest2) + coord_map()

## ---- fig.height=3, fig.width=7------------------------------------------
ggplot(data = states.map) + geom_sf(aes(fill = avg.qlrest2))

## ------------------------------------------------------------------------
states.sex.stats <- read.csv("http://heike.github.io/rwrks/02-r-graphics/data/states.sex.stats.csv", stringsAsFactors = FALSE)
glimpse(states.sex.stats)

## ------------------------------------------------------------------------
states.sex.map <- left_join(states, states.sex.stats, by = c("name" = "state.name"))
glimpse(states.sex.map)

## ----alt4, echo = FALSE, eval = FALSE, fig.height=3, fig.width=7---------
## qplot(long, lat, geom = "polygon", data = states.sex.map,
##       group = group, fill = avg.drnk) + coord_map() +
##     facet_grid(sex ~ .)

## ---- fig.height=3, fig.width=7------------------------------------------
ggplot(data = states.sex.map) + geom_sf(aes(fill = avg.drnk)) +
  facet_grid(.~sex)

## ------------------------------------------------------------------------
states.health.stats <- read.csv("http://heike.github.io/rwrks/02-r-graphics/data/states.health.stats.csv", stringsAsFactors = FALSE)

## ----alt5, eval = FALSE, echo= FALSE, fig.height=3, fig.width=7----------
## qplot(long, lat, geom="polygon", data = states.map, group = group, fill = avg.drnk) +
##   coord_map()

## ---- fig.height=3, fig.width=7------------------------------------------
ggplot(data = states.map) + geom_sf(aes(fill = avg.drnk)) +
  theme_bw() +
  scale_fill_gradient2(limits = c(1.5, 3),low = "lightgray", high = "red") + 
  theme(axis.ticks = element_blank(),
       axis.text.x = element_blank(),
       axis.title.x = element_blank(),
       axis.text.y = element_blank(),
       axis.title.y = element_blank()) +
  ggtitle("Map of Average Number of Alcoholic Beverages\nConsumed Per Day by State")

