

## Status Message
status_details <- paste0(
  "Hello World")

# Publish to Twitter
library(rtweet)

## Create Twitter token
kambing_token <- rtweet::create_token(
  app = "kambingBot",
  consumer_key =    Sys.getenv("KBOT_TWITTER_CONSUMER_API_KEY"),
  consumer_secret = Sys.getenv("KBOT_TWITTER_CONSUMER_API_SECRET"),
  access_token =    Sys.getenv("KBOT_TWITTER_ACCESS_TOKEN"),
  access_secret =   Sys.getenv("KBOT_TWITTER_ACCESS_TOKEN_SECRET")
)

## Post the image to Twitter
rtweet::post_tweet(
  status = status_details,
  token = kambing_token
)

#on.exit(dbDisconnect(con))
