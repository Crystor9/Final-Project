library(dplyr)
library(ggplot2)
library(plotly)
library(rsconnect)
library(shiny)
library(httr)

source("scripts/top_tracks.R")

# Start shinyServer
shinyServer(function(input, output) {
  output$table <- renderTable({
    data <- top_tracks(input$artists)
    return(build_table(data))
  })

  # Return a scatter plot
  output$plot <- renderPlotly({
    return(build_popularity_scatter(combined_data_frame, input$artist, input$year_range))
  })
})