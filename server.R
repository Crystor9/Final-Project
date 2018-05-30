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
        filter(artist_name == input$artist)
    }
    if (input$year != "ALL") {
      data <- data %>%
        filter(year == input$year)
    }
    return(build_scatter(data))
  })
  
  # Return a table that contains information about artists' top tracks
  output$table <- DT::renderDataTable(DT::datatable({
    data <- combined_data_frame
    
    # Filter data based on choices of artist and release year
    if (input$artist != "ALL") {
      data <- data %>%
        filter(artist_name == input$artist)
    }
    if (input$year != "ALL") {
      data <- data %>%
        filter(year == input$year)
    }
    colnames(data) <- c(
      "Release Year",
      "Release Date",
      "Artist",
      "Track",
      "Album",
      "Track Number",
      "Popularity",
      "Link"
    )
    data$Album <-
      paste0("<a href='", data$Link, "'>", data$Album, "</a>")
    data$Link <- NULL
    data
  }, escape = F, class = "cell-border stripe"))
  
  # Return a pie chart for related artists information
  output$pie <- renderPlotly({
    data <- combined_df
    if (input$related != "All") {
      data <- related_artists(input$related)
    }
    return(build_pie(data))
  })
  
  # Return a table for related artists based on user input
<<<<<<< HEAD
  output$table_2 <- renderTable(related_artists(input$yvar))
=======
  output$table_2 <- renderTable(
    related_artists(input$yvar)
  )
>>>>>>> 1425d46111e2a9db39f87edafee0942965b82d88
})
