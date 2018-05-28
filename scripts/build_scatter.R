library(plotly)
library(stringr)
library(ggplot2)
library(dplyr)

source("scripts/top_tracks.R")

build_popularity_scatter <- function(data, year) {
  ymax <- max(data[, "popularity"]) * 1.2
  
  data <- data %>%
    filter(grepl(artist, list(
      "Ariana Grande", "Britney Spears", "Carly Jepsen",
      "Justin Timberlake", "Katy Perry", "Lady Gaga",
      "Maroon 5", "Pink", "Taylor Swift",
      "The Chainsmokers"
    ))) %>%
    filter(subset(format.Date(released_date, "%Y")<=year))
  
  plot_ly(combined_data_frame,
          x = c(1999:2018), y = ~ popularity, type = "scatter",
          name = "Popularity"
  ) %>%
    layout(
      title = "Popularity of Artists' Top 10 tracks",
      xaxis = (title = "Top 10 Tracks"),
      yaxis = (title = "Popularity"),
      margin = list(b = 100)
    ) %>%
    return()
}