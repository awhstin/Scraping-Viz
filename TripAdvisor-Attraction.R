#This code is an addendum to the fantastic code Hadley (rvest/demo/tripadvisor.R) put out on Trip Advisor scraping. It is a for-loop specifically for Attraction
#related entities on Trip Advisor, and runs off a CSV of urls for your attraction. 

library(rvest)

testurl <- read.csv("url.csv", header=FALSE, quote="'", stringsAsFactors = F)
list<-unlist(testurl)

tripadvisor <- NULL

for(i in 1:length(list)){

reviews <- list[i] %>% 
  read_html() %>% 
  html_nodes("#REVIEWS .innerBubble")

id <- reviews %>%
  html_node(".quote a") %>%
  html_attr("id")

quote <- reviews %>%
  html_node(".quote span") %>%
  html_text()

rating <- reviews %>%
  html_node(".rating .rating_s_fill") %>%
  html_attr("alt") %>%
  gsub(" of 5 stars", "", .) %>%
  as.integer()

date <- reviews %>%
# html_node(".rating .ratingDate") %>%
# html_text()
  html_node(".rating .ratingDate") %>%
  html_attr("title") %>%
  strptime("%b %d, %Y") %>%
  as.POSIXct()

review <- reviews %>%
  html_node(".entry .partial_entry") %>%
  html_text()%>%
  as.character()

rowthing <-data.frame(id, quote, rating, review, date, stringsAsFactors = FALSE)
tripadvisoraic<-rbind(rowthing, tripadvisor)
}

#export
write.csv(tripadvisoraic,file='TripAdvisorAICD.csv')