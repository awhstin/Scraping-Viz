#two column dataframe with the first column being the url of the website the second being the XML path.

library(syuzhet)
library(rvest)
library(plyr)

news<- read.csv("H:/news.csv", stringsAsFactors=FALSE)
newslist<-NULL
for(i in 1:nrow(news)){
article<-read_html(news[i,1])%>%
    xml_nodes(news[i,2]) %>%
    html_text() 
article<-gsub("[^[:alnum:]]", " ", article)
alist<-as.list(article)
dat<- do.call(rbind.fill.matrix,alist)
sentiment<-(get_sentiment(as.vector(na.omit(dat)), method = "bing"))
newssource<-data.frame(article,news[i,1],sentiment,stringsAsFactors = FALSE)
rename(newssource, c('news.i..1.'='Source'))
newslist<-rbind(newslist,newssource)
}

#write data as date.csv
write.csv(newslist,file = paste(Sys.Date(),".csv",sep="",collapse=NULL), row.names=TRUE)


