## ----setup, include=FALSE, message=FALSE, warning = FALSE----------------
knitr::opts_chunk$set(echo = TRUE)
library(tidyverse)

## ------------------------------------------------------------------------
data(state)

## ------------------------------------------------------------------------
grep(pattern = "ne", state.name)

state.name[7]

grep(pattern = "ne", state.name, value = TRUE)


## ------------------------------------------------------------------------
grep(pattern = "[nN]e", state.name, value = TRUE)


## ------------------------------------------------------------------------
grep(pattern = "s{1,2}", state.name, value = TRUE)

gsub("New", "Old", state.name)


## ------------------------------------------------------------------------
meta <- read.table("http://heike.github.io/rwrks/01-r-intro/data/meta.txt")
head(meta)

## ------------------------------------------------------------------------
meta$day <- gsub('.*D([:digit:]*)','\\1', meta$Group)
head(meta)

## ------------------------------------------------------------------------
meta$pen <- sub('X.P.*N(..).*D.*', '\\1', meta$Group)
meta$experiment <- sub('(X.)P[:digit:]*.*', '\\1', meta$Group)
meta$tissue <- sub('X.P.*N..(.*)D.*', '\\1', meta$Group)
head(meta)

