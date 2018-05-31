# To be used for getting data from Spotify
source("api.R")

# Create a source for getting data from Spotify (POST)
response <- POST(
  "https://accounts.spotify.com/api/token",
  accept_json(),
  authenticate(client_id, secret),
  body = list(grant_type = "client_credentials"),
  encode = "form",
  verbose()
)
response
my_token <- content(response)$access_token
header_value <- paste0("Bearer ", my_token)