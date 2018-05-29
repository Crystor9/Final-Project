library(dplyr)
library(plotly)

source("scripts/related_artists.R")




build_pie <- function(data, xvar) {
  
  data <- data %>% 
    filter(grepl(xvar, Name)) 
  
  plot_ly(data, labels = ~Name, values = ~Num_Followers, type = 'pie') %>%
    layout(title = 'followers of related artists',
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE)
           ) %>% 
    return()
}