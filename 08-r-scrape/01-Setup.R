install.packages("rvest")
install.packages("httr")
install.packages("XML2R")

# to use rdom, you'll need phantomjs -> http://phantomjs.org/download.html
# after installing, if this command comes up empty, it's likely a PATH issue...
Sys.which("phantomjs")
# now install rdom via devtools
install.packages("devtools")
devtools::install_github("rdom")

# probably won't need this, but just in case...
install.packages("RSelenium")
