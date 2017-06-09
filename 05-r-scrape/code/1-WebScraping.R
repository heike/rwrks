## ---- warning=FALSE, message=FALSE---------------------------------------
library(rvest)
src <- read_html("http://en.wikipedia.org/wiki/Table_(information)")
node <- html_node(src, css = ".wikitable")

## ------------------------------------------------------------------------
html_table(node, fill = TRUE)

## ------------------------------------------------------------------------
read_html("http://en.wikipedia.org/wiki/Table_(information)") %>%
  html_node(".wikitable") %>% html_table(fill=TRUE)

## ------------------------------------------------------------------------
domain <- "http://www.sec.gov"
susp <- paste0(domain, "/litigation/suspensions.shtml")
hrefs <- read_html(susp) %>% html_nodes("p+ table a") %>% html_attr(name = "href")
tail(hrefs)

## ---- eval=FALSE---------------------------------------------------------
## hrefs <- hrefs[!is.na(hrefs)]
## pdfs <- paste0(domain, hrefs)[1:10]
## 
## for (i in 1:length(pdfs)) {
##     download.file(url = pdfs[i], destfile = basename(pdfs[i]))
## }

## ------------------------------------------------------------------------
library(httr)
sam <- GET("https://api.github.com/users/sctyner")
content(sam)[c("name", "company")]

## ------------------------------------------------------------------------
sam$header[1:3]

## ---- echo=FALSE---------------------------------------------------------
# hopefully no one is watching
# devtools::install_github("cpsievert/XML2R")
library(XML2R)
obs <- XML2Obs("https://gist.githubusercontent.com/cpsievert/85e340814cb855a60dc4/raw/651b7626e34751c7485cff2d7ea3ea66413609b8/mariokart.xml", quiet = TRUE)
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
library(jsonlite)
mario <- fromJSON("http://bit.ly/mario-json")
str(mario) # nested data.frames?!? 

## ------------------------------------------------------------------------
mario$driver
mario$vehicles

## ------------------------------------------------------------------------
vehicles <- rbind(mario$vehicles[[1]], mario$vehicles[[2]])
vehicles <- cbind(driver = mario$driver, vehicles)

## ------------------------------------------------------------------------
workshop_commits_raw <- fromJSON("https://api.github.com/repos/heike/rwrks/commits")

