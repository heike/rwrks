options(htmltools.dir.version = FALSE)
knitr::opts_chunk$set(
	echo = FALSE,
	message = FALSE,
	warning = FALSE
)
library(tidyverse)
library(ggsci)
library(ggthemes)
library(gridExtra)
library(grid)

grid_arrange_shared_legend <- function(..., ncol = length(list(...)), nrow = 1, position = c("bottom", "right")) {

  plots <- list(...)
  position <- match.arg(position)
  g <- ggplotGrob(plots[[1]] + theme(legend.position = position))$grobs
  legend <- g[[which(sapply(g, function(x) x$name) == "guide-box")]]
  lheight <- sum(legend$height)
  lwidth <- sum(legend$width)
  gl <- lapply(plots, function(x) x + theme(legend.position="none"))
  gl <- c(gl, ncol = ncol, nrow = nrow)

  combined <- switch(position,
                     "bottom" = arrangeGrob(do.call(arrangeGrob, gl),
                                            legend,
                                            ncol = 1,
                                            heights = unit.c(unit(1, "npc") - lheight, lheight)),
                     "right" = arrangeGrob(do.call(arrangeGrob, gl),
                                           legend,
                                           ncol = 2,
                                           widths = unit.c(unit(1, "npc") - lwidth, lwidth)))
  
  grid.newpage()
  grid.draw(combined)

  # return gtable invisibly
  invisible(combined)

}

data(iris)
knitr::kable(head(iris), format = 'html')
data(iris)
ggplot(iris) + geom_point(aes(x= Sepal.Length, y=Sepal.Width, colour = Species), size = 2.5)+ scale_color_locuszoom()
data(mtcars)


p1 <- ggplot(mtcars, aes(factor(cyl), fill = factor(cyl))) + geom_bar() + labs(x="Cyl", title = "Bar Chart")+scale_fill_grey(start=0.2, end= 0.8, name = "cyl")+theme(legend.position = "none")

p2 <- ggplot(mtcars, aes(factor(1), fill = factor(cyl))) + geom_bar(width=1) + coord_polar(theta="y") + labs(x="", title = "Pie Chart")+scale_fill_grey(start=0.2, end= 0.8, name = "cyl")+theme(legend.position = "none")

p3 <- ggplot(iris, aes(Sepal.Length)) + geom_histogram(bins=20)+ labs(x="", title = "Histogram")

#p3 <- png("images/stem-and-leaf.png")
#p3

p4 <- ggplot(iris, aes(Sepal.Length, Sepal.Width)) + geom_point()+ labs(x="", y="", title = "Scatterplot")

data <- data.frame(murder=USArrests$Murder, state=tolower(rownames(USArrests)))
map <- map_data("state")
map2 <- map %>% filter(region == "iowa")
p5 <- data %>% filter(state == "iowa") %>% ggplot() + geom_map(aes(map_id=state), map=map2, fill = "grey33") + expand_limits(x = map2$long, y = map2$lat)+ labs(title = "Map")
grid.arrange(p1, p2, p3, p4, p5, ncol = 5, nrow = 1)

# library(devtools)
# devtools::install_github("mangothecat/fftw3")
# install_github('omegahat/Rcartogram')
# ## Wait for installation, then:
# install_github('chrisbrunsdon/getcartr', subdir='getcartr')
# 
# library(Rcartogram)
# library(getcartr)
# library(ggplot2)
# world <- readShapePoly('TM_WORLD_BORDERS-0.3.shp')
# ## We are using the world's population data from World Bank
# world.pop <- read.csv(file = 'sp.pop.totl_Indicator_en_csv_v2.csv', stringsAsFactors = FALSE)
# ## Create a smaller dataset by retaining the world's population in 2013 and the ISO3
# ## country code, which will be used for matching and merging with the input shapefile
# smaller.data <- data.frame(Country.Code = world.pop$Country.Code, Population = world.pop$X2013)
# smaller.data <- na.omit(smaller.data)
# 
# ## Join the two datasets using their common field
# matched.indices <- match(world@data[, "ISO3"], smaller.data[, "Country.Code"])
# world@data <- data.frame(world@data, smaller.data[matched.indices, ])
# ## Compute the cartogram transformation of each country using its population
# ## with the degree of Gaussian blur = 0.5 (otherwise, it may not work)
# world.carto <- quick.carto(world, world@data$Population, blur = 0.5)
# 
# ## Convert the object into data frame
# world.f <- fortify(world.carto, region = "Country.Code")
# ## Merge the cartogram transformation with the world map shapefile
# world.f <- merge(world.f, world@data, by.x = "id", by.y = "Country.Code")
# ## Make a plot of the transformed polygons, where each country is
# ## further shaded by their population size (lighter means bigger)
# my_map <- ggplot(world.f, aes(long, lat, group = group, fill = world.f$Population)) + geom_polygon()
# ## Display the plot and give it a title
# (my_map <- my_map + ggtitle("Cartogram of the World Population (2013)"))

library(ggplot2)
library(dplyr)
library(tidyr)
library(ggradar)
library(ggmosaic)

iris2 <- iris %>% mutate(obs = 1:150) %>% gather(variable, value, -c(obs, Species)) 

#i1 <- ggplot()+ labs(x="", y="", title="Cartogram")



i2 <- ggplot(data = iris2) + 
 geom_line(aes(x = variable, y = value, group = interaction(Species, obs), color = Species)) + 
  #ggparcoord(data = iris, columns = 1:4, groupColumn = 5) +
  scale_colour_grey(start=0.2, end= 0.7) + 
  theme(legend.position = "none") + 
  labs(x="", y="", title="Parallel Coordinates")

i3 <- ggplot(diamonds) + 
  ggmosaic::geom_mosaic(aes(x=ggmosaic::product(color), fill = cut)) +
  scale_fill_grey(start=0.2, end= 0.7) + 
  theme(legend.position = "none") + labs(x="", y="", title="Mosaic Plot")


mtcars %>%
    tibble::rownames_to_column(var = "group") %>% 
     mutate_at(-1, funs(scales::rescale)) %>%
     tail(4) %>% select(1:10) -> mtcars_radar

 i4 <- ggradar(mtcars_radar, group.line.width = .7,
   group.point.size = 2, axis.label.size = 3.5, grid.label.size = 2.5, background.circle.transparency = 0.1, plot.legend =FALSE)+scale_colour_grey(start=0.4, end= 0.9)+ theme(legend.position = "none") + labs(x="", y="", title="Radar Charts")
# i4 <- ggplot()+ labs(x="", y="", title="Radar Charts")

df.team_data <- expand.grid(teams = c("Team A", "Team B", "Team C", "Team D") ,metrics = c("Metric 1", "Metric 2", "Metric 3", "Metric 4", "Metric 5"))

# add variable: performance
set.seed(41)
df.team_data$performance <- rnorm(nrow(df.team_data))

i5 <-ggplot(data = df.team_data, aes(x = metrics, y = teams)) +
  geom_tile(aes(fill = performance)) + scale_fill_distiller(palette = "Greys")+ theme(legend.position = "none") + labs(x="", y="", title="Heat Map")


grid.arrange(i2, i3, i4, i5, ncol = 4, nrow = 1)


a1 <- ggplot(diamonds, aes(depth)) +
    geom_density(aes(fill = cut), alpha = .8) +
    xlim(55, 70) + labs(x="", y="", title="Density Plot")+scale_colour_grey(start=0.6, end= 0.9)+scale_fill_grey(start=0.6, end= 0.9) + theme(legend.position = "none")

a2 <- ggplot(diamonds, aes(cut, price)) + geom_violin(aes(fill = cut), alpha = .8) + labs(x="", y="", title="Violin Plot")+scale_fill_grey(start=0.6, end= 0.9) + theme(legend.position = "none")


library(geomnet)
data(blood)

a3 <- ggplot(data = blood$edges, aes(from_id = from, to_id = to)) +
  geom_net(vertices=blood$vertices, aes(colour=..type..)) + 
  theme_net() +scale_colour_grey(start=0.4, end= 0.9)+ theme(legend.position = "none") + labs(x="", y="", title="Network Plot")


grid.arrange(a1, a2, a3, ncol = 3, nrow = 1)

