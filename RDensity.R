#This mapping runs off of zipcodes, so in your .csv you have loaded there needs to be
#a column called ZIP, with zipcodes in it. 

#This should be able to run as-is with a dummy .csv of Farmer's Markets
#To run with your own data:
#Just save a copy of your .csv in "R" in my public folder

#These are the required packages which should be installed.
#install.packages("ggmap")
#install.packages("zipcode")
#install.packages("maps")
library('ggmap')
library('zipcode')
library('maps')

#This is where R reads the .csv file you have, the " "is where it is located
#header should be T if you have headers, F if not. 
#sep is the delimiting variable, this case a ","
data <- read.csv("FM.csv", header = TRUE, sep = ",")


#This uses census data to clean the zipcodes, it also generates latitude
#and longitude valuesto use for mapping. 
data$zip<- clean.zipcodes(data$ZIP)
data(zipcode)
clean.data<- merge(data, zipcode, by.x='zip', by.y='zip')

#This is where most of the editing will be, the location can be changed to
#a city, or state, and the zoom can be adjusted to what you want. The 
#larger the zoom the locations it can find are:
#texas, lincoln, united states, baylor university.
#remove the hash to make the same map but black and white

map<-get_map(location='united states', zoom=4, maptype='roadmap')
#map<-get_map(location='united states', zoom=4, maptype='roadmap', color="bw")
ggmap(map)+geom_point(aes(x=longitude, y=latitude), data=clean.data, alpha=.5, cex=.01)+theme(legend.position="none")

#You will get a Warning message at the end that tells you how many of the 
#entries were omitted because they fall outside the range of the map.
