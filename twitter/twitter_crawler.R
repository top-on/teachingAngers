### load packages and database
library(twitteR)
setwd("/home/thor/inf/R")
load("database.dataframe")

### register with twitter
load("twitter_credentials")
registerTwitterOAuth(twitCred)
options(RCurlOptions = list(cainfo = system.file("CurlSSL", 
                                                 "cacert.pem",              
                                                 package = "RCurl")))

### search twitter for 'searchterm' and add to 'database'
search <- function( searchterm, database ) {
  # get search results
  tweets <- list()
  tweets <- searchTwitter(searchterm, n=1500, lang="de")
  tweets <- twListToDF(tweets)
  length(tweets$text)
  
  # filter new tweets
  tweets <- tweets[tweets$id > max(database$id),]
  
  # write new tweets to database
  database <- rbind(tweets, database)
  return(database)
}

### MAIN PROCEDURE

# define search, do search and save database
searchterm <- "#obama"
database <- search(searchterm, database)
save(database,file="database.dataframe")


###################
### Graveyard
###################

## extract 'hashs' from text
# add 'hashs' in twitter messages column of data.frame
# hashs <- vector()
# for ( i in 1:length(tweets$text) ) {
#   list <- unlist (strsplit(tweets$text[i]," "))
#   hashlist <- toString(list[grep("#",list)])
#   hashs <- append(hashs, hashlist)
# }
# tweets <- (cbind(hashs, tweets))

###########################################################
## script with problems (n per day limited)
# tweets <- list()
# dates <- paste("2014-02-",15:22,sep="")
# for (i in 2:length(dates)) {
#   print(paste(dates[i-1], dates[i]))
#   tweets <- c(tweets, searchTwitter(searchterm, since=dates[i-1], 
#                                     until=dates[i], n=1500))
# }
# 
# # Convert the list to a data frame
# tweets <- twListToDF(tweets)
# tweets <- unique(tweets)
# 
# # make sure that there were no more than 1500 tweets per day.
# # If there are 1500 on any single day, 
# # then you're truncating that day's tweets
# tweets$date <- format(tweets$created, format="%Y-%m-%d")
# table(tweets$date)
# 
# # Make a table of the number of tweets per user
# d <- as.data.frame(table(tweets$screenName))
# d <- d[order(d$Freq, decreasing=T), ]
# names(d) <- c("User","Tweets")
# head(d)
# 
# # Plot the table above for the top 40
# png("ismb-users.png", w=700, h=1000)
# par(mar=c(5,10,2,2))
# with(d[rev(1:40), ], barplot(Tweets, names=User, horiz=T, las=1, main="Top 40: Tweets per User", col=1))
# dev.off()
# 
# minutes <- 15
# ggplot(data=tweets, aes(x=created)) + 
#   geom_bar(aes(fill=..count..), binwidth=60*minutes) + 
#   scale_x_datetime("Date") + 
#   scale_y_continuous("Frequency")
# ggsave(file='ismb-frequency.png', width=7, height=7, dpi=100)


### ROAuth test

