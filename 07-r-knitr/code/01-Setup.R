# Install rmarkdown (should also install knitr)
install.packages("rmarkdown", dependencies = TRUE)
install.packages("pander", dependencies = TRUE)
library(rmarkdown)
library(pander)

# you'll want to use RStudio...
stopifnot(Sys.getenv("RSTUDIO") == "1")

# ----------------------------------------------------------------------------
# Optional
# ----------------------------------------------------------------------------

install_pkg <- function(x) {
  if (!requireNamespace(x)) install.packages(x)
}
install_pkg("animation")
install_pkg("DT")
install_pkg("devtools")
devtools::install_github("rstudio/rticles")
devtools::install_github("ropensci/plotly@carson-dsl")
