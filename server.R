library(shiny)
library(httr)

source("scripts/top_tracks.R")

# Start shinyServer
shinyServer(function(input, output) {
  
  # Return a scatter plot
  output$plot <- renderPlotly({
    return(build_popularity_scatter(combined_data_frame, input$artist, input$year_range))
  })
})