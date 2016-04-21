tips <- read.csv("http://heike.github.io/rwrks/01-r-intro/data/tips.csv")

head(tips)
str(tips)
summary(tips)

install.packages("ggplot2")
library(ggplot2)

qplot(tip, total_bill, geom = "point", data = tips)
qplot(tip, total_bill, geom = "point", data = tips, colour = time)
qplot(tip, total_bill, geom = "point", data = tips) + geom_smooth(method = "lm")

tips$rate <- tips$tip / tips$total_bill
summary(tips$rate)

qplot(rate, data = tips, binwidth = .01)

tips[which.max(tips$rate),]

mean(tips$rate[tips$sex == "Male"])
mean(tips$rate[tips$sex == "Female"])

t.test(rate ~ sex, data = tips)

qplot(smoker, rate, geom = "boxplot", data = tips)
