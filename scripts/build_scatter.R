library(plotly)
library(stringr)
library(ggplot2)
library(dplyr)

source("scripts/top_tracks.R")

build_scatter <- function(data) {
  p <- plot_ly(
    data,
    x = ~ artist_name,
    y = ~ popularity,
    color = ~ release_date,
    type = "scatter",
    text = paste(
      "Track:",
      data$track_name,
      "<br>Album:",
      data$album_name,
      "<br>Time:",
      data$release_date
    )
  ) %>%
    layout(
      title = "Popularity of Artists' Top Tracks",
      xaxis = list(title = "Artists", tickangle = -45),
      yaxis = list(title = "Popularity"),
      margin = list(b = 100),
      mode = "scatter")
  p
}
