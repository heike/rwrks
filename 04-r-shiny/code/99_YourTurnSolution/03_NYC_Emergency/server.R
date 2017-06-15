library(shiny)
library(tidyverse)

nyc <- read.csv("nyc_emergency.csv")
new_nyc <- nyc %>% separate(Creation.Date, into = c("Creation.Date", "Creation.Time"), sep="  ") %>% 
  separate(Creation.Date, into = c("Creation.Month", "Creation.Day", "Creation.Year")) %>% 
  mutate(Creation.Month = parse_number(Creation.Month),
         Creation.Day = parse_number(Creation.Day),
         Creation.Year = parse_number(Creation.Year))

library(sf)
library(albersusa)
states <- usa_sf("longlat")

shinyServer(function(input, output) {

    nyc_subset <- reactive({
      years <- as.numeric(input$years)
        new_nyc %>%
            filter(Incident.Type == input$incident_type) %>%
            filter(Creation.Year %in% years)
    })

    output$crime <- renderPlot({
        ggplot(data = nyc_subset(), aes(x = Borough, fill = Borough)) +
            geom_bar(stat = "count") +
            theme_bw() +
            ggtitle(paste("Number of", input$incident_type, "Reports by Borough"))
    })

    output$location <- renderPlot({
      ggplot() +
        geom_sf(data = states) + 
        geom_point(data = nyc_subset(), aes(x = Longitude, y = Latitude, colour = Borough)) +
        theme_map() +
        ggtitle("Locations of incidents") + xlim(-74.2, -73.5) + ylim(40.5,41)
    })
})
