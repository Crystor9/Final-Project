library(plotly)
library(stringr)
library(ggplot2)
library(dplyr)

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
    layout(xaxis = list(title = "", tickangle = -45),
           margin = list(b = 100),
           mode = "scatter")
  p
}

