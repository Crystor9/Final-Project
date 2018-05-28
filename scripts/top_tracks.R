# Get data for artists' top 10 tracks
library(httr)
library(lubridate)


# Source in the code for getting data from spotify (POST)
source("scripts/spotify_source_code.R")


# Create a data frame that contains information about the top tracks of an
# artist,including release dates of albums which the tracks belong to, the
# albums' names, the tracks' names, the tracks' number in the albums, popularity
# of the tracks, and the tracks' links to Spotify
top_tracks <- function(artist_last_name, full_name) {

  # Get data about an artist after searching his/her name
  search_uri <- paste0(
    "https://api.spotify.com/v1/search?q=", artist_last_name,
    "&type=artist"
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
  album_data_frame <- do.call("rbind", lapply(album_column, turn_data_frame))
  
  # Create a data frame
  release_date <- album_data_frame[["release_date"]]
  album_name <- album_data_frame[["name"]]
  track_name <- unlist(data[["name"]])
  track_number <- unlist(data[["track_number"]])
  popularity <- unlist(data[["popularity"]])
  link <- album_data_frame[["spotify"]]
  artist_name <- full_name
  data_frame <- data.frame(
    release_date, album_name, track_name, track_number, popularity, link, artist_name
  )
}

# Get top tracks for different artists
ariana_grande_tracks <- top_tracks("grande", "Ariana Grande")
britney_spears_tracks <- top_tracks("spears", "Britney Spears")
carly_jepsen_tracks <- top_tracks("jepsen", "Carly Jepsen")
justin_timberlake_tracks <- top_tracks("timberlake", "Justin Timberlake")
katy_perry_tracks <- top_tracks("katy", "Katy Perry")
lady_gaga_tracks <- top_tracks("lady", "Lady Gaga")
maroon5_tracks <- top_tracks("maroon", "Maroon 5")
pink_tracks <- top_tracks("pink", "Pink")
taylor_swift_tracks <- top_tracks("taylor", "Taylor Swift")
the_chainsmokers_tracks <- top_tracks("chainsmokers", "The Chainsmokers")

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



