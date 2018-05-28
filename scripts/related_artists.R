# Get data for related artists. 
library(httr)

# Source in the code for getting data from spotify (POST)
source("spotify_source_code.R")

related_artists <- function(artist) { 
  # Get data about an artist after searching his/her name
  search_uri <- paste0(
    "https://api.spotify.com/v1/search?q=", artist,
    "&type=artist"
  )
  response1 <- GET(url = search_uri, add_headers(Authorization = header_value))
  search_artist <- content(response1)
  
  artist_id <- search_artist[["artists"]][["items"]][[1]][["id"]]
  tracks_uri <- paste0(
    "https://api.spotify.com/v1/artists/", artist_id,
    "/related-artists?country=US"
  )
  response2 <- GET(url = tracks_uri, add_headers(Authorization = header_value))
  
  related_artist_list <- content(response2)
  data <- data.frame(t(sapply(related_artist_list$artists, c)))
}