library(ggsci)
data(diamonds)
p1 <- ggplot(diamonds, aes(cut, fill=cut)) + geom_bar() + labs(title = "Bar Chart", subtitle = "Cartesian coordinates")+ scale_fill_locuszoom()
p2 <- ggplot(diamonds, aes(factor(1), fill=cut)) + geom_bar(width=1) + labs(x="", title = "Fill-Bar", subtitle = "Cartesian coordinates") + scale_fill_locuszoom()
p3 <- ggplot(diamonds, aes(factor(1), fill=cut)) + geom_bar(width=1) + coord_polar(theta= "y") + labs(x="", title = "Fill-Bar", subtitle = "Polar coordinates")+ scale_fill_locuszoom()

grid.arrange(p1, p2, p3, ncol = 3, nrow = 1)
p1 <- ggplot(diamonds, aes(cut, fill=cut)) + geom_bar() + labs(title = "Bar Chart", subtitle = "Cartesian coordinates")+ scale_fill_locuszoom()
p2 <- ggplot(diamonds, aes(factor(1), fill=cut)) + geom_bar(width=1) + labs(x="", title = "Fill-Bar", subtitle = "Cartesian coordinates") + scale_fill_locuszoom()
p3 <- ggplot(diamonds, aes(factor(1), fill=cut)) + geom_bar(width=1) + coord_polar(theta= "y") + labs(x="", title = "Fill-Bar", subtitle = "Polar coordinates")+ scale_fill_locuszoom()
grid.arrange(p1, p2, p3, ncol = 3, nrow = 1)
## library(ggplot2)
## data(iris)
## p <- ggplot(data = iris, mapping = aes(x = Petal.Length, y = Petal.Width))
## p
## p + geom_point()
## 
## p1 <- ggplot(data = iris, mapping = aes(x = Petal.Length, y = Petal.Width))
## 
## p2 <- p1 + geom_point()
## p3 <- p1 + geom_point(aes(color = Species)) + theme(legend.position = "none")
## 
## grid.arrange(p1, p2, ncol = 2, nrow = 1)
## 
ggplot(data = diamonds)
## ggplot(data = diamonds, aes(x = carat, y = price))
## 
ggplot(data = diamonds, aes(x = carat, y = price))+ scale_fill_locuszoom()
## ggplot(data = diamonds, aes(x = carat, y = price)) +
##     geom_point()
ggplot(data = diamonds, aes(x = carat, y = price)) +
    geom_point()+ scale_color_locuszoom()
## ggplot(data = diamonds, aes(x = carat, y = price)) +
##     geom_point(aes(colour = cut))
ggplot(data = diamonds, aes(x = carat, y = price)) +
    geom_point(aes(colour = cut)) + scale_color_locuszoom()
## ggplot(data = diamonds, aes(x = carat, y = price)) +
##     geom_point(aes(colour = cut)) +
##    geom_smooth()
ggplot(data = diamonds, aes(x = carat, y = price)) +
    geom_point(aes(colour = cut)) +
    geom_smooth() + scale_color_locuszoom()
## ggplot(data = diamonds, aes(x = carat, y = price) +
##     geom_point(aes(colour = cut), size = 2, alpha = .5) +
##     geom_smooth((aes(fill = cut), colour = "lightgrey"))
ggplot(data = diamonds, aes(x = carat, y = price)) +
    geom_point(aes(colour = cut), size = 2, alpha = .5) + scale_color_locuszoom()+ scale_fill_locuszoom()+
    geom_smooth(aes(fill = cut), colour = "lightgrey")
## ggplot(data = diamonds, aes(x = carat, y = price)) +
##     geom_point(aes(colour = cut), size = 2, alpha = .5) +
##     geom_smooth(aes(fill = cut)) +
##     scale_y_log10()
ggplot(data = diamonds, aes(x = carat, y = price)) +
    geom_point(aes(colour = cut), size = 2, alpha = .5) +
    geom_smooth(aes(fill = cut)) + scale_color_locuszoom()+ scale_fill_locuszoom()+ scale_y_log10()
## ggplot(data = diamonds, aes(x = carat, y = price)) +
##     geom_point(aes(colour = cut), size = 2, alpha = .5) +
##     geom_smooth() +
##     scale_y_log10() +
##     facet_wrap(~cut)
ggplot(data = diamonds, aes(x = carat, y = price)) +
    geom_point(aes(colour = cut), size = 2, alpha = .5) +
    geom_smooth(aes(fill = cut)) + scale_color_locuszoom()+ scale_fill_locuszoom()+
    scale_y_log10()+
    facet_wrap(~cut)
