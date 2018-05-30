library(shiny)
library(plotly)
library(dplyr)
library(ggplot2)
library(DT)
library(shinythemes)
source("scripts/top_tracks.R")
source("scripts/related_artists.R")

# Create UI of the shiny app page, displaying various User input interfaces and
# visualizations according to the given data
artists <- combined_data_frame$Artist %>%
  unique() %>%
  as.character()
year <- combined_data_frame$Release_Year %>%
  unique() %>%
  as.character()

shinyUI(navbarPage(
  theme = shinytheme("sandstone"),
  "Spotify Artists",
  
  # Write a project overview tab
  tabPanel("Overview",
           titlePanel(""),
           mainPanel(includeHTML("project.html"))),
  
  # Create a tab panel for displaying a scatter plot and table of different
  # artists' top 10 tracks
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
        selectInput("year",
                    label = "Select a Track Release Year",
                    choices = c("ALL", year))
      ),
      
      # Display plotly scatter plot
      mainPanel(tabsetPanel(
        type = "tabs",
        tabPanel(
          "Scatter",
          br(),
          p(
            "The",
            strong("scatter plot"),
            "displays popularity of different
            artists' top tracks. Users can choose how the data to be displayed
            based on selection of artist's name and year of tracks released."
          ),
          br(),
          plotlyOutput("scatter")
        ),
        tabPanel(
          "Table",
          br(),
          p(
            "This",
            strong("table"),
            "displays the release date, artist's name,
            track name, album name, track number in the album, poplarity of the
            track and link to the track based on user's selection of artist and
            track's release year."
          ),
          DT::dataTableOutput("table")
        )
      ))
    )
  ),
  
  # Create new tab for related artists.
  tabPanel(
    "Related Artists",
    titlePanel("Related Artists followers"),
    
    # Create a sidebar layout for this tab
    sidebarLayout(sidebarPanel(
      selectInput(
        "related",
        label = "Select an Artist",
        choices = c(
          "All",
          "Ariana Grande" = "grande",
          "Britney Spears" = "spears",
          "Carly Jepsen" = "jepsen",
          "Justin Timberlake" = "timberlake",
          "Katy Perry" = "katy",
          "Lady Gaga" = "lady",
          "Maroon 5" = "maroon",
          "Pink" = "pink",
          "Taylor Swift" = "taylor",
          "The Chainsmokers" = "chainsmokers"
        )
      )
    ),
    
    # Create a main panel to display information regarding related artists
    mainPanel(tabsetPanel(
      # Display Pie chart
      tabPanel(
        "Pie Chart",
        br(),
        p(
          "The",
          strong("Pie Chart"),
          "below displays similar artists
          and music composers based on the top tracks played worldwide. The
          user can then choose a particular artist to display information
          related to them."
        ),
        br(),
        plotlyOutput("pie")
      ),
      
      # Create tabPanel which displays a table for the related artists based
      # on user input
      tabPanel(
        "Search Artists",
        br(),
        p(
          "This table displays",
          strong("Ten Artists"),
          "related to your
          favorite artist"
        ),
        tableOutput("table_2")
      )
    )))
  )
))
