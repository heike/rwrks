###################
### Your Turn 1 ###
###################
qplot(Depth, Temperature, colour=callSign, data=floats)   
ggplot(aes(Depth, Temperature, colour=callSign), data=floats)  + geom_point()

###################
### Your Turn 2 ###
###################
# install.packages("maps")  # if you do not have the maps package
library(maps)
states <- map_data("state")
head(states)

animals <- read.csv("http://www.public.iastate.edu/~hofmann/looking-at-data/data/animal.csv")
head(animals)

qplot(Longitude, Latitude, data=animals)
qplot(Longitude, Latitude, data=animals, colour=class)
qplot(Longitude, Latitude, data=subset(animals, Alive=="N"), colour=class)

# save map layer:
map <- ggplot() +
  geom_path(data=states, aes(x=long, y=lat, group=group))

# save the layer for sighting locations for dead animals:
sightings <- geom_point(aes(Longitude, Latitude, colour=class), 
                        data=subset(animals, Alive=="N"))

# add map and crop:
map + sightings + 
  geom_point(aes(x, y), shape="x", size=5, data=rig) + 
  geom_text(aes(x, y), label="BP Oil rig", shape="x", size=5, data=rig, hjust = -0.1) + 
  xlim(c(-98, -80)) + 
  ylim(c(24,33))

levels(animals$class)
levels(animals$class) <- c("Birds", "Mammals", "Reptiles")

# indicate time - make use of Date variable
# install.packages("lubridate")
library(lubridate)

animals$Date <- as.Date(animals$Date)
sightings <- geom_point(aes(Longitude, Latitude, colour=as.numeric(Date), shape=class), data=subset(animals, Alive=="N")) 

map + sightings + 
  scale_colour_gradient() +
  geom_point(aes(x, y), shape="x", size=5, data=rig) + 
  geom_text(aes(x, y), label="BP Oil rig", shape="x", size=5, data=rig, hjust = -0.1) + 
  xlim(c(-98, -80)) + 
  ylim(c(24,33))

sightings <- geom_point(aes(Longitude, Latitude, colour=month(Date), shape=class), data=subset(animals, Alive=="N")) 

map + sightings + 
  geom_point(aes(x, y), shape="x", size=5, data=rig) + 
  geom_text(aes(x, y), label="BP Oil rig", shape="x", size=5, data=rig, hjust = -0.1) + 
  xlim(c(-98, -80)) + 
  ylim(c(24,33))

#################
