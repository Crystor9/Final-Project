library(shiny)
library(plotly)
library(ggplot2)


shinyUI(navbarPage(
  headerPanel("Spotify API"),
  tabPanel(
    titlePanel("Top Tracks of Top Ten Artists"),
    
    sidebarLayout(sidebarPanel(
      selectInput("artists", label = "Select An Artist", choices = list("Taylor Swift" = "taylor",
                                                                        "Ariana Grande" = "grande",
                                                                        "Britney Spears" = "spears",
                                                                        "Carly Jepsen" = "jepsen", 
                                                                        "Justin Timberlake" = "timberlake",
                                                                        "Katy Perry" = "katy",
                                                                        "Lady Gaga"  = "lady",
                                                                        "Maroon5" = "maroon",
                                                                        "Pink" = "pink",
                                                                        "The Chainsmokers" = "chainsmokers")),
      column(10, tableOutput('table'))
    ),
    mainPanel(plotlyOutput("table"))
    )
  )
))