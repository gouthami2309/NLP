install.packages("tm")
install.packages("SnowballC")
install.packages("wordcloud")
install.packages("RColorBrewer")
install.packages("RCurl")
install.packages("XML")
library(tm)
library(SnowballC)
library(wordcloud)
library(RCurl)
library(XML)
library(RColorBrewer)
text1 <- readLines("C:/Users/GOUTHAMI VENKATEH/Desktop/SPEACH.txt")
class(text1)
View(text1)
docs <- Corpus(VectorSource(text1))
inspect(docs)

toSpace <- content_transformer(function (x, pattern ) gsub(pattern, " ", x))
docs <- tm_map(docs, toSpace, "/")
docs <- tm_map(docs, toSpace, "@")
docs <- tm_map(docs, toSpace, "\\|")

# Convert the text to lower case
docs <- tm_map(docs, content_transformer(tolower))
# Remove numbers
docs <- tm_map(docs, removeNumbers)
# Remove english common stopwords
docs <- tm_map(docs, removeWords, stopwords("english"))
# Remove punctuations
docs <- tm_map(docs, removePunctuation)
# Eliminate extra white spaces
docs <- tm_map(docs, stripWhitespace)

dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 10)

install.packages("wordcloud")
install.packages("RColorBrewer")
library(wordcloud)
library(RColorBrewer)
display.brewer.all()

set.seed(123)
wordcloud(words = d$word, freq = d$freq, min.freq = 4,
          max.words=100, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Set1"))
