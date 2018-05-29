# Get's data for related artists to the artist being passed.
library(httr)
library(plyr)

# Sources spotify API using POST.
source("spotify_source_code.R")

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
  df <- head(df, 5)
}

ariana_grande_related_artists <- related_artists("grande")
britney_spears_related_artists <- related_artists("spears")
carly_jepsen_related_artists <- related_artists("jepsen")
justin_timberlake_related_artists <- related_artists("timberlake")
katy_perry_related_artists<- related_artists("katy")
lady_gaga_related_artists <- related_artists("lady")
maroon5_related_artists <- related_artists("maroon")
pink_related_artists <- related_artists("pink")
taylor_swift_related_artists <- related_artists("taylor")
the_chainsmokers_related_artists <- related_artists("chainsmokers")

combined_data_frame <- do.call("rbind", list(
  ariana_grande_related_artists, britney_spears_related_artists,
  carly_jepsen_related_artists,
  justin_timberlake_related_artists,
  katy_perry_related_artists, lady_gaga_related_artists,
  maroon5_related_artists, pink_related_artists,
  taylor_swift_related_artists,
  the_chainsmokers_related_artists
))

column_names <- c("Name", "Type", "Num_Followers", "Popularity", "Link")
colnames(combined_data_frame) <- column_names

