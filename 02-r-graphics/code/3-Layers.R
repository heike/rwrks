## ---- echo=FALSE, message=FALSE------------------------------------------
library(ggplot2)
library(sf)
library(albersusa)
#states <- map_data("state")
states <- usa_sf("longlat")

## ---- eval=FALSE---------------------------------------------------------
## load("noaa.rdata")

## ---- echo=FALSE---------------------------------------------------------
load("../data/noaa.rdata")

## ------------------------------------------------------------------------
glimpse(floats)

## ---- fig.height=4, fig.width=7------------------------------------------
qplot(Longitude, Latitude, colour = callSign, data = floats) + 
    coord_map()

## ---- fig.height=4, fig.width=7------------------------------------------
qplot(Longitude, Latitude, colour = callSign, data = gliders) + 
    coord_map()

## ---- fig.height=4, fig.width=7------------------------------------------
qplot(Longitude, Latitude, colour = callSign, data = boats) + 
    coord_map()

## ---- fig.height=3, fig.width=7, warning=FALSE---------------------------
ggplot() +
    geom_sf(data = states) + 
    geom_point(data = floats, aes(x = Longitude, y = Latitude, colour = callSign)) +   
    geom_point(aes(x, y), shape = "x", size = 5, data = rig) + 
    geom_text(aes(x, y), label = "BP Oil Rig", 
              size = 5, data = rig, hjust = -0.1) + 
    xlim(c(-91, -80)) + ylim(c(22,32))

## ---- eval=FALSE---------------------------------------------------------
## qplot(Longitude, Latitude, colour = callSign, data = floats)

## ---- eval=FALSE---------------------------------------------------------
## ggplot(data = floats,
##        aes(x = Longitude, y = Latitude, colour = callSign)) +
##   geom_point() +
##   scale_x_continuous() +
##   scale_y_continuous() +
##   scale_colour_discrete()

## ---- fig.height=3, fig.width=7------------------------------------------
ggplot(data = floats, 
       aes(x = Longitude, y = Latitude, colour = callSign)) +
  geom_point()

## ---- fig.height=4, fig.width=7, echo=FALSE, warning=FALSE---------------
ggplot(aes(x = Depth, y = Temperature, colour = callSign), data = floats) + geom_point()

## ---- fig.height=3, fig.width=7, warning=FALSE---------------------------
ggplot() +
    geom_sf(data = states) + 
    geom_point(data = floats, aes(x = Longitude, y = Latitude, colour = callSign)) +   
    geom_point(aes(x, y), shape = "x", size = 5, data = rig) + 
    geom_text(aes(x, y), label = "BP Oil Rig", size = 5, data = rig, hjust = -0.1) + 
    xlim(c(-91, -80)) + 
    ylim(c(22, 32))

## ------------------------------------------------------------------------
animal <- read.csv("http://heike.github.io/rwrks/02-r-graphics/data/animal.csv", stringsAsFactors = FALSE)

