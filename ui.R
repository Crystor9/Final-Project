library(shiny)
library(plotly)

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
        sliderInput("year_range",
                    label = "Select a Year Range",
                    min = 1999, max = 2018, value = 2008)
      ),

      # Display plotly scatter plot
      mainPanel(
        tabsetPanel(
          type = "tabs",
          tabPanel("Plot", plotOutput("plot")),
          tabPanel("Table", tableOutput("table"))
        )
      )
    )
  )
))
