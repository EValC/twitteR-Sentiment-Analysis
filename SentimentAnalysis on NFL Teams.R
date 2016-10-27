#Twitter Sentiment Analysis on NFL Teams
install.packages("twitteR","ROAuth","streamR","ggplot2","stringR","tm","RCurl","maps","Rfacebook","devtools","wordcloud")
library(twitteR)
library(ROAuth)
library(streamR)
library(stringR)
library(ggplot2)
library(tm)
library(RCurl)
requestURL <- "https://api.twitter.com/oauth/request_token"
accessURL <- "https://api.twitter.com/oauth/access_token"
authURL <- "https://api.twitter.com/oauth/authorize"
consumerKey <- "C97VucQqe3HcfS3v14bNguv60"
consumerSecret <- "6GTBqOEGZdPfMerMf0Dq35qZBrhQhgMO9cGBuywFzD9VXRH7XJ"
my_oauth <- OAuthFactory$new(consumerKey=consumerKey, consumerSecret=consumerSecret, requestURL=requestURL, accessURL=accessURL, authURL=authURL)
my_oauth$handshake(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"))
save(my_oauth, file="twitter authentication.Rdata")
accessToken= '570658467-UH9q200QT08WkV9tayfvlS64QQ5euE9JETChNf40'
accessSecret= 'hRqyuexn2lD2DFuCuuI6kdtJPGiDVqYOzPvQb5q9Qeh64'
setup_twitter_oauth(consumer_key=consumerKey, consumer_secret=consumerSecret,access_token=accessToken, access_secret=accessSecretssSecret)
library(twitteR)
library(ROAuth)
library(streamR)
library(stringR)
library(ggplot2)
library(tm)
library(wordcloud)
library(RColorBrewer)
#Scraping twitter Data in to a file
filterStream( file.name="team.json", track="MLB", tweets=1000, oauth=my_oauth)
#searchTwitter - This function will issue a search of Twitter based on a supplied search string.
broncos.tweets <- searchTwitter('#broncos', n=2000, lang="en")
cardinals.tweets <- searchTwitter('#cardinals', n=2000, lang="en")
falcons.tweets <- searchTwitter('#falcons', n=2000, lang="en")
steelers.tweets<-searchTwitter('#steelers',n=2000,lang="en")
patriots.tweets <- searchTwitter('#patriots', n=2000, lang="en")
#output text (laply [plyr] : For each element of a list, apply function then combine results into an array.)
broncos.text = laply(broncos.tweets, function(t) t$getText())
cardinals.text = laply(cardinals.tweets, function(t) t$getText())
falcons.text = laply(falcons.tweets, function(t) t$getText())
steelers.text = laply(steelers.tweets, function(t) t$getText())
patriots.text = laply(patriots.tweets, function(t) t$getText())
#Striping out funny characters and emoticons [gsub - Pattern Matching and Replace all occurences]
broncos.text = gsub("[^[:alnum:]|^[:space:]]", "", broncos.text)
cardinals.text = gsub("[^[:alnum:]|^[:space:]]", "", cardinals.text)
falcons.text = gsub("[^[:alnum:]|^[:space:]]", "", falcons.text)
steelers.text = gsub("[^[:alnum:]|^[:space:]]", "", steelers.text)
patriots.text = gsub("[^[:alnum:]|^[:space:]]", "", patriots.text)
#Loading Dictionary Words
pos.words <- scan('/Users/Esh/Desktop/pos.txt',what='character', comment.char=';')
neg.words <- scan('/Users/Esh/Desktop/neg.txt',what='character', comment.char=';')
#Sentiment Analysis function
score.sentiment = function(sentences, pos.words, neg.words, .progress='none')
{
require(plyr)
require(stringr)
scores = laply(sentences, function(sentence, pos.words, neg.words) {
# clean up sentences punctuations, Emoticons etc.,
sentence = gsub('[[:punct:]]', '', sentence) #punctuations
sentence = gsub('[[:cntrl:]]', '', sentence) #emoticons
sentence = gsub('\\d+', '', sentence) #
sentence = tolower(sentence) #to make tweets to lower case
word.list = str_split(sentence, '\\s+') # split into words str_split is in the stringr package
#sometimes a list() is one level of hierarchy too much
words = unlist(word.list)
# compare our words to the dictionaries of positive & negative terms
pos.matches = match(words, pos.words)
neg.matches = match(words, neg.words)
# match() returns the position of the matched term or NA
# we just want a TRUE/FALSE true=1 & false=0:
pos.matches = !is.na(pos.matches)
neg.matches = !is.na(neg.matches)
score = sum(pos.matches) - sum(neg.matches)
return(score)
}, pos.words, neg.words, .progress=.progress )
scores.df = data.frame(score=scores, text=sentences)
return(scores.df)
}
#Score to each team’s tweet recorded
broncos.scores <- score.sentiment(broncos.text, pos.words,neg.words, .progress='text')
cardinals.scores <- score.sentiment(cardinals.text, pos.words,neg.words, .progress='text')
falcons.scores <- score.sentiment(falcons.text, pos.words,neg.words, .progress='text')
steelers.scores <- score.sentiment(steelers.text, pos.words,neg.words, .progress='text')
patriots.scores <- score.sentiment(patriots.text, pos.words,neg.words, .progress='text')
#Give a name to each team
broncos.scores$team = 'Denver Broncos'
broncos.scores$code = 'Broncos'
cardinals.scores$team = 'Arizona Cardinals'
cardinals.scores$code = 'Cardinals'
falcons.scores$team = 'Atlanta Falcons'
falcons.scores$code = 'Falcons'
steelers.scores$team = 'Pittsburgh Steelers'
steelers.scores$code = 'Steelers'
patriots.scores$team = 'New England Patriots'
patriots.scores$code = 'Patriots'
t.scores = rbind(broncos.scores, cardinals.scores, falcons.scores, steelers.scores, patriots.scores)
#Sentiment Analysis Graph
ggplot(data=t.scores) +
geom_bar(mapping=aes(x=score, fill=team), binwidth=1) +
facet_grid(team~.) +
theme_bw() + scale_color_brewer() +
labs(title="Sentiment Analysis of FIve NFL Teams")
#Create Wordcloud
tweets <- searchTwitter("#Rockies", n=1499,lang="en")
tweets.text <- sapply(tweets, function(x) x$getText()) #Fetch the text of the Tweets
tweets.text <- gsub("rt", "", tweets.text) # First we will remove retweet entities from the stored tweets
tweets.text <- gsub("@\\w+", "", tweets.text) #remove all “@people”
tweets.text <- gsub("[[:punct:]]", "", tweets.text) #remove all the punctuation
tweets.text <- gsub("http\\w+", "", tweets.text) #remove html links, which are not required for sentiment analysis
tweets.text <- gsub("[ |\t]{2,}", "", tweets.text) #remove unnecessary spaces (white spaces, tabs etc)
tweets.text <- gsub("^ ", "", tweets.text)
tweets.text <- gsub(" $", "", tweets.text)
library("tm")
tweets.text.corpus <- Corpus(VectorSource(tweets.text)) #build a corpus, which is a collection of text
# VectorSource specifies that the source is character vectors.
tweets.text.corpus <- tm_map(tweets.text.corpus, function(x)removeWords(x,stopwords()))
#remove stop words
library("wordcloud")
wordcloud(tweets.text.corpus,min.freq = 2, scale=c(7,0.5),colors=brewer.pal(8, "Dark2"),
random.color= TRUE, random.order = FALSE, max.words = 150)