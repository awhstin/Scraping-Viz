library(igraph)
library(plotly)
library(plyr)
library(curl)


G <- read.graph("dolphins.gml", format = c("gml"))
L <- layout_nicely(G)

vs <- V(G)
es <- as.data.frame(get.edgelist(G))

#marker size
size<-count(es$V2)
size<-rename(size,c("x"="V2"))
es<-join(es,size, by='V2', type="left")

Nv <- length(vs)
Ne <- length(es[1]$V1)

Xn <- L[,1]
Yn <- L[,2]

network <- plot_ly(type = "scatter", x = Xn, y = Yn, size=es$freq ,mode = "markers", text = vs$label, hoverinfo = "text", color="#6666b2")

edge_shapes <- list()
for(i in 1:Ne) {
  v0 <- es[i,]$V1
  v1 <- es[i,]$V2
  
  edge_shape = list(
    type = "line",
    line = list(color = "#b2b2d8", width = 0.3),
    x0 = Xn[v0],
    y0 = Yn[v0],
    x1 = Xn[v1],
    y1 = Yn[v1]
  )
  
  edge_shapes[[i]] <- edge_shape
}

network <- layout(
  network,
  title = 'Dolphin Social Network',
  shapes = edge_shapes,
  xaxis = list(title = "", showgrid = FALSE, showticklabels = FALSE, zeroline = FALSE),
  yaxis = list(title = "", showgrid = FALSE, showticklabels = FALSE, zeroline = FALSE)
)
network
