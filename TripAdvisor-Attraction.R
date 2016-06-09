#This code is an addendum to the fantastic code Hadley (rvest/demo/tripadvisor.R) put out on Trip Advisor scraping. It is a for-loop specifically for Attraction
#related entities on Trip Advisor, and runs off a CSV of urls for your attraction. 
#There is a commented out section that addresses the issue where Trip Advisor changed the date formata couple years ago, 
#so it grabs all the dates as strings.

library(rvest)

testurl <- read.csv("url.csv", header=FALSE, quote="'", stringsAsFactors = F)
list<-unlist(testurl)

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
  html_node(".rating .ratingDate") %>%
  html_attr("title") %>%
  strptime("%b %d, %Y") %>%
  as.POSIXct()
  
strdate <- reviews %>%
  html_node(".rating .ratingDate") %>%
  html_text()

review <- reviews %>%
  html_node(".entry .partial_entry") %>%
  html_text()%>%
  as.character()
  
member <- list[i] %>% 
  read_html() %>% 
  html_nodes("#REVIEWS .col1of2")

location <- member %>%
  html_node(".location") %>%
  html_text()
  
member %>% 
html_node(“.username”) %>% 
html_text(trim=TRUE) %>%
ifelse(identical(., character(0)), NA, .)
rowthing <-data.frame(id, quote, rating, review, date, strdate, location, stringsAsFactors = FALSE)
}

#grab total rankings
url<-('https://www.tripadvisor.com/Attraction_Review-g35805-d103239-Reviews-or500-Art_Institute_of_Chicago-Chicago_Illinois.html#REVIEWS')

totals <- list %>% 
  read_html() %>% 
  html_nodes(".main_content .barChart")

ratings <- totals %>%
  html_nodes(".part") %>%
  html_text() %>%
  t(data.frame())

#export
write.csv(tripadvisoraic,file='TripAdvisor.csv')
