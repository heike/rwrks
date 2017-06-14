
# 4 - Joining Your Turns ###########
#- Load the `Lahman` package into your R session.
#- Join (relevant pieces of) the `Master` data set and the `HallOfFame` data.
#- For the `ggplot2` chart label all last attempts of individuals with 15 or more attempts. Make sure to deal with missing values appropriately.

## Solution

# Not all organizations involved in inducting worthy candidates into the Hall of Fame take votes. <br>
#  We will take only voters into consideration:

Voted <- HallOfFame %>% filter(!is.na(ballots)) %>% 
  group_by(playerID) %>% arrange(yearID) %>% 
  mutate( attempt = order(yearID))

dim(Voted)
Voted <- left_join(Voted, Master %>% select(playerID, nameFirst, nameLast), 
                   by = "playerID")
dim(Voted)

## Chart of induction

Voted %>% ggplot(aes(x = attempt, y = votes/needed)) +
  geom_hline(yintercept = 1, colour = "grey25", size = 0.1) +
  geom_line(aes(group = playerID), colour = "grey35", size = 0.2) + 
  geom_point(aes(colour = inducted))


## Getting the dataset for the labels

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


##### tidyr your turn solutions

# billboard your turn solution

long_billboard <- gather(billboard, key = week, value = rank, X1:X76)
long_billboard$week <- as.numeric(gsub("X", "", long_billboard$week))

ggplot(long_billboard) + geom_line(aes(week, rank, colour = artist))+
  xlim(c(0, 30))

# occupation your turn solution

occupation <- read.csv("../data/occupation-1870.csv")

# combine all of the variables (except for State) 
# into a single variable
occupation <- occupation %>% 
  gather(key="Occ.gender", value="Number", 2:11)
occupation %>% glimpse()

# split Occ.gender into two variables
occupation <- occupation %>% 
  separate(Occ.gender, into = c("Occupation", "Gender"))
occupation %>% glimpse()

# now spread the data again
occ2 <- occupation %>% spread(Gender, Number)
occ2 %>% glimpse()

occ2 %>% 
  ggplot(aes(x = Male, y = Female)) + geom_point() + 
  facet_wrap(~Occupation)

# flights your turn solution


flights <- read.csv("http://heike.github.io/rwrks/03-r-format/data/flights.csv")

flights$date <- ymd(paste(flights$year, flights$month, flights$day, sep = "-"))
delay.dat <- flights %>% 
  group_by(date) %>% 
  summarise(dep_delay = mean(dep_delay, na.rm = TRUE))

ggplot(delay.dat) + geom_line(aes(date, dep_delay))


###########################################################################
###########################################################################
##### LAST YEAR'S YOUR TURN ##########

