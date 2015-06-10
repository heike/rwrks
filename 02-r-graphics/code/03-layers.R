# ---------------------------------------------------------------------------
# Read in data
# ---------------------------------------------------------------------------

#x <- ls()
#noaa <- "http://heike.github.io/rwrks/02-r-graphics/data/03-data/noaa.rdata"
#if (!file.exists("noaa.rdata")) download.file(noaa, "noaa.rdata")
#load("noaa.rdata")
#setdiff(ls(), x)

boats <- read.csv("http://heike.github.io/rwrks/02-r-graphics/data/boats.csv")
floats <- read.csv("http://heike.github.io/rwrks/02-r-graphics/data/floats.csv")
gliders <- read.csv("http://heike.github.io/rwrks/02-r-graphics/data/gliders.csv")
rig <- read.csv("http://heike.github.io/rwrks/02-r-graphics/data/rig.csv")

# ---------------------------------------------------------------------------
# Start analyzing
# ---------------------------------------------------------------------------

str(floats)

library(ggplot2)
qplot(Longitude, Latitude, colour = callSign, data = floats) + 
  coord_map()

str(gliders)

ggplot(data = gliders, aes(x = Longitude, y = Latitude, colour = callSign)) + 
  geom_point() + coord_map()

str(boats)

ggplot(data = boats, aes(x = Longitude, y = Latitude, colour = callSign)) + 
  geom_point() + coord_map()

states <- map_data("state")
map_outline <- ggplot() +
  geom_path(data = states, aes(x = long, y = lat, group = group)) + 
  xlim(c(-91, -80)) + ylim(c(22,32)) + coord_map()
map_outline

map_floats <- map_outline +
  geom_point(data = floats, aes(x = Longitude, y = Latitude, colour = callSign))
map_floats

map_outline +
  geom_point(data = floats, aes(x = Longitude, y = Latitude, colour = Depth))

rig # location of BP Oil rig
map_floats +
  geom_point(data = rig, aes(x, y), shape = "x", size = 5) + 
  geom_text(data = rig, aes(x, y), label = "BP Oil rig", 
            size = 5, hjust = -0.1)

# ---------------------------------------------------------------------------
# Your Turn!!!
# ---------------------------------------------------------------------------

p <- ggplot(data = diamonds, aes(x = carat, y = price)) +
  geom_point() +           # layer 1
  geom_smooth(method = lm) # layer 2
p

(p <- p + scale_x_log10() + scale_y_log10())

p + coord_polar()
p + facet_grid(. ~ cut)

args(geom_point)
args(geom_smooth)
args(geom_bar)

base <- ggplot(diamonds, aes(x = cut, fill = clarity)) 
base + geom_bar() + theme(legend.position = "none") # bad!!!
base + geom_bar(position = "fill") + 
  theme(legend.position = "none")                   # better
base + geom_bar(position = "dodge")                 # better

# ---------------------------------------------------------------------------
# Your Turn!!!
# ---------------------------------------------------------------------------

animals <- read.csv("http://heike.github.io/rwrks/02-r-graphics/data/animal.csv")

