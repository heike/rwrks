## ----setup, include=FALSE------------------------------------------------
options(htmltools.dir.version = FALSE)
knitr::opts_chunk$set(
	echo = FALSE,
	message = FALSE,
	warning = FALSE
)

## ------------------------------------------------------------------------
library(ggplot2)
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


## ------------------------------------------------------------------------
library(Tmisc)
library(tidyverse)
data(quartet)
# quartet %>%
#   group_by(set) %>%
#   summarize(mean(x), sd(x), mean(y), sd(y), cor(x,y))

## ---- fig.align = "center"-----------------------------------------------

ggplot(quartet, aes(x, y)) + geom_point(colour = "darkorange1", size = 2) + geom_smooth(method = lm, se = FALSE, colour = "grey19", alpha = .5) + facet_wrap(~set)



## ---- eval = FALSE-------------------------------------------------------
## preg <- read.csv("data/preg.csv", stringsAsFactors = FALSE)
## preg
## knitr::kable(preg, format = 'html')
## preg2 <- read.csv("data/preg2.csv", stringsAsFactors = FALSE)
## preg2
## knitr::kable(preg2, format = 'html')
## 
## preg3 <- preg %>% gather(treatment, measurement, -name)
## preg3
## 

## ----fig.width=3, fig.height=3.7,echo=FALSE, fig.align="center"----------
library(png)
library(grid)
img <- readPNG("images/tablelong2.png")
 grid.raster(img)

## ---- eval=FALSE, echo=TRUE----------------------------------------------
## data(french_fries, package="reshape2")
## head(french_fries)
## 

## ---- eval=FALSE, echo=TRUE----------------------------------------------
## 
## french_fries_long <- french_fries %>%
##   gather(key = variable, value = rating, potato:painty)
## head(french_fries_long)
## 

