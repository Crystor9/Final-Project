# File that returns a pie chart displaying followers of the related artists
library(dplyr)
library(plotly)

source("scripts/related_artists.R")

# Function for making a pie chart based on selection
build_pie <- function(data, xvar) {
  plot_ly(data, labels = ~ data[, 1], values = ~ data[, 3], type = "pie") %>%
    layout(
      title = "Followers of Related Artists",
      xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
      yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE)
    ) %>%
    return()
}
