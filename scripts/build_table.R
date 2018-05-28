library(plotly)
library(stringr)
library(ggplot2)
library(dplyr)

source("scripts/top_tracks.R")
data <- top_tracks("taylor")
p <- plot_ly(
  type = 'table',  # Specify type of plot as table
  
  # header is a list and every parameter shown below needs 
  # to be specified. Note that html tags can be used as well
  
  header = list(
    
    # First specify table headers
    # Note the enclosure within 'list'
    
    values = list(list('<b>RELEASE DATE</b>'),
                  list('<b>ALBUM</b>'),
                  list('<b>TRACK</b>'), 
                  list('<b>TRACK NUMBER</b>'), 
                  list('<b>POPULARITY</b>')),
    
    # Formatting 
    line = list(color = '#DFE8F3'),
    align = c('left','left','left','left','left'),
    font = list(color = c('#506784', '#506784', '#506784', '#506784', '#ab63fa'), size = 14)
  ),
  
  # Specify individual cells
  
  cells = list(
    
    # Now specify each cell content
    
    values = list(
      c('Salaries', 'Office', 'Merchandise', 'Legal', '<b>TOTAL</b>'),
      c(1200000, 20000, 80000, 2000, 12120000),
      c(1300000, 20000, 70000, 2000, 130902000),
      c(1300000, 20000, 120000, 2000, 131222000),
      c(1400000, 20000, 90000, 2000, 14102000)),
    
    # Formatting
    line = list(color = '#DFE8F3'),
    align = c('left', 'left', 'left', 'left', 'left'),
    font = list(color = c('#506784', '#506784', '#506784', '#506784', '#ab63fa'), size = 14),
    height = 48
  )) %>% 
  
  # Layout is needed to remove gridlines, axis zero lines and ticktext 
  # or else they will also show up
  
  layout(xaxis = list(zeroline = F, showgrid = F, showticklabels = F, domain = c(0, 0.5)),
         yaxis = list(zeroline = F, showgrid = F, showticklabels = F))


p