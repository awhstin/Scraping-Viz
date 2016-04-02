library(plotly)

x <- list(
  title = ""
)
y <- list(
  title = "Mean Sentiment (Bing)"
)

p<-plot_ly(Words, x =outlet, y =Mean,text = rownames(Words), type="bar", showlegend = FALSE, marker=list(color="rgb(55, 83, 109)")) %>%
add_trace(Words,x=Words$outlet, y = Words$X4.13.am,mode="markers" ,name = "Hillary for President", showlegend = TRUE, marker=list(color="rgb(234, 153, 153)"))%>%
add_trace(Words,x=Words$outlet, y = Words$X26.Apr, mode="markers", name = "Baltimore Riots/Nepal Earthquake", showlegend = TRUE, marker=list(color="rgb(106, 168, 79)"))%>%
layout(legend = list(x = 0.5, y = 0.90), title = "Mean Sentiment of News Outlets in April 2015", xaxis=x, yaxis=y)

plotly_POST(p, filename = "News_Sentiment")
