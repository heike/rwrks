library(ggplot2)

states <- map_data("state")

qplot(carat, price, data = diamonds)
qplot(carat, price, data = diamonds) + theme_bw()

theme_set(theme_bw())

qplot(carat, price, data = diamonds) +
    ggtitle("Price vs Carat for Diamonds")

p <- qplot(carat, price, data = diamonds) + 
    ggtitle("Price vs Carat for Diamonds")
p + theme(plot.title = element_text(colour = "red", angle = 45))

p + theme(
    axis.text.x = element_blank(),
    axis.text.y = element_blank(),
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    axis.ticks.length = unit(0, "cm")
)

qplot(price, carat, data = diamonds)
 
ggsave("diamonds.png")
ggsave("diamonds.pdf")
ggsave("diamonds.png", width = 6, height = 6)

dplot <- qplot(carat, price, data = diamonds)
ggsave("diamonds.png", plot = dplot, dpi = 72)

