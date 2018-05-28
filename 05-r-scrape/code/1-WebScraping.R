## ----echo=FALSE, out.width='33%', fig.show='hold', fig.align='default'----
knitr::include_graphics(c('./images/gdpss.png','./images/cropsss.png','./images/gass.png'), auto_pdf = FALSE)

## ----echo=FALSE, out.width='50%'-----------------------------------------
knitr::include_graphics("./images/copypastesucks.png", auto_pdf = FALSE)

## ---- warning=FALSE, message=FALSE, eval=FALSE---------------------------
## library(rvest)
## src <- read_html("http://en.wikipedia.org/wiki/Table_(information)")
## node <- html_node(src, css = ".wikitable")

## ----eval=FALSE----------------------------------------------------------
## html_table(node, fill = TRUE)

## ----eval=FALSE----------------------------------------------------------
## read_html("http://en.wikipedia.org/wiki/Table_(information)") %>%
##   html_node(".wikitable") %>% html_table(fill=TRUE)

## ----eval=FALSE----------------------------------------------------------
## domain <- "http://www.sec.gov"
## susp <- paste0(domain, "/litigation/suspensions.shtml")
## hrefs <- read_html(susp) %>% html_nodes("p+ table a") %>% html_attr(name = "href")
## tail(hrefs)

## ---- eval=FALSE---------------------------------------------------------
## hrefs <- hrefs[!is.na(hrefs)]
## pdfs <- paste0(domain, hrefs)[1:10]
## 
## for (i in 1:length(pdfs)) {
##     download.file(url = pdfs[i], destfile = basename(pdfs[i]))
## }

## ----url-----------------------------------------------------------------
# character variable containing the url you want to scrape
myurl <- "http://www.imdb.com/title/tt4975722/"

## ----gethtml, message = FALSE--------------------------------------------
library(tidyverse)
library(rvest)
myhtml <- read_html(myurl)
myhtml
# .summary_text
## ----getdesc-------------------------------------------------------------
myhtml %>% html_nodes(".summary_text") %>% html_text()

## ----gettable------------------------------------------------------------
myhtml %>% html_nodes("table") %>% html_table(header = TRUE)

## ----savetidy, message = FALSE, warning = FALSE--------------------------
install.packages("stringr")
install.packages("magrittr")
library(stringr)
library(magrittr)
mydat <- myhtml %>% 
  html_nodes("table") %>%
  extract2(1) %>% 
  html_table(header = TRUE)
mydat <- mydat[,c(2,4)]
names(mydat) <- c("Actor", "Role")
head(mydat)
mydat <- mydat %>% 
  mutate(Actor = Actor,
         Role = str_replace_all(Role, "\n  ", ""))
mydat

## ----yourturn1-----------------------------------------------------------
library(rvest)
library(magrittr)
myurl <- "https://en.wikipedia.org/wiki/List_of_countries_by_GDP_(PPP)_per_capita"
myhtml <- read_html(myurl)
myhtml %>% 
 html_nodes("table") %>%
 extract2(2) %>%
 html_table(header = TRUE) %>% 
 mutate(`Int$` = parse_number(`Int$`)) %>% 
 head

## ----nodesex-------------------------------------------------------------
myhtml %>% 
  html_nodes("p") %>% # first get all the paragraphs 
  html_nodes("a") # then get all the links in those paragraphs

## ----textex--------------------------------------------------------------
myhtml %>% 
  html_nodes("p") %>% # first get all the paragraphs 
  html_nodes("a") %>% # then get all the links in those paragraphs
  html_text() # get the linked text only 

## ----tableex-------------------------------------------------------------
myhtml %>% 
  html_nodes("table") %>% # get the tables 
  head(2) # look at first 2

## ----tableex2------------------------------------------------------------
myhtml %>% 
  html_nodes("table") %>% # get the tables 
  extract2(2) %>% # pick the second one to parse
  html_table(header = TRUE) # parse table 

## ----attrsex-------------------------------------------------------------
myhtml %>% 
  html_nodes("table") %>% extract2(2) %>%
  html_attrs()

## ----attrsex2------------------------------------------------------------
myhtml %>% 
  html_nodes("p") %>% html_nodes("a") %>%
  html_attr("href")

## ----childex-------------------------------------------------------------
myhtml %>% 
  html_children() %>% 
  html_children() %>% 
  html_children() %>% 
  html_children()
  html_name()
  
# Jimmy's your turn
  
myurl <- "https://en.wikipedia.org/wiki/Neil_Patrick_Harris"

read_html(myurl) %>% 
  html_nodes("table") %>%
  extract2(6) %>% 
  html_table()

## ----getyears------------------------------------------------------------
url <- "http://avalon.law.yale.edu/subject_menus/inaug.asp"
# even though it's called "all inaugs" some are missing
all_inaugs <- (url %>% 
  read_html() %>% 
  html_nodes("table") %>% 
  html_table(fill=T, header = T)) %>% extract2(3)
# tidy table of addresses
all_inaugs_tidy <- all_inaugs %>% 
  gather(term, year, -President) %>% 
  filter(!is.na(year)) %>% 
  select(-term) %>% 
  arrange(year)
head(all_inaugs_tidy)

## ----getlinks------------------------------------------------------------
# get the links to the addresses 
inaugadds_adds <- (url %>%
  read_html() %>%
  html_nodes("a") %>%
  html_attr("href"))[12:66]
# create the urls to scrape
urlstump <- "http://avalon.law.yale.edu/"
inaugurls <- paste0(urlstump, str_replace(inaugadds_adds, "../", ""))
all_inaugs_tidy$url <- inaugurls
head(all_inaugs_tidy)

