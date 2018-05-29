library(dplyr)
library(ggplot2)
library(plotly)
library(rsconnect)
library(shiny)
library(httr)
library(DT)

source("scripts/top_tracks.R")
source("scripts/build_scatter.R")

# Start shinyServer
shinyServer(function(input, output) {

  # Return a scatter plot
  output$scatter <- renderPlotly({
    data <- combined_data_frame
    if (input$artist != "ALL") {
      data <- data %>%
        filter(artist_name == input$artist)
    }
    if (input$year != "ALL") {
      data <- data %>%
        filter(year == input$year)
    }

    return(build_scatter(data))
  })

  output$table <- DT::renderDataTable(DT::datatable({
    data <- combined_data_frame
    if (input$artist != "ALL") {
      data <- data %>%
        filter(artist_name == input$artist)
    }
    if (input$year != "ALL") {
      data <- data %>%
        filter(year == input$year)
    }
    data
  }))
})
