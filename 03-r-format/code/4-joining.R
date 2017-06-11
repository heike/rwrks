knitr::opts_chunk$set(echo = TRUE)
library(tidyverse)
box <- read.csv("../data/boxoffice.csv")
head(box, 4)
box <- box %>% mutate(
  Gross = parse_number(Gross),
  Total.Gross = parse_number(Total.Gross),
  Days = parse_number(Days),
  Theaters = parse_number(Theaters)
) 
## # if we get an error with a message about the length of a dataset
## # we know we have a problem
## movie <- box %>% group_by(Movie) %>% summarize(
##   Distributor = unique(Distributor)
## )
box %>% group_by(Movie) %>% summarize(
  Distributor = length(unique(Distributor))
) %>% arrange(desc(Distributor))
box <- box %>% mutate(
  Distributor = replace(Distributor, Movie=="Girlhood", "Strand")
)
box <- box %>% mutate(Release = lubridate::ymd(Date)-Days)
movie <- box %>% group_by(Movie, Release) %>% summarize(
  Distributor = unique(Distributor) 
)
dim(movie)
length(unique(box$Movie))
movie %>% group_by(Movie) %>% count() %>% arrange(desc(n)) %>% head(5)
movie %>% filter(Movie =="Hot Water")
# introduce release date for each movie and distributor separately
box <- box %>% group_by(Movie, Distributor) %>% 
  mutate(
    Release = min(lubridate::ymd(Date))-Days[which.min(lubridate::ymd(Date))]
    )

# split again
movie <- box %>% group_by(Movie, Release) %>% summarize(
  Distributor = unique(Distributor) 
)
dim(movie)
length(unique(box$Movie)) # should be one less than above (b/c The Witness)
# days and per theatre gross:
box <- box %>% ungroup() %>% mutate(
  Days_new = lubridate::ymd(Date) - lubridate::ymd(Release),
  Per.Theater = Gross/Theaters
) 
box %>% select(Movie, Days, Days_new)
# introduce change variable and rank-last-week:
box <- box %>% group_by(Movie, Release) %>% arrange(Date) %>% mutate(
  Change = c(NA, diff(Gross)/Gross[-length(Gross)])*100,
  Rank.Last.Week_new = c(NA, Rank[-length(Rank)]),
  Days_diff = c(NA, diff(Days_new))
) 
# some of these ranks are not from last week:
box <- box %>% mutate(
  Rank.Last.Week_new = replace(Rank.Last.Week_new, Days_diff != 7, NA)
)

box %>% filter(Movie=="3 Hearts") %>% arrange(Days_new) %>% as.data.frame() %>% head(3)
box <- box %>% group_by(Movie, Release) %>% 
  arrange(Days) %>% mutate(
    Gross_new = c(NA, diff(Total.Gross))
  )

box %>% 
  ggplot(aes(Gross, Gross_new, colour = Gross_new < 0)) + geom_point()

box %>% ungroup() %>%  filter(Gross_new <0) %>% select(Movie, Date, Gross, Gross_new, Total.Gross) %>% arrange(Gross_new)
## movies <- box %>% select(Date, Rank, Rank.Last.Week_new, Days_new, Movie, Distributor, Gross, Change, Total.Gross, Release, Theaters, Per.Theater)
## names(movies) <- c("Date", "Rank", "Rank.Last.Week", "Days", "Movie", "Distributor", "Gross", "Change", "Total.Gross", "Release", "Theaters", "Per.Theater")
## #write.csv(movies, file="../data/movies.csv", row.names=FALSE)
library(Lahman)
LahmanData
HallOfFame <- HallOfFame %>% group_by(playerID) %>% 
  mutate(times = order(yearID)) 

HallOfFame %>%
  ggplot(aes(x = yearID, y = votes/needed, colour = inducted)) + 
  geom_hline(yintercept = 1, colour = "grey20", size = .1) +
  geom_line(aes(group = playerID), colour = "black", size = 0.2) +
  geom_point() 
HallOfFame %>% 
  ggplot(aes(x = times, y = votes/needed, colour = inducted)) + 
  geom_hline(yintercept = 1, colour = "grey20", size = .1) +
  geom_line(aes(group = playerID), colour = "black", size = 0.2) +
  geom_point() 
df1 <- data.frame(id = 1:6, trt = rep(c("A", "B", "C"), rep=c(2,1,3)), value = c(5,3,7,1,2,3))
df1
df2 <- data.frame(id=c(4,4,5,5,7,7), stress=rep(c(0,1), 3), bpm = c(65, 125, 74, 136, 48, 110))
df2
left_join(df1, df2, by="id")
inner_join(df1, df2, by = "id")
full_join(df1, df2, by = "id")
anti_join(df1, df2, by="id") # no values for id in df2
anti_join(df2, df1, by="id") # no values for id in df1
Voted <- HallOfFame %>% filter(!is.na(ballots)) %>% 
  group_by(playerID) %>% arrange(yearID) %>% 
  mutate( attempt = order(yearID))

dim(Voted)
Voted <- left_join(Voted, Master %>% select(playerID, nameFirst, nameLast), 
                   by = "playerID")
dim(Voted)
Voted %>% ggplot(aes(x = attempt, y = votes/needed)) +
  geom_hline(yintercept = 1, colour = "grey25", size = 0.1) +
  geom_line(aes(group = playerID), colour = "grey35", size = 0.2) + 
  geom_point(aes(colour = inducted))
labels <- Voted %>% group_by(playerID) %>% summarize(
  votes = votes[which.max(attempt)],
  needed = needed[which.max(attempt)],
  attempt = max(attempt),
  name = paste(unique(nameFirst), unique(nameLast))
)
Voted %>% ggplot(aes(x = attempt, y = votes/needed)) +
  geom_hline(yintercept = 1, colour = "grey25", size = 0.1) +
  geom_line(aes(group = playerID), colour = "grey25", size = 0.2) + 
  geom_point(aes(colour = inducted)) +
  ggrepel::geom_label_repel(aes(label=name), data = labels %>% filter(attempt >=16))
