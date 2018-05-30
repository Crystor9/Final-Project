# Get data for artists' top 10 tracks
library(httr)
library(lubridate)

# Source in the code for getting data from spotify (POST)
source("scripts/spotify_source_code.R")

# A function that builds a data frame containing information about the top
# tracks of an artist, including release dates of albums which the tracks belong
# to, the artists' names, tracks' names, albums' names, tracks' number in the
# albums, popularity of the tracks, and the tracks' links to Spotify
top_tracks <- function(full_name) {
  last_name_index <- regexpr(" ", full_name) + 1
  artist_last_name <-
    substr(full_name, last_name_index, nchar(full_name))
  
  # Get data about an artist after searching his/her name
  search_uri <- paste0("https://api.spotify.com/v1/search?q=",
                       artist_last_name,
                       "&type=artist")
  response1 <-
    GET(url = search_uri, add_headers(Authorization = header_value))
  search_artist <- content(response1)
  
  # Get the top 10 tracks of an artist using his/her Spotify ID
  artist_id <- search_artist[["artists"]][["items"]][[1]][["id"]]
  tracks_uri <- paste0("https://api.spotify.com/v1/artists/",
                       artist_id,
                       "/top-tracks?country=US")
  response2 <-
    GET(url = tracks_uri, add_headers(Authorization = header_value))
  
  # # Get a list of data of the top 10 tracks
  tracks_data <- content(response2)
  
  # Turn the list of data that contains nested lists into a data frame
  data <- data.frame(t(sapply(tracks_data$tracks, c)))
  
  # Take the album column of the data frame that contains nested lists and turn
  # it into a data frame
  album_column <- data[, "album"]
  turn_data_frame <- function(list) {
    data.frame(list, stringsAsFactors = FALSE)
  }
  album_data_frame <-
    do.call("rbind", lapply(album_column, turn_data_frame))
  
  # Create a data frame
  artist_name <- full_name
  release_date <- album_data_frame[["release_date"]]
  year <- substr(release_date, 1, 4)
  album_name <- album_data_frame[["name"]]
  track_name <- unlist(data[["name"]])
  track_number <- unlist(data[["track_number"]])
  popularity <- unlist(data[["popularity"]])
  link <- album_data_frame[["spotify"]]
  df <- data.frame(
    year,
    release_date,
    artist_name,
    track_name,
    album_name,
    track_number,
    popularity,
    link
  )
  colnames(df) <-
    c(
      "Release_Year",
      "Release_Date",
      "Artist",
      "Track",
      "Album",
      "Track_Number",
      "Popularity",
      "Link"
    )
  df <- head(df, 10)
}

# Create a list of artists
artist_list <- c(
  "Ariana Grande",
  "Britney Spears",
  "Carly Jepsen",
  "Justin Timberlake",
  "Katy Perry",
  "Lady Gaga",
  "Maroon 5",
  "Pink",
  "Taylor Swift",
  "The Chainsmokers"
)

# Get top tracks of the list of artists
combined_data_frame <- lapply(artist_list, top_tracks)

# Combine top tracks of different artists into a data frame
combined_data_frame <- do.call("rbind", combined_data_frame)
