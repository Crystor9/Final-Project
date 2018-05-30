# Get's data for related artists to the artist being passed.
library(httr)
library(plyr)

# Sources spotify API using POST.
source("scripts/spotify_source_code.R")

related_artists <- function(artist) {

  # Create a data frame displaying 10 related artists based on the artist name
  # passed as a parameter
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
  df <- data.frame(
    artist_names, artist_type, num_followers_df,
    artist_popularity, link_data_frame
  )
  colnames(df) <- c("Name", "Type", "Followers", "Popularity %", "Spotify Link")
  df <- head(df, 10)
}

# Top artists
artist_names <- c(
  "grande", "spears", "jepsen", "timberlake", "katy", "lady",
  "maroon", "pink", "taylor", "chainsmokers"
)

# Create data frame of artists related to the top ones.
combined_df <- lapply(artist_names, related_artists)

combined_df <- do.call("rbind", combined_df)

column_names <- c("Name", "Type", "Num_Followers", "Popularity", "Link")
colnames(combined_df) <- column_names
