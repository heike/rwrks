library(rvest)
src <- read_html("http://en.wikipedia.org/wiki/Table_(information)")
node <- html_node(src, css = ".wikitable")

html_table(node)

read_html("http://en.wikipedia.org/wiki/Table_(information)") %>%
  html_node(".wikitable") %>% html_table()

domain <- "http://www.sec.gov"
susp <- paste0(domain, "/litigation/suspensions.shtml")
hrefs <- read_html(susp) %>% html_nodes("p+ table a") %>% html_attr(name = "href")
tail(hrefs)

# returns the HTML page source, which is _static_ (no table!)
rvest::html("http://bl.ocks.org/cpsievert/raw/2a9fb8f504cd56e9e8e3/")

library(httr)
hadley <- GET("https://api.github.com/users/hadley")
content(hadley)[c("name", "company")]

hadley <- httr::GET("https://api.github.com/users/hadley")
hadley$header[1:3]

library(XML2R)
obs <- XML2Obs("http://bit.ly/mario-xml", quiet = TRUE)
table(names(obs))

obs # named list of observations

collapse_obs(obs) # group into table(s) by observational name/unit

obs <- add_key(obs, parent = "mariokart//driver", recycle = "name")
collapse_obs(obs)

tabs <- collapse_obs(obs)
merge(tabs[[1]], tabs[[2]], by = "name")

library(jsonlite)
mario <- fromJSON("http://bit.ly/mario-json")
str(mario) # nested data.frames?!? 

mario$driver
mario$vehicles

# this mapply statement is essentially equivalent to add_key
vehicles <- mapply(function(x, y) cbind(x, driver = y), 
                   mario$vehicles, mario$driver, SIMPLIFY = FALSE)
Reduce(rbind, vehicles)
mario[!grepl("vehicle", names(mario))]
