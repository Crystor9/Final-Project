library(dplyr)
library(ggplot2)
library(plotly)
library(rsconnect)

source("scripts/top_tracks.R")


shinyServer(function(input, output) {
  output$table <- renderTable({
    data <- top_tracks(input$artists)
    return(build_table(data))
  })
})