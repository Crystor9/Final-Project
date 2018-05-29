# Get's data for related artists to the artist being passed.
library(httr)
library(plyr)

# Sources spotify API using POST.
source("scripts/spotify_source_code.R")

related_artists <- function(artist) { 
  # Get data about an artist using search library.
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
  
  # Get's the names of the related artists
  names <- data[["name"]]
  artist_names <- ldply(names, data.frame)
  
  # Get's the link to the related artist's
  link_column <- data[, "external_urls"]
  turn_data_frame <- function(list) {
    data.frame(list, stringsAsFactors = FALSE)
  }
  link_data_frame <- do.call("rbind", lapply(link_column, turn_data_frame))
  
  # Get's the aggregate popularity of the artist 
  popularity <- data[["popularity"]]
  artist_popularity <- ldply(popularity, data.frame)

  # Get's the number of followers of the particular artists
  followers <- data[, "followers"]
  num_followers <- lapply(followers, `[[`, 2)
  num_followers_df <- ldply(num_followers, data.frame)
  
  # Display's the type of artist
  artist_type <- data["type"]
  
  # Creates and returns a new data frame.
  df <- data.frame("Name" = artist_names, "Type" = artist_type, "Num_Followers" = num_followers_df, 
                   "Popularity" = artist_popularity, "Link" = link_data_frame)
  df <- head(df, 10)
}


# Get's the related artist based on name passed as parameter. 

get_related_artists <- function(artist_name) {
  return(related_artists(artist_name))
}

artist_names <- c("grande", "spears", "jepsen", "timberlake", "katy", "lady",
                  "maroon", "pink",  "taylor", "chainsmokers")

combined_df <- lapply(artist_names, get_related_artists)

combined_df <- do.call("rbind", combined_df)

column_names <- c("Name", "Type", "Num_Followers", "Popularity", "Link")
colnames(combined_df) <- column_names

