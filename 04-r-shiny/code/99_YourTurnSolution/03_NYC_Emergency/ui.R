library(shiny)
library(tidyverse)

nyc <- read.csv("nyc_emergency.csv", stringsAsFactors = FALSE)
new_nyc <- nyc %>% separate(Creation.Date, into = c("Creation.Date", "Creation.Time"), sep="  ") %>% 
  separate(Creation.Date, into = c("Creation.Month", "Creation.Day", "Creation.Year")) %>% 
  mutate(Creation.Month = parse_number(Creation.Month),
         Creation.Day = parse_number(Creation.Day),
         Creation.Year = parse_number(Creation.Year))


shinyUI(fluidPage(

    titlePanel("NYC Crime Data"),

	sidebarPanel(
	    selectInput("incident_type", "Incident Type", choices = sort(unique(nyc$Incident.Type)), selected = "Fire-3rd Alarm"),
	    checkboxGroupInput("years", label = h3("Select Years"), 
	                       choices = list("2013" = 2013, "2014" = 2014, "2015" = 2015),
	                       selected = 2015)
	),

	mainPanel(
	  tabsetPanel(
	    tabPanel("Barchart", plotOutput("crime")),
	    tabPanel("Scatterplot of Locations", plotOutput("location"))
	  )
	)
))
