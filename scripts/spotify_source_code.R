# To be used for getting data from Spotify
client_id <- "3c028b5aa14a473883a00adc41bd0775"
secret <- "51c09cb485754a4db045b95d6fcfff18"

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