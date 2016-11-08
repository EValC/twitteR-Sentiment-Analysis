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
consumerKey <- "C97VucQqe3HcfS3guv60"
consumerSecret <- "6GTBqOEGZdPfMerMf35qZBrhQhGBuywFzD9VXRH7XJ"
my_oauth <- OAuthFactory$new(consumerKey=consumerKey, consumerSecret=consumerSecret, requestURL=requestURL, accessURL=accessURL, authURL=authURL)
my_oauth$handshake(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"))
save(my_oauth, file="twitter authentication.Rdata")
accessToken= '570658467-UH9q200QT08WkV9tayfvlS64QQ5euE9'
accessSecret= 'hRqyuexn2lD2DFuCGiDVqYOzPvQb5q9Qeh64'
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
broncos.tweets <- searchTwitter('#Broncos', n=2000, lang="en")
cardinals.tweets <- searchTwitter('#BeRedSeeRed', n=2000, lang="en")
falcons.tweets <- searchTwitter('#RiseUp', n=2000, lang="en")
steelers.tweets<-searchTwitter('#HereWeGo',n=2000,lang="en")
patriots.tweets <- searchTwitter('#Patriots', n=2000, lang="en")
ravens.tweets <- searchTwitter('#RavensFlock', n=2000, lang="en")
bills.tweets <- searchTwitter('#GoBills', n=2000, lang="en")
panthers.tweets <- searchTwitter('#KeepPounding', n=2000, lang="en")
bears.tweets <- searchTwitter('#FeedDaBears', n=2000, lang="en")
bengals.tweets <- searchTwitter('#WhoDey', n=2000, lang="en")
browns.tweets <- searchTwitter('#Dawgpound', n=2000, lang="en")
cowboys.tweets <- searchTwitter('#DallasCowboys', n=2000, lang="en")
lions.tweets <- searchTwitter('#OnePride', n=2000, lang="en")
packers.tweets <- searchTwitter('#GoPackGo', n=2000, lang="en")
texans.tweets <- searchTwitter('#WeAreTexans', n=2000, lang="en")
colts.tweets <- searchTwitter('#ForTheShoe', n=2000, lang="en")
jaguars.tweets <- searchTwitter('#Jaguars', n=2000, lang="en")
chiefs.tweets <- searchTwitter('#Chiefs', n=2000, lang="en")
dolphins.tweets <- searchTwitter('#FinsUp', n=2000, lang="en")
vikings.tweets <- searchTwitter('#Skol', n=2000, lang="en")
saints.tweets <- searchTwitter('#Saints50', n=2000, lang="en")
giants.tweets <- searchTwitter('#GiantsPride', n=2000, lang="en")
jets.tweets <- searchTwitter('#JetUp', n=2000, lang="en")
raiders.tweets <- searchTwitter('#RaiderNation', n=2000, lang="en")
eagles.tweets <- searchTwitter('#FlyEagelsFly', n=2000, lang="en")
chargers.tweets <- searchTwitter('#Chargers', n=2000, lang="en")
fners.tweets <- searchTwitter('#GoNiners', n=2000, lang="en")
seahawks.tweets <- searchTwitter('#WeAre12', n=2000, lang="en")
rams.tweets <- searchTwitter('#MobSquad', n=2000, lang="en")
buccaneers.tweets <- searchTwitter('#SiegeTheDay', n=2000, lang="en")
titans.tweets <- searchTwitter('#TitanUp', n=2000, lang="en")
redskins.tweets <- searchTwitter('#Redskins', n=2000, lang="en")
#output text (laply [plyr] : For each element of a list, apply function then combine results into an array.)
broncos.text = laply(broncos.tweets, function(t) t$getText())
cardinals.text = laply(cardinals.tweets, function(t) t$getText())
falcons.text = laply(falcons.tweets, function(t) t$getText())
steelers.text = laply(steelers.tweets, function(t) t$getText())
patriots.text = laply(patriots.tweets, function(t) t$getText())
ravens.text = laply(ravens.tweets, function(t) t$getText())
bills.text = laply(bills.tweets, function(t) t$getText())
panthers.text = laply(panthers.tweets, function(t) t$getText())
bears.text = laply(bears.tweets, function(t) t$getText())
bengals.text = laply(bengals.tweets, function(t) t$getText())
browns.text = laply(browns.tweets, function(t) t$getText())
cowboys.text = laply(cowboys.tweets, function(t) t$getText())
lions.text = laply(lions.tweets, function(t) t$getText())
packers.text = laply(packers.tweets, function(t) t$getText())
texans.text = laply(texans.tweets, function(t) t$getText())
colts.text = laply(colts.tweets, function(t) t$getText())
jaguars.text = laply(jaguars.tweets, function(t) t$getText())
chiefs.text = laply(chiefs.tweets, function(t) t$getText())
dolphins.text = laply(dolphins.tweets, function(t) t$getText())
vikings.text = laply(vikings.tweets, function(t) t$getText())
saints.text = laply(saints.tweets, function(t) t$getText())
giants.text = laply(giants.tweets, function(t) t$getText())
jets.text = laply(jets.tweets, function(t) t$getText())
raiders.text = laply(raiders.tweets, function(t) t$getText())
eagles.text = laply(eagles.tweets, function(t) t$getText())
chargers.text = laply(chargers.tweets, function(t) t$getText())
fners.text = laply(fners.tweets, function(t) t$getText())
seahawks.text = laply(seahawks.tweets, function(t) t$getText())
rams.text = laply(rams.tweets, function(t) t$getText())
buccaneers.text = laply(buccaneers.tweets, function(t) t$getText())
titans.text = laply(titans.tweets, function(t) t$getText())
redskins.text = laply(redskins.tweets, function(t) t$getText())
#Striping out funny characters and emoticons [gsub - Pattern Matching and Replace all occurences]
broncos.text = gsub("[^[:alnum:]|^[:space:]]", "", broncos.text)
cardinals.text = gsub("[^[:alnum:]|^[:space:]]", "", cardinals.text)
falcons.text = gsub("[^[:alnum:]|^[:space:]]", "", falcons.text)
steelers.text = gsub("[^[:alnum:]|^[:space:]]", "", steelers.text)
patriots.text = gsub("[^[:alnum:]|^[:space:]]", "", patriots.text)
ravens.text = gsub("[^[:alnum:]|^[:space:]]", "", ravens.text)
bills.text = gsub("[^[:alnum:]|^[:space:]]", "", bills.text)
panthers.text = gsub("[^[:alnum:]|^[:space:]]", "", panthers.text)
bears.text = gsub("[^[:alnum:]|^[:space:]]", "", bears.text)
bengals.text = gsub("[^[:alnum:]|^[:space:]]", "", bengals.text)
browns.text = gsub("[^[:alnum:]|^[:space:]]", "", browns.text)
cowboys.text = gsub("[^[:alnum:]|^[:space:]]", "", cowboys.text)
lions.text = gsub("[^[:alnum:]|^[:space:]]", "", lions.text)
packers.text = gsub("[^[:alnum:]|^[:space:]]", "", packers.text)
texans.text = gsub("[^[:alnum:]|^[:space:]]", "", texans.text)
colts.text = gsub("[^[:alnum:]|^[:space:]]", "", colts.text)
jaguars.text = gsub("[^[:alnum:]|^[:space:]]", "", jaguars.text)
chiefs.text = gsub("[^[:alnum:]|^[:space:]]", "", chiefs.text)
dolphins.text = gsub("[^[:alnum:]|^[:space:]]", "", dolphins.text)
vikings.text = gsub("[^[:alnum:]|^[:space:]]", "", vikings.text)
saints.text = gsub("[^[:alnum:]|^[:space:]]", "", saints.text)
giants.text = gsub("[^[:alnum:]|^[:space:]]", "", giants.text)
jets.text = gsub("[^[:alnum:]|^[:space:]]", "", jets.text)
raiders.text = gsub("[^[:alnum:]|^[:space:]]", "", raiders.text)
eagles.text = gsub("[^[:alnum:]|^[:space:]]", "", eagles.text)
chargers.text = gsub("[^[:alnum:]|^[:space:]]", "", chargers.text)
fners.text = gsub("[^[:alnum:]|^[:space:]]", "", fners.text)
seahawks.text = gsub("[^[:alnum:]|^[:space:]]", "", seahawks.text)
rams.text = gsub("[^[:alnum:]|^[:space:]]", "", rams.text)
buccaneers.text = gsub("[^[:alnum:]|^[:space:]]", "", buccaneers.text)
titans.text = gsub("[^[:alnum:]|^[:space:]]", "", titans.text)
redskins.text = gsub("[^[:alnum:]|^[:space:]]", "", redskins.text)
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
sentence = gsub('\\d+', '', sentence)
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
#Score to each teams tweet recorded
broncos.scores <- score.sentiment(broncos.text, pos.words,neg.words, .progress='text')
cardinals.scores <- score.sentiment(cardinals.text, pos.words,neg.words, .progress='text')
falcons.scores <- score.sentiment(falcons.text, pos.words,neg.words, .progress='text')
steelers.scores <- score.sentiment(steelers.text, pos.words,neg.words, .progress='text')
patriots.scores <- score.sentiment(patriots.text, pos.words,neg.words, .progress='text')
ravens.scores <- score.sentiment(ravens.text, pos.words,neg.words, .progress='text')
bills.scores <- score.sentiment(bills.text, pos.words,neg.words, .progress='text')
panthers.scores <- score.sentiment(panthers.text, pos.words,neg.words, .progress='text')
bears.scores <- score.sentiment(bears.text, pos.words,neg.words, .progress='text')
bengals.scores <- score.sentiment(bengals.text, pos.words,neg.words, .progress='text')
browns.scores <- score.sentiment(browns.text, pos.words,neg.words, .progress='text')
cowboys.scores <- score.sentiment(cowboys.text, pos.words,neg.words, .progress='text')
lions.scores <- score.sentiment(lions.text, pos.words,neg.words, .progress='text')
packers.scores <- score.sentiment(packers.text, pos.words,neg.words, .progress='text')
texans.scores <- score.sentiment(texans.text, pos.words,neg.words, .progress='text')
colts.scores <- score.sentiment(colts.text, pos.words,neg.words, .progress='text')
jaguars.scores <- score.sentiment(jaguars.text, pos.words,neg.words, .progress='text')
chiefs.scores <- score.sentiment(chiefs.text, pos.words,neg.words, .progress='text')
dolphins.scores <- score.sentiment(dolphins.text, pos.words,neg.words, .progress='text')
vikings.scores <- score.sentiment(vikings.text, pos.words,neg.words, .progress='text')
saints.scores <- score.sentiment(saints.text, pos.words,neg.words, .progress='text')
giants.scores <- score.sentiment(giants.text, pos.words,neg.words, .progress='text')
jets.scores <- score.sentiment(jets.text, pos.words,neg.words, .progress='text')
raiders.scores <- score.sentiment(raiders.text, pos.words,neg.words, .progress='text')
eagles.scores <- score.sentiment(eagles.text, pos.words,neg.words, .progress='text')
chargers.scores <- score.sentiment(chargers.text, pos.words,neg.words, .progress='text')
fners.scores <- score.sentiment(fners.text, pos.words,neg.words, .progress='text')
seahawks.scores <- score.sentiment(seahawks.text, pos.words,neg.words, .progress='text')
rams.scores <- score.sentiment(rams.text, pos.words,neg.words, .progress='text')
buccaneers.scores <- score.sentiment(buccaneers.text, pos.words,neg.words, .progress='text')
titans.scores <- score.sentiment(titans.text, pos.words,neg.words, .progress='text')
redskins.scores <- score.sentiment(redskins.text, pos.words,neg.words, .progress='text')
#Give a name and code to display to each team
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
ravens.scores$team = 'Baltimore Ravens'
ravens.scores$code = 'Ravens'
bills.scores$team = 'Buffalo Bills'
bills.scores$code = 'Bills'
panthers.scores$team = 'Carolina Panthers'
panthers.scores$code = 'Panthers'
bears.scores$team = 'Chicago Bears'
bears.scores$code = 'Bears'
bengals.scores$team = 'CinCinnati Bengals'
bengals.scores$code = 'Bengals'
browns.scores$team = 'Cleveland Browns'
browns.scores$code = 'Browns'
cowboys.scores$team = 'Dallas Cowboys'
cowboys.scores$code = 'Cowboys'
lions.scores$team = 'Dallas Lions'
lions.scores$code = 'Lions'
packers.scores$team = 'Green Bay Packers'
packers.scores$code = 'Packers'
texans.scores$team = 'Houston Texans'
texans.scores$code = 'Texans'
colts.scores$team = 'Indianapolis Colts'
colts.scores$code = 'Colts'
jaguars.scores$team = 'Jacksonville Jaguars'
jaguars.scores$code = 'Jaguars'
chiefs.scores$team = 'Kansas City Chiefs'
chiefs.scores$code = 'Chiefs'
dolphins.scores$team = 'Miami Dolphins'
dolphins.scores$code = 'Dolphins'
vikings.scores$team = 'Minnesota Vikings'
vikings.scores$code = 'Vikings'
saints.scores$team = 'New Orleans Saints'
saints.scores$code = 'Saints'
giants.scores$team = 'New York Giants'
giants.scores$code = 'Giants'
jets.scores$team = 'New York Jets'
jets.scores$code = 'Jets'
raiders.scores$team = 'Oakland Raiders'
raiders.scores$code = 'Raiders'
eagles.scores$team = 'Philadelphia Eagles'
eagles.scores$code = 'Eagles'
chargers.scores$team = 'San Diego Chargers'
chargers.scores$code = 'Chargers'
fners.scores$team = 'San Francisco 49ers'
fners.scores$code = '49ers'
seahawks.scores$team = 'Seattle Seahawks'
seahawks.scores$code = 'Seahawks'
rams.scores$team = 'St.Louis Rams'
rams.scores$code = 'Rams'
buccaneers.scores$team = 'Tampa Bay Buccaneers'
buccaneers.scores$code = 'Buccaneers'
titans.scores$team = 'Tennesse Titans'
titans.scores$code = 'Titans'
redskins.scores$team = 'Washington Redskins'
redskins.scores$code = 'Redskins'
t.scores = rbind(broncos.scores, cardinals.scores, falcons.scores, steelers.scores, patriots.scores, ravens.scores, 
bills.scores, panthers.scores, bears.scores, bengals.scores, browns.scores, cowboys.scores, lions.scores, packers.scores, 
texans.scores, colts.scores, jaguars.scores, chiefs.scores, dolphins.scores, vikings.scores, saints.scores, gian.scores, 
jets.scores, raiders.scores, eagles.scores, chargers.scores, fners.scores, seahawks.scores, rams.scores, buccaneers.scores, 
titans.scores, redskins.scores)
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
tweets.text <- gsub("@\\w+", "", tweets.text) #remove all @people
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
