library(shiny)
library(plotly)
library(dplyr)
library(ggplot2)
library(DT)
source("scripts/top_tracks.R")

artists <- combined_data_frame$artist_name %>%
  unique() %>%
  as.character()
year <- combined_data_frame$year %>%
  unique() %>%
  as.character()

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
          choices = c("ALL", artists)
        ),
        
        # Input to enter variable to scatter plot
        selectInput(
          "year",
          label = "Select a year",
          choices = c("ALL", year)
        )
      ),
      
      # Display plotly scatter plot
      mainPanel(tabsetPanel(
        type = "tabs",
        tabPanel("Scatter", plotlyOutput("scatter")),
          tabPanel("Table", DT::dataTableOutput("table"))
      ))
    )
  ),
  
  tabPanel(
    "Related Artists",
    titlePanel("Related Artists followers"),
    # Create a sidebar layout for this tab 
    sidebarLayout(sidebarPanel(
          selectInput(
            "xvar",
            label = "Select an artist",
            choices = combined_data_frame$Name
          ) 
    ),
    
    # Create a main panel to display your plot
    mainPanel(
      plotlyOutput("pie")
    )
  )
    )
))