inaugurls[1] %>% read_html() %>%
  html_nodes("p") %>% 
  html_text() -> address


## ----functiongetspeech, cache=TRUE, message = FALSE, warning = FALSE-----
get_inaugurations <- function(url){
  test <- try(url %>% read_html(), silent=T)
  if ("try-error" %in% class(test)) {
    return(NA)
  } else
    url %>% read_html() %>%
      html_nodes("p") %>% 
      html_text() -> address
    return(unlist(address))
}

# takes about 30 secs to run
all_inaugs_text <- all_inaugs_tidy %>% 
  mutate(address_text = (map(url, get_inaugurations))) 

all_inaugs_text$address_text[[1]]

## ----missings------------------------------------------------------------
all_inaugs_text$President[is.na(all_inaugs_text$address_text)]
# there are 7 missing at this point: obama's and trump's, plus coolidge, garfield, buchanan, and van buren, which errored in the scraping.
obama09 <- get_inaugurations("http://avalon.law.yale.edu/21st_century/obama.asp")
obama13 <- readLines("speeches/obama2013.txt")
trump17 <- readLines("speeches/trumpinaug.txt")
vanburen1837 <- readLines("speeches/vanburen1837.txt") # row 13
buchanan1857 <- readLines("speeches/buchanan1857.txt") # row 18
garfield1881 <- readLines("speeches/garfield1881.txt") # row 24
coolidge1925 <- readLines("speeches/coolidge1925.txt") # row 35
all_inaugs_text$address_text[c(13,18,24,35)] <- list(vanburen1837,buchanan1857, garfield1881, coolidge1925)

# lets combine them all now
recents <- data.frame(President = c(rep("Barack Obama", 2), 
                                    "Donald Trump"),
                      year = c(2009, 2013, 2017), 
                      url = NA,
                      address_text = NA)

all_inaugs_text <- rbind(all_inaugs_text, recents)
all_inaugs_text$address_text[c(56:58)] <- list(obama09, obama13, trump17)

## ----textanalysis--------------------------------------------------------
# install.packages("tidytext")
library(tidytext)
all_inaugs_text %>% 
  select(-url) %>% 
  unnest() %>% 
  unnest_tokens(word, address_text) -> presidential_words
head(presidential_words)

## ----longestspeech-------------------------------------------------------
presidential_words %>% 
  group_by(President,year) %>% 
  summarize(num_words = n()) %>%
  arrange(desc(num_words)) -> presidential_wordtotals

## ----speechplot, echo = FALSE, fig.align='center', cache = T, fig.height=5, fig.width=9.5----
library(ggrepel)
ggplot(presidential_wordtotals) + 
  geom_bar(aes(x = reorder(year, num_words), y = num_words), stat = "identity", fill = 'white', color = 'black') + 
  geom_label_repel(aes(x = reorder(year, num_words), y = num_words, label = President), size = 2.5) +
  labs(y = "Word count of Speech", x = "Year (sorted by word count)", title = "Length of Presidential Inaugural Addresses", subtitle = "Max: 8,459; Min: 135; Median: 2,090; Mean: 2,341") + 
  theme(axis.text.x = element_text(angle = 45, size = 7), plot.subtitle = element_text(hjust = .5))

## ------------------------------------------------------------------------
library(httr)
sam <- GET("https://api.github.com/users/sctyner")
sam$url
sam$status_code
sam$all_headers
sam$cookies
sam$content
content(sam)[c("name", "company")]

## ------------------------------------------------------------------------
sam$header[1:3]

## ---- echo=FALSE, message = FALSE----------------------------------------
# hopefully no one is watching
# devtools::install_github("cpsievert/XML2R")
library(XML2R)

#obs <- read_xml("https://gist.githubusercontent.com/cpsievert/85e340814cb855a60dc4/raw/651b7626e34751c7485cff2d7ea3ea66413609b8/mariokart.xml")
obs <- XML2Obs("https://gist.githubusercontent.com/cpsievert/85e340814cb855a60dc4/raw/651b7626e34751c7485cff2d7ea3ea66413609b8/mariokart.xml", quiet = TRUE)
data_frame(obs)
table(names(obs))

## ------------------------------------------------------------------------
obs # named list of observations

## ------------------------------------------------------------------------
collapse_obs(obs) # group into table(s) by observational name/unit

## ------------------------------------------------------------------------
library(dplyr)
obs <- add_key(obs, parent = "mariokart//driver", recycle = "name")
collapse_obs(obs)

## ------------------------------------------------------------------------
tabs <- collapse_obs(obs)
left_join(as.data.frame(tabs[[1]]), as.data.frame(tabs[[2]])) 

## ------------------------------------------------------------------------
install.packages("jsonlite")

library(jsonlite)
mario <- fromJSON("http://bit.ly/mario-json")
str(mario) 

## ------------------------------------------------------------------------
mario$driver
mario$vehicles

## ------------------------------------------------------------------------
vehicles <- rbind(mario$vehicles[[1]], mario$vehicles[[2]])
vehicles <- cbind(driver = mario$driver, vehicles)
vehicles
## ------------------------------------------------------------------------
workshop_commits_raw <- fromJSON("https://api.github.com/repos/heike/rwrks/commits")
workshop_commits_raw$commit %>% glimpse()

workshop_commits_raw$commit$author %>% glimpse()

library(ggplot2)

qplot(workshop_commits_raw$commit$author$name, fill = workshop_commits_raw$commit$author$name)


