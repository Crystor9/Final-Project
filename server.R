library(dplyr)
library(ggplot2)
library(plotly)
library(rsconnect)
library(shiny)
library(httr)
library(DT)

source("scripts/top_tracks.R")
source("scripts/related_artists.R")
source("scripts/build_scatter.R")
source("scripts/build_pie.R")

# Start shinyServer
shinyServer(function(input, output) {
  # Return a scatter plot for popularity of artists' top tracks
  output$scatter <- renderPlotly({
    data <- combined_data_frame
    
    # Filter data based on choices of artist and release year
    if (input$artist != "ALL") {
      data <- data %>%
        filter(Artist == input$artist)
    }
    if (input$year != "ALL") {
      data <- data %>%
        filter(Release_Year == input$year)
    }
    return(build_scatter(data))
  })
  
  # Return a table that contains information about artists' top tracks
  output$table <- DT::renderDataTable(DT::datatable({
    data <- combined_data_frame
    
    # Filter data based on choices of artist and release year
    if (input$artist != "ALL") {
      data <- data %>%
        filter(Artist == input$artist)
    }
    if (input$year != "ALL") {
      data <- data %>%
        filter(Release_Year == input$year)
    }
    data
  }))
  
  # Return a pie chart for related artists information
  output$pie <- renderPlotly({
    data <- combined_df
    if (input$related != "All") {
      data <- related_artists(input$related)
    }
    return(build_pie(data))
  })
  
  # Return a table for related artists based on user input
  output$table_2 <- renderTable({
    data <- combined_df
    if (input$related != "All") {
      data <- related_artists(input$related)
    }
    data
  })
})
