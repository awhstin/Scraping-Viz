#Data for this project can be found at http://pendientedemigracion.ucm.es/info/cliwoc/
library(maptools)
fm<- read.csv("CLIWOC15.csv", header = TRUE, sep = ",")
spain<-fm[fm$Nation=="Spain",]
france<-fm[fm$Nation=="France",]
nether<-fm[fm$Nation=="Nederland",]
uk<-fm[fm$Nation=="United Kingdom",]

#roads
shape <- readShapeLines("ne_10m_roads.shp")

#points
plot(shape,lwd=.3, main="Spain")
points(spain$Lon3,spain$Lat3,cex=.05, pch=19, col="red4")
points(france$Lon3,france$Lat3,cex=.05, pch=19, col="royalblue4")
points(nether$Lon3,nether$Lat3,cex=.1, pch=19, col="sienna1")
points(uk$Lon3,uk$Lat3,cex=.1, pch=19, col="gray78")

#create panel, this part creates the grid system which you then assign parts to. 
old.par <- par(mfrow=c(2, 2))
plot(shape,lwd=.3, main="Spain")
points(spain$Lon3,spain$Lat3,cex=.01, pch=19, col="red4")
plot(shape,lwd=.3, main="France")
points(france$Lon3,france$Lat3,cex=.01, pch=19, col="royalblue4")
plot(shape,lwd=.3, main="Nederland")
points(nether$Lon3,nether$Lat3,cex=.01, pch=19, col="sienna1")
plot(shape,lwd=.3, main="United Kingdom")
points(uk$Lon3,uk$Lat3,cex=.01, pch=19, col="gray78")
par(old.par)


