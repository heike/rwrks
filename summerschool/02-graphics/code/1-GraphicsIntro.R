library(ggplot2)

head(diamonds)

qplot(carat, price, geom = "point", data = diamonds)
qplot(carat, log(price), geom = "point", data = diamonds, 
	alpha = I(0.2), colour = color, 
	main="Log price by carat weight, grouped by color")

tips <- read.csv("http://heike.github.io/rwrks/02-r-graphics/data/tips.csv")

qplot(carat, geom = "histogram", data = diamonds)
qplot(carat, geom = "histogram", data = diamonds, binwidth = 0.2, facets = .~cut)

qplot(cut, price, geom = "boxplot", data = diamonds)
qplot(cut, log(price), geom = "boxplot", data = diamonds, 
	main = "Boxplots of log Diamond Prices Grouped by Cut Quality") +
	geom_jitter(alpha = I(.025))

titanic <- as.data.frame(Titanic)

qplot(Survived, geom = "bar", data = titanic, weight = Freq)
qplot(Survived, geom = "bar", data = titanic, weight = Freq, 
      facets = Sex~Class)
