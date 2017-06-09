## ---- echo=FALSE, message=FALSE, warning=FALSE, fig.height=4, fig.width=7----
library(scales)
library(ggplot2)

data <- data.frame(expand.grid(x = 1:6, y = 1:6), color = sample(c(1, 2), 36, replace = TRUE))
data$x <- data$x + rnorm(36, 0, .25)
data$y <- data$y + rnorm(36, 0, .25)
data$shape <- c(rep(2, 15), 1, rep(2,20))

new_theme_empty <- theme_bw()
new_theme_empty$line <- element_blank()
new_theme_empty$rect <- element_blank()
new_theme_empty$strip.text <- element_blank()
new_theme_empty$axis.text <- element_blank()
new_theme_empty$plot.title <- element_blank()
new_theme_empty$axis.title <- element_blank()
new_theme_empty$plot.margin <- structure(c(0, 0, -1, -1), unit = "lines", valid.unit = 3L, class = "unit")

qplot(x, y, data = data, color = factor(1, levels = 1:2), shape = factor(shape), size = I(5)) +
    scale_shape_manual(guide = "none", values = c(19, 15)) + 
    scale_color_discrete(guide = "none") + 
    new_theme_empty

## ---- fig.height=4, fig.width=7, echo=FALSE------------------------------
data$shape <- c(rep(2, 25), 1, rep(2, 10))
qplot(x, y, data = data, color = factor(shape), shape = I(19), size = I(5)) +
    scale_shape_manual(guide = "none", values = c(19, 15)) + 
    scale_color_discrete(guide = "none") + 
    new_theme_empty

## ---- fig.height=5, fig.width=7, echo=FALSE------------------------------
data$shape <- data$color
qplot(x, y, data = data, color = factor(color), shape = factor(shape), size = I(5)) +
    scale_shape_manual(guide = "none", values = c(19, 15)) + 
    scale_color_discrete(guide = "none") + 
    new_theme_empty

## ---- fig.height=5, fig.width=7, echo=FALSE------------------------------
data$shape[1] <- if(data$shape[1]==2) 1 else 2
qplot(x, y, data = data, color = factor(shape), shape = I(19), size = I(5)) +
    scale_shape_manual(guide = "none", values = c(19, 15)) + 
    scale_color_discrete(guide = "none") + 
    new_theme_empty

## ---- fig.height=2, fig.width=7------------------------------------------
frame <- read.csv("http://heike.github.io/rwrks/02-r-graphics/data/frame.csv")
qplot(x, y, data = frame, shape = g1, colour = g2, size = I(4))

## ---- echo=FALSE, fig.width=7, fig.height=3------------------------------
library(RColorBrewer)
library(gridExtra)

data <- data.frame(x = c(1, 2, 3, 4, 5), 
                   y = c(1, 4, 9, 10, 12), 
                   size = c(1, 4, 2, 1, 5))

p1 <- qplot(x, y, data = data, size = size, geom = "point") + 
    scale_size_continuous(range = c(2.5, 5), guide = "none") + 
    theme_bw()  + 
    theme(axis.text = element_blank())

data <- data.frame(x = factor(c(1, 2, 3, 4, 5)), 
                   y = c(4, 3, 1, 5, 2))

p2 <- ggplot(data = data, aes(x = x, weight = y)) + 
    geom_bar() + 
    theme_bw() + 
    theme(axis.text = element_blank())

data <- data.frame(expand.grid(x = 1:6, y = 1:2), 
                   color = c(brewer.pal(7, "Blues")[2:7], 
                             brewer.pal(6, "Set1")))

p3 <- ggplot(data = data, aes(x = x, y = factor(y), color = color)) + 
    geom_point(size = 5) + 
    scale_color_identity() + 
    ylab("") + 
    xlab("") + 
    theme_bw() + 
    theme(axis.text = element_blank())

grid.arrange(p1, p2, p3, nrow = 1)

## ---- echo=FALSE, fig.width=7, fig.height=1.5----------------------------
data <- data.frame(x = 1:7, 
                   blues = brewer.pal(7, "Blues"), 
                   set1 = brewer.pal(7, "Set1"), 
                   diverge = brewer.pal(7,"RdBu"))

qplot(xmin = x-.5, xmax = x+.5, ymin = 0, ymax = 1, data = data, geom = "rect", color = I("black"), fill = set1) + 
    scale_fill_identity() + 
    ylab("") + 
    xlab("") + 
    theme(axis.text = element_blank(), 
          axis.ticks = element_blank(), 
          rect = element_blank()) + 
    coord_fixed(ratio = 1) + 
    new_theme_empty

## ---- echo=FALSE, fig.width=7, fig.height=1.5----------------------------
qplot(xmin = x-.5, xmax = x+.5, ymin = 0, ymax = 1, data = data, geom = "rect", color = I("black"), fill = blues) + 
    scale_fill_identity() + 
    ylab("") + 
    xlab("") + 
    theme(axis.text = element_blank(), 
          axis.ticks = element_blank(), 
          rect = element_blank()) + 
    coord_fixed(ratio = 1) + 
    new_theme_empty

## ---- echo=FALSE, fig.width=7, fig.height=1.5----------------------------
qplot(xmin = x-.5, xmax = x+.5, ymin = 0, ymax = 1, data = data, geom = "rect", color = I("black"), fill = diverge) + 
    scale_fill_identity() + 
    ylab("") + 
    xlab("") + 
    theme(axis.text = element_blank(), 
          axis.ticks = element_blank(), 
          rect = element_blank()) + 
    coord_fixed(ratio = 1) + 
    new_theme_empty

## ---- fig.width=7, fig.height=4------------------------------------------
display.brewer.all()

## ---- fig.width=7, fig.height=3------------------------------------------
qplot(carat, price, shape = cut, colour = clarity, data = diamonds)

## ---- fig.width=7, fig.height=3------------------------------------------
qplot(price, carat, data = diamonds, color = color, facets = . ~ clarity)

## ------------------------------------------------------------------------
movies <- read.csv("http://heike.github.io/rwrks/02-r-graphics/data/MovieSummary.csv")

