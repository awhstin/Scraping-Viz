library(RCurl)
library(XML)
library(plyr)
library(wordcloud)
library(RColorBrewer)
library(textir)

html <- getURL("https://twitter.com/user", followlocation = TRUE) #put in twitter user
doc <- htmlParse(html, asText=TRUE)
webtext <- xpathSApply(doc, "//p", xmlValue)
words.l<-strsplit(webtext, "\\W")
text<-unlist(words.l)
d<-as.data.frame(text)

density<- ddply(d, .(text), "nrow")
names(density)[2] <- "count"
AW<- merge(d, density)
duplicated(AW$text)
AW[duplicated(AW$text),]
unique(AW[duplicated(AW$text),])
AW<-AW[!duplicated(AW$text),]
m<-as.matrix(AW$count)
m<-tfidf(m, normalize=F)
AW<-cbind(AW, m)

#Make the word cloud
require('wordcloud')
require('RColorBrewer')
pal2 <- brewer.pal(8,"RdYlBu")
png("wordcloud_packages.png", width=400,height=350)
wordcloud(AW$text, AW$count, scale=c(4,.5),min.freq=1,max.words=Inf, random.order=FALSE, rot.per=.15, colors=pal2)
