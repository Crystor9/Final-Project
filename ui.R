library(shiny)
library(plotly)

library(ggplot2)


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
        selectInput("artist",
          label = "Select an Artist",
          choices = list(
            "Top 10" = "all",
            "Ariana Grande" = "ariana",
            "Britney Spears" = "spears",
            "Carly Jepsen" = "jepsen",
            "Justin Timberlake" = "timberlake",
            "Katy Perry" = "perry",
            "Lady Gaga" = "gaga",
            "Maroon 5" = "maroon 5",
            "Pink" = "pink",
            "Taylor Swift" = "swift",
            "The Chainsmokers" = "chainsmokers"
          )
        ),

        # Input to enter variable to scatter plot
        dateRangeInput("date", strong("Date range"), 
                       start = "2007-01-01", end = "2017-07-31",
                       min = "2007-01-01", max = "2017-07-31")
      ),

      # Display plotly scatter plot
      mainPanel(
        tabsetPanel(
          type = "tabs",
          tabPanel("Plot", plotOutput("date")),
          tabPanel("Table", tableOutput("table"))
        )
      )
    )
  )
))
