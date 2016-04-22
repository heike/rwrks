library(ggplot2)
library(dplyr)

states <- map_data("state")
head(states)

qplot(long, lat, geom = "point", data = states)

qplot(long, lat, geom = "path", data = states, group = group) + 
    coord_map()

qplot(long, lat, geom = "polygon", data = states, group = group) + 
    coord_map()

statereg <- read.csv("http://heike.github.io/rwrks/02-r-graphics/data/statereg.csv")
head(statereg)

states.class.map <- left_join(states, statereg, by = c("region" = "State"))
head(states.class.map)

qplot(long, lat, geom = "polygon", data = states.class.map, 
      group = group, fill = StateGroups, colour = I("black")) + 
    coord_map() 

states.stats <- read.csv("http://heike.github.io/rwrks/02-r-graphics/data/states.stats.csv")
head(states.stats)

states.map <- left_join(states, states.stats, by = c("region" = "state.name"))
head(states.map)

qplot(long, lat, geom = "polygon", data = states.map, 
      group = group, fill = avg.qlrest2) + coord_map()

states.sex.stats <- read.csv("http://heike.github.io/rwrks/02-r-graphics/data/states.sex.stats.csv")
head(states.sex.stats)

states.sex.map <- left_join(states, states.sex.stats, by = c("region" = "state.name"))
head(states.sex.map)

qplot(long, lat, geom = "polygon", data = states.sex.map, 
      group = group, fill = avg.drnk) + coord_map() + 
    facet_grid(sex ~ .)

states.health.stats <- read.csv("http://heike.github.io/rwrks/02-r-graphics/data/states.health.stats.csv")

qplot(long, lat, geom="polygon", data = states.map, group = group, fill = avg.drnk) + 
  coord_map() +  theme_bw() +
  scale_fill_gradient2(limits = c(1.5, 3),low = "lightgray", high = "red") + 
  theme(axis.ticks = element_blank(),
       axis.text.x = element_blank(),
       axis.title.x = element_blank(),
       axis.text.y = element_blank(),
       axis.title.y = element_blank()) +
  ggtitle("Map of Average Number of Alcoholic Beverages Consumed Per Day by State")

