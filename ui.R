library(shiny)
library(plotly)

library(ggplot2)

source("scripts/top_tracks.R")

artists <- combined_data_frame$artist_name %>%
  unique()
year <- combined_data_frame$year %>%
  unique()

shinyUI(navbarPage(
  "Information about Artists on Spotify",
  
  # Create a tab panel for a below poverty line-population scatter plot
  tabPanel(
    "Top Tracks",
    titlePanel("Top 10 Tracks of Artists"),
    
    # Create sidebar layout
    sidebarLayout(
      # Side panel for controls
      sidebarPanel(
        # Input to select variable to scatter plot
        selectInput(
          "artist",
          label = "Select an Artist",
          choices = c("ALL", as.character(artists))
        ),
        
        # Input to enter variable to scatter plot
        selectInput(
          "year",
          label = "Select a year",
          choices = c("ALL", as.character(year))
        )
      ),
      
      # Display plotly scatter plot
      mainPanel(tabsetPanel(type = "tabs",
                            tabPanel(
                              "Scatter", plotOutput("scatter")
                            )))
    )
  )
))
