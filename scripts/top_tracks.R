# Get data for artists' top 10 tracks
library(httr)

# Source in the code for getting data from spotify (POST)
source("spotify_source_code.R")


# A function that returns a data frame containing information about an artist's
# top 10 tracks
top_tracks_source <- function(artist) {

  # Get data about an artist after searching his/her name
  search_uri <- paste0(
    "https://api.spotify.com/v1/search?q=", artist, "&type=artist"
  )
  response1 <- GET(url = search_uri, add_headers(Authorization = header_value))
  search_artist <- content(response1)

  # Get the top 10 tracks of an artist using his/her Spotify ID
  artist_id <- search_artist[["artists"]][["items"]][[1]][["id"]]
  tracks_uri <- paste0(
    "https://api.spotify.com/v1/artists/", artist_id,
    "/top-tracks?country=US"
  )
  response2 <- GET(url = tracks_uri, add_headers(Authorization = header_value))

  # Get a list of information of the top 10 tracks
  tracks_data <- content(response2)

  # Turn the list of data that contains nested lists into a data frame
  data.frame(t(sapply(tracks_data$tracks, c)))
}


# A function that uses the data frame of the top tracks' data to make a data
# frame (table) that includes the release dates of albums which the tracks
# belong to, albums' names, tracks' names, tracks' number in the albums, and
# tracks' links to Spotify
tracks_data_frame <- function(artist) {

  # Calls the top tracks' source function to get the data
  data <- top_tracks_source(artist)

  # Take the album column of the data frame that contains nested lists and turn
  # it into a data frame
  album_column <- data[, "album"]
  turn_data_frame <- function(list) {
    data.frame(list, stringsAsFactors = FALSE)
  }
  album_data_frame <- do.call("rbind", lapply(album_column, turn_data_frame))

  # Create a data frame
  release_date <- album_data_frame[["release_date"]]
  album_name <- album_data_frame[["name"]]
  track_name <- unlist(data[["name"]])
  track_number <- unlist(data[["track_number"]])
  link <- album_data_frame[["spotify"]]
  data_frame <- data.frame(
    release_date, album_name, track_name, track_number, link
  )
}


# Get top tracks for different artists
ariana_grande_tracks <- tracks_data_frame("grande")
britney_spears_tracks <- tracks_data_frame("spears")
carly_jepsen_tracks <- tracks_data_frame("jepsen")
justin_timberlake_tracks <- tracks_data_frame("timberlake")
katy_perry_tracks <- tracks_data_frame("katy")
lady_gaga_tracks <- tracks_data_frame("lady")
maroon5_tracks <- tracks_data_frame("maroon")
pink_tracks <- tracks_data_frame("pink")
taylor_swift_tracks <- tracks_data_frame("taylor")
the_chainsmokers_tracks <- tracks_data_frame("chainsmokers")

# Combine top tracks of different artists in a data frame
combined_data_frame <- do.call("rbind", list(
  ariana_grande_tracks, britney_spears_tracks,
  carly_jepsen_tracks,
  justin_timberlake_tracks,
  katy_perry_tracks, lady_gaga_tracks,
  maroon5_tracks, pink_tracks,
  taylor_swift_tracks,
  the_chainsmokers_tracks
))
