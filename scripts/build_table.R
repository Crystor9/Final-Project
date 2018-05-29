library(plotly)
library(stringr)
library(ggplot2)
library(dplyr)

source("scripts/top_tracks.R")
combined_data_frame$track_name <- paste0("<a href=\"", combined_data_frame$link, "\"", combined_data_frame$track_name, "</a>")
