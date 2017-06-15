## Your Turn 1

# Navigate [this page](http://www.wunderground.com/history/airport/KVAY/2015/2/17/DailyHistory.html?req_city=Cherry+Hill&req_state=NJ&req_statename=New+Jersey&reqdb.zip=08002&reqdb.magic=1&reqdb.wmo=99999&MR=1) and try the following:
# 1. Grab the table at the bottom of the page (hint: instead of grabbing a node by class with `html_node(".class")`, you can grab by id with `html_node("#id")`)

# url <- "http://www.wunderground.com/history/airport/KVAY/2015/2/17/DailyHistory.html?req_city=Cherry+Hill&req_state=NJ&req_statename=New+Jersey&reqdb.zip=08002&reqdb.magic=1&reqdb.wmo=99999&MR=1"

library(rvest)
library(magrittr)
# read_html(url) %>% html_children() %>% 
#   html_node(".large-12") %>% extract2(2) %>% html_nodes("table") %>%
# html_table()
# 
#  # 2. From the table at the top, grab the actual mean, max, and min temperature.
# temps <- read_html(url) %>% html_children() %>% html_nodes("table") %>% extract2(1) %>% html_table() 
# temps[2:4,1:2]
# 
#  # 3. (Optional) Grab the weather history graph and write the figure to disk (`download.file()` may be helpful here). 
# 
# imgsrc <- (read_html(url) %>% html_children() %>% html_nodes("img") %>% html_attr("src"))[1]
# 
# download.file(paste0("https://www.wunderground.com", imgsrc), "weathershistory.jpeg")
# 
#  # [See here](https://gist.github.com/cpsievert/57be009120bb5298affa)
# 
# ## Your Turn 2
# 
# # Nativigate to Wikipedia's [list of data structures](http://en.wikipedia.org/wiki/List_of_data_structures) use SelectorGadget + rvest to do the following:
# 
# # 1. Obtain a list of Primitive types
# 
# url <- "http://en.wikipedia.org/wiki/List_of_data_structures"
# read_html(url) %>% html_nodes("ul:nth-child(7) a") %>% html_text()
# 
# # 2. Obtain a list of the different Array types
# 
# read_html(url) %>% html_nodes("ul:nth-child(19) a") %>% html_text()
# 
# # [See here](https://gist.github.com/cpsievert/c1b851ff5e1bd846de46)

## Your Turn JSON 

# 1. Get the json data for our R workshop GitHub commit history:
  
workshop_commits_raw <- fromJSON("https://api.github.com/repos/heike/rwrks/commits")

# 2. Find the table of commits contained in this list

commits <- workshop_commits_raw$commit$committer

# 3. Plot the total number of commits (number of rows) by user as a bar chart

library(ggplot2)
qplot(commits$name)
