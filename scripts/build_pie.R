library(dplyr)
library(plotly)

source("scripts/related_artists.R")

build_pie <- function(data, xvar) {
  
  #data <- data %>% 
   # filter(grepl(xvar, data[,1])) 
  
  plot_ly(data, labels = ~data[,1], values = ~data[,3], type = 'pie') %>%
    layout(title = 'followers of related artists',
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE)
           ) %>% 
    return()
}