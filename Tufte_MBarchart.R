library(ggplot2)
library(ggthemes)
library(plyr)
library(rvest)

ice_cream <- read_html("http://future.aae.wisc.edu/data/annual_values/by_area/2252?tab=sales")
ice_table <- ice_cream %>%
  html_nodes('table') %>%
  html_table(fill=TRUE)
stats<-data.frame(ice_table[2])
stats$Year<-as.character(stats$Year)

ggplot(stats, aes(x=Year, y=Value)) + theme_tufte(base_size=14, ticks=F) +
  geom_bar(width=0.25, fill="gray", stat = "identity") +  theme(axis.title=element_blank()) +
  geom_hline(yintercept=seq(5, 20, 5), col="white", lwd=1) +
  annotate("text", x = 20, y = 18, adj=1,  family="serif",
           label = c("Per Capita\n U.S. Frozen Dairy\n Product Consumption\n (Annual)"))
