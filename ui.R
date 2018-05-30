library(shiny)
library(plotly)
library(dplyr)
library(ggplot2)
library(DT)
library(shinythemes)
source("scripts/top_tracks.R")
source("scripts/related_artists.R")

# Create UI of the shiny app page, displaying various User input interfaces and visualizations according
# to the given data 
artists <- combined_data_frame$artist_name %>%
  unique() %>%
  as.character()
year <- combined_data_frame$year %>%
  unique() %>%
  as.character()

shinyUI(navbarPage(
  theme = shinytheme("sandstone"),
  "Spotify Artists",

  # Write a project overview tab
  tabPanel(
    "Overview",
    titlePanel(""),
    mainPanel(
      includeHTML("project.html")
    )
  ),

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

        # Input to select variable to scatter plot
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

  # Create new tab for related artists. 
  tabPanel(
    "Related Artists",
    titlePanel("Related Artists followers"),
    # Create a sidebar layout for this tab
    sidebarLayout(
      sidebarPanel(
        selectInput(
          "related",
          label = "Select an artist",
          choices = c("All",
            "Ariana Grande" = "grande",
            "Britney Spears" = "spears", "Carly Jepsen" = "jepsen",
            "Justin Timberlake" = "timberlake", "Katy Perry" = "katy",
            "Lady Gaga" = "lady", "Maroon 5" = "maroon",
            "Pink" = "pink", "Taylor Swift" = "taylor",
            "The Chainsmokers" = "chainsmokers"
          )
        ),
        
        textInput(
          "yvar",
          label = "Type artist's first name for related artists (For Table)",
          value = "Taylor"
        )
      ),

      # Create a main panel to display information regarding related artists
      mainPanel(tabsetPanel(
        
        # Display Pie chart
        tabPanel(
          "Pie Chart",
          br(),
          p("The", strong("Pie Chart"), "below displays similar artists 
                          and music composers based on the top tracks played worldwide. The user can
                          then choose a particular artist to display information related to them."),
          br(),
          plotlyOutput("pie")
          ),
         
        # Create tabPanel which displays a table for the related artists based on user input       
        tabPanel(
          "Search Artists", 
          br(),
          p("This table Displays", strong("Ten Artists"), "Related to your favourite artist"),
          tableOutput("table_2")),
          br()
        )
      )
    )
  )
))