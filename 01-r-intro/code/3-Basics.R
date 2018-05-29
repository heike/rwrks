library(tidyverse)
shed <- read_csv("http://heike.github.io/rwrks/01-r-intro/data/daily_shedding.csv")

final_shed <- shed %>% 
  group_by(pignum) %>% 
  mutate(gain = pig_weight[time_point == 21] - pig_weight[time_point == 0]) %>% filter(time_point == 21) %>% ungroup() %>% select(-c(4:9))
# Addition and Subtraction
2 + 5 - 1

# Multiplication
109*23452

# Division
3/7
# Integer division
7 %/% 2

# Modulo operator (Remainder)
7 %% 2

# Powers
1.5^3
x <- 5
MyAge <- 26
log(x)
MyAge^2
y <- c(1, 5, 3, 2)
y / 2
## help(head)
## ?head
shedding <- final_shed$total_shedding
treatment <- final_shed$treatment
a <- 10:15
a
shedding[3]
head(shedding)

shedding[c(1, 3, 5)]
shedding[1:5]
x <- c(2, 3, 5, 7)
x[c(TRUE, FALSE, FALSE, TRUE)]
x > 3.5
x[x > 3.5]
bad_shedder <- shedding > 50
shedding[bad_shedder]
sum(c(TRUE, TRUE, FALSE, TRUE, FALSE))
c(T, T, F, F) & c(T, F, T, F)
c(T, T, F, F) | c(T, F, T, F)
# Which are high shedders in the control group?
id <- (shedding > 50 & treatment == "control")
final_shed[id,]
x <- shedding[1:5]
x
x[1] <- 20
x
head(shedding)
shedding[bad_shedder] <- ":-("
head(shedding)
str(final_shed)
pignum <- head(final_shed$pignum)
pignum
as.character(pignum)
as.numeric("77")
pig_weight <- final_shed$pig_weight
x <- pig_weight[1:5]
length(x)
sum(x)
(n <- length(pig_weight))
(meanweight <- sum(pig_weight) / n)
(standdev <- sqrt(sum((pig_weight - meanweight)^2) / (n - 1)))
mean(pig_weight)
sd(pig_weight)
summary(pig_weight)
quantile(pig_weight, c(.025, .975))
