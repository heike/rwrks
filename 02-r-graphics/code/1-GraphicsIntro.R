## ---- echo=FALSE---------------------------------------------------------
library(ggplot2)

## ----eval = FALSE--------------------------------------------------------
## source("../code/0-Setup.R")

## ------------------------------------------------------------------------
head(diamonds)

## ---- fig.height=4, fig.width=7------------------------------------------
qplot(carat, price, geom = "point", data = diamonds)

## ---- fig.height=3, fig.width=7------------------------------------------
qplot(carat, log(price), geom = "point", data = diamonds, 
	alpha = I(0.2), colour = color, 
	main = "Log price by carat weight, grouped by color") + 
    xlab("Carat Weight") + ylab("Log Price")

## ------------------------------------------------------------------------
tips <- read.csv("http://heike.github.io/rwrks/02-r-graphics/data/tips.csv")

## ---- fig.height=4, fig.width=7------------------------------------------
qplot(carat, geom = "histogram", data = diamonds)

## ---- fig.height=4, fig.width=7------------------------------------------
qplot(carat, geom = "histogram", data = diamonds, binwidth = 0.2, facets = .~cut)

## ---- fig.height=4, fig.width=7------------------------------------------
qplot(cut, price, geom = "boxplot", data = diamonds)

## ---- fig.height=3, fig.width=7------------------------------------------
qplot(cut, log(price), geom = "boxplot", data = diamonds, 
	main = "Boxplots of log Diamond Prices Grouped by Cut Quality") +
	geom_jitter(alpha = I(.025))

## ------------------------------------------------------------------------
titanic <- as.data.frame(Titanic)

## ---- fig.height=4, fig.width=7------------------------------------------
qplot(Survived, geom = "bar", data = titanic, weight = Freq)

## ---- fig.height=4, fig.width=7------------------------------------------
qplot(Survived, geom = "bar", data = titanic, weight = Freq, 
      facets = Sex~Class)