# ### Files 
# #-------------------------------------------
# 
# 	## Your turn 1 - read.table and read.csv Have a look at the parameters of read.table (?read.table) to solve the following problems: 
# 	# Read the first two lines of the file into an object called midwest_names
# 	
# 	midwest_names <- read.csv("http://heike.github.io/rwrks/03-r-format/data/midwest.csv", nrow = 2)
# 
# 	 	
# 	#Read everything EXCEPT the first two lines into an object called midwest_data
# 	
# 	midwest_data <- read.csv("http://heike.github.io/rwrks/03-r-format/data/midwest.csv", skip = 2)
# 	
# 	## Your turn 2 - foreign
# 	
# 	# The NHANES (National Health and Nutrition Survey) publishes data in the SAS xport format: http://wwwn.cdc.gov/Nchs/Nhanes/Search/nhanes13_14.aspx 
# 	# Scroll to the bottom, choose one of the datasets (Demographics, Examination, etc.). Download the Data file (XPT) 
# 	# Use read.xport() to load the file into R
# 	
# 	library(foreign)
# 	read.xport("~/Downloads/BMX_H.XPT")
# 
# 
# ### Summarizing
# #-------------------------------------------
# 
# 	## Your Turn 1 - Baseball 
# 	library(dplyr)
# 	data(baseball, package = "plyr")
# 	
# 	
# 	# MLB rules for the greatest all-time hitters are that players have to have played at 
# 	# least 1000 games with at least as many at-bats in order to be considered.
# 	# Extend the for loop above to collect the additional information 
# 	# Introduce and collect data for two new variables: games and atbats
# 	
# 	baseball %>% group_by(id) %>% 
# 	  summarise(games = sum(g, na.rm=T), atbats = sum(ab, na.rm = T),
# 	             ba = mean(h/ab, na.rm = T), lastyr = max(year)) %>% 
# 	  filter(games >= 1000 & atbats >=1000) %>%
# 	  arrange(desc(ba))
# 	
# 	
# 	players <- unique(baseball$id) 
# 	ba <- rep(NA, length(players)) 
# 	games <- rep(NA, length(players)) 
# 	atbats <- rep(NA, length(players)) 
# 	for(i in 1:length(players)) { 
# 		career <- subset(baseball, id == players[i]) 
# 		ba[i] <- with(career, mean(h / ab, na.rm = TRUE)) 
# 		games[i] <- with(career, sum(g, na.rm = TRUE))
# 		atbats[i] <- with(career, sum(ab, na.rm = TRUE))
# 	}
# 	ba2 <- NULL
# 	games2 <- NULL
# 	atbats2 <- NULL
# 	for(name in players) { 
# 	  career <- subset(baseball, id == name) 
# 	  ba1 <- with(career, mean(h / ab, na.rm = TRUE)) 
# 	  ba2 <- c(ba2, ba1)
# 	  g1 <- with(career, sum(g, na.rm = TRUE))
# 	  games2 <- c(games2, g1)
# 	  ab1 <- with(career, sum(ab, na.rm = TRUE))
# 	  atbats2 <- c(atbats2, ab1)
# 	}
# 	
# 	## Your turn 2 - dplyr 
# 	
# 	# Find some summary statistics for each of the teams (variable team): 
# 		# How many different (unique) players has the team had? 
# 		# What was the team’s first/last season? 
# 	
# 	summarise(group_by(baseball, team),
# 	          nplayer = length(unique(id)), 
# 	          first = min(year), 
# 	          last = max(year))
# 	
# 	# Challenge: Find the number of players on each team over time. Does the number change?
# 	
# 	summarize(group_by(baseball, team, year),
# 	          nplayer = length(unique(id))) 
# 	
# 	summarize(group_by(baseball, team, year),
# 	          nplayer = n())
# 	
# 
# 	ggplot(data = 	summarize(group_by(baseball, team, year),
# 	                         nplayer = n())) + geom_line(aes(x = year, y = nplayer, group = team, color = team))
# 	
# 
# ### Transforming 
# #-------------------------------------------
# 
# 	## Your turn 1 - wide to long
# 	
# 	# Read in the billboard top 100 music data: 
# 	
# 	billboard <- read.csv("http://heike.github.io/rwrks/03-r-format/data/billboard.csv") 
# 	# Use tidyr to convert this data into a long format.
# 	
# 	library(tidyr)
# 	
# 	billboard %>% group_by(artist, track) %>% 
# 	gather(week, rank, X1:X76) -> bb_long
# 	
# 	# more tidying
# 	
# 	bb_long$week <- as.numeric(sub("X","",bb_long$week))
# 	bb_long <- na.omit(bb_long)
# 	
# 	
# 	# Use ggplot2 to create something like this time series plot:
# 	
# 	ggplot(data = bb_long) + geom_line(aes(x = week, y = rank, 
# 										group = track, color = artist))
# 	
# 	## Your turn 2 - pipes
# 	
# 	# Read in the flights data: 
# 	
# 	flights <- read.csv("http://heike.github.io/rwrks/03-r-format/data/flights.csv") 
# 	
# 	#This dataset contains information on over 300,000 flights that departed from New York City in the year 2013. 
# 	
# 	# Using dplyr and the pipe operator, create a data frame consisting of the average arrival delay (arr_delay) based on the destination airport (dest). Sort this data frame in descending order, so the destination airport with the largest delay is first. 
# 	
# 	flights %>% group_by(dest) %>% 
# 	summarise(avg_delay = mean(na.omit(arr_delay))) %>% 
# 	arrange(desc(avg_delay))
# 	
# 	
# 	# Find out the most used airports for each airline carrier. 
# 	
# 	flights %>% group_by(carrier, origin) %>% 
# 	summarise(count = n()) %>% 
# 	ungroup() %>% group_by(carrier) %>% 
# 	filter(count == max(count)) %>% 
# 	rename(mostused = origin) %>%
# 	mutate(kind = "origin") -> by.origin
# 	 
# 	flights %>% group_by(carrier, dest) %>% 
# 	summarise(count = n()) %>% 
# 	ungroup() %>% group_by(carrier) %>% 
# 	filter(count == max(count)) %>% 
# 	rename(mostused = dest) %>% 
# 	mutate(kind = "dest") -> by.dest
# 	
# 	rbind(by.origin,by.dest) -> mostused 
# 	
# 	mostused %>% group_by(carrier) %>% 
# 	filter(count == max(count)) %>% ungroup() %>%
# 	arrange(desc(count)) 
# 	
# 	## Your turn 3 - lubridate
# 	
# 	# Using the flights data, create a new column Date using lubridate. You will need to paste together the columns year, month, and day in order to do this. See the paste function. 
# 	
# 		library(lubridate)
# 		flights$Date <- as.Date(paste(flights$year, flights$month, flights$day, sep = "-"))
# 		
# 	# Use dplyr to calculate the average departure delay for each date. Plot the date versus the average departure delay
# 	
# 	flights %>% group_by(Date) %>% 
# 	summarise(avg_delay = mean(na.omit(dep_delay))) %>%
# 	ggplot() + geom_line(aes(x = Date, y = avg_delay))