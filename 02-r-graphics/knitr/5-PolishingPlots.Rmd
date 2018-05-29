options(htmltools.dir.version = FALSE)
knitr::opts_chunk$set(
	echo = TRUE,
	message = FALSE,
	warning = FALSE,
	cache = TRUE
)
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


mtcars$gear <- factor(mtcars$gear)

p0 <- ggplot(mtcars, aes(x = wt, y = mpg, colour = gear)) + geom_point() 

p1 <- p0 + labs(title = "Default")
p2 <- p0 + theme_classic() + labs(title = "theme_classic")
p3 <- p0 + theme_bw() + labs(title = "theme_bw()")
p4 <- p0 + theme_dark() + labs(title = "theme_dark")
p5 <- p0 + theme_void() + labs(title = "theme_void")
p6 <- p0 + theme_minimal() + labs(title = "theme_minimal")

grid.arrange(p1, p2, p3, p4, p5, p6, nrow = 2)
library(ggthemes)

# Economist theme
# A theme that approximates the style of plots in The Economist magazine.
p1 <- p0 + theme_economist() + scale_colour_economist() + labs(title = "Economist")
#p2 <- p0 + theme_stata() + scale_colour_stata()  + labs(title = "Stata")
p3 <- p0 + geom_smooth(method = "lm", se = FALSE) +
  scale_color_fivethirtyeight("cyl") +
  theme_fivethirtyeight() + labs(title = "FiveThirtyEight")
p4 <- p0 + theme_igray() + scale_colour_tableau()  + labs(title = "Tableau")
p5 <-p0 + geom_rangeframe() +
  theme_tufte() + 
  scale_x_continuous(breaks = extended_range_breaks()(mtcars$wt)) +
  scale_y_continuous(breaks = extended_range_breaks()(mtcars$mpg)) + labs(title = "Tufte")
p6 <- p0 + theme_wsj() + scale_colour_wsj("colors6", "") + labs(title = "Wall Street Journal")

 p7 <- p0 + 
  ggtitle("Highcharts") +
  theme_hc() +
  scale_colour_hc()

p8 <- p0 +
  ggtitle("Highcharts dark") +
  theme_hc(bgcolor = "darkunica") +
  scale_fill_hc("darkunica")

p9 <- p0 + theme_excel() + scale_colour_excel() + labs(title = "Excel 2003")


grid.arrange(p1, p0, p3, p4, p5, p6, p7, p8, p9, nrow = 3)
theme_set(theme_bw())

ggplot(mtcars, aes(x = wt, y = mpg, colour = gear)) + geom_point()

## p1 <- ggplot(mpg) +
##   geom_bar(aes(x = class, colour = manufacturer, fill = manufacturer) )
## 
## p2 <- p1 + theme_classic() + theme(
##   ## modify plot background
##   plot.background = element_rect(fill = "lightskyblue1",colour = "pink",size = 0.5, linetype = "longdash")
##   )
p1 <- ggplot(mpg) + 
  geom_bar(aes(x = class, colour = manufacturer, fill = manufacturer) ) 

p2 <- p1 + theme_classic() + theme(
  ## modify plot background
  plot.background = element_rect(fill = "lightskyblue1",colour = "pink",size = 0.5, linetype = "longdash")
  )
grid.arrange(p1, p2, nrow = 1)
p3 <- p2 + theme(
  ### move and modify legend 
  legend.title = element_blank(),
  legend.position = "top", 
  legend.key = element_rect(fill = "lightskyblue1", color = "lightskyblue1"),
  legend.background = element_rect( fill = "lightskyblue1",color = "pink", size = 0.5,linetype = "longdash")
  )
grid.arrange(p2, p3, nrow = 1)
p4 <- p3 + theme(
  ### remove axis ticks
  axis.ticks=element_blank(),
  ### modify axis lines
  axis.line.y = element_line(colour = "pink", size = 1, linetype = "dashed"),
  axis.line.x = element_line(colour = "pink", size = 1.2, linetype = "dashed"))
grid.arrange(p3, p4, nrow = 1)
p5 <- p4 + labs(x = "Class of car", 
                y = "",
                title = "Cars by class and manufacturer",
                subtitle = "With a custom theme!!")
grid.arrange(p4, p5, nrow = 1)
p <- ggplot(mtcars, aes(x = wt, y = mpg, colour = gear)) + geom_point() 
p_zoom_in <- p + xlim(2, 4) + ylim(10, 25)
p_zoom_out <- p + xlim(0,7) + ylim(0, 45)
p <- ggplot(mtcars, aes(x = wt, y = mpg, colour = gear)) + geom_point() + theme(legend.position = "none") + ggtitle("Default")+ scale_color_locuszoom()
p_zoom_in <- p + xlim(2, 4) + ylim(10, 25) + ggtitle("Zoomed in")
p_zoom_out <- p + xlim(0,7) + ylim(0, 45) + ggtitle("Zoomed out")
grid.arrange(p, p_zoom_in, p_zoom_out, nrow = 1)
p <- ggplot(mtcars, aes(x = wt, y = mpg, colour = gear)) + geom_point() + scale_color_locuszoom()

library(plotly)
ggplotly(p)

## p1 <- ggplot(mtcars, aes(x = wt, y = mpg, colour = gear)) +
##   geom_point()
## 
## ggsave("mpg_by_wt.pdf", plot = p1)
ggplot(data = diamonds, aes(x = x, y = y))
## p1 <- ggplot(data = diamonds, aes(x = x, y = y, colour = clarity)) +
##     geom_point() +
##     ggtitle("Diamond y by x") +
##     theme(
##         legend.position = "bottom"
##     )
## p1
## 
## # ggsave("yourturn.pdf", plot = p1)
