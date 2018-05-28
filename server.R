library(dplyr)
library(ggplot2)
library(plotly)
library(rsconnect)
library(shiny)
library(httr)

source("scripts/top_tracks.R")
source("scripts/build_scatter.R")
source("scripts/build_table.R")

# Start shinyServer
shinyServer(function(input, output) {
  output$table <- renderTable({
    if (input$artist == "all") {
      return (build_table(combined_data_frame))
    } else {
      data <- top_tracks(input$artists)
      return(build_table(data))
    }
  })
  
  # Return a scatter plot
  output$plot <- renderPlotly({
    return(build_popularity_scatter(combined_data_frame, input$artist, input$year_range))
  })
})