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
  # Return the pie chart
  output$pie <- renderPlotly({
    if (input$related != "All") {
      data <- related_artists(input$related)
    } else {
      data <- combined_df
    }
    return(build_pie(data, input$related))
  })
  
  output$table_2 <- renderTable(related_artists(input$yvar))
})