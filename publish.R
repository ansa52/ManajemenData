#load library
library(RPostgreSQL)

drv <- dbDriver("PostgreSQL")

con <- dbConnect(drv,
                 dbname = Sys.getenv("KBOT_ELEPHANT_SQL_DBNAME"), 
                 host = Sys.getenv("KBOT_ELEPHANT_SQL_HOST"),
                 port = 5432,
                 user = Sys.getenv("KBOT_ELEPHANT_SQL_USER"),
                 password = Sys.getenv("KBOT_ELEPHANT_SQL_PASSWORD")
)

query <- 'SELECT * FROM "public"."players"'

data <- dbGetQuery(con, query)

## Status Message
status_details <- paste0(
  Sys.Date(), "\n",
  "Nama Pemain: ", data$firstname[1], " ", "Negara: ",data$country[1], "\n",
  "Nama Pemain: ", data$firstname[2], " ", "Negara: ",data$country[2], "\n"
)

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

on.exit(dbDisconnect(con))
