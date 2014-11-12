# Set up Rstudio  to run knitr

install.packages("knitr", dependencies=TRUE)
install.packages(c("Hmisc", "xtable"))

install.packages("rmarkdown")
# if you can't install rmarkdown, you'll at least want markdown
install.packages("markdown")

library(knitr)
library(Hmisc)
library(xtable)

