library(DT)
library(dplyr)

build_table <- function(data) {
  data$album_name <-
    paste0(
      "<a href=\"",
      combined_data_frame$link,
      "\">",
      combined_data_frame$album_name,
      "</a>"
    )
  data$link <- NULL
  p <- datatable(
      data,
      colnames = c(
        "Year",
        "Release Date",
        "Artist",
        "Track",
        "Album",
        "Track Number",
        "Popularity"
      )
    )
  p
}