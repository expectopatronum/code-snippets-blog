 ## libraries

library(devtools)
devtools::install_github("rstudio/leaflet")
library(leaflet)
library(xlsx)

## read functions

readTrackingFile<-function(filename) {
  library(XML)
  library(plyr)
  xmlfile<-xmlParse(filename)
  xmltop<-xmlRoot(xmlfile)
  tracking<-ldply(xmlToList(xmltop[['trk']][['trkseg']]), function(x) {
    data.frame(x)
  })
  
  tracking<-data.frame("ele"=tracking$ele[seq(1, nrow(tracking), 2)], "time"=as.character(tracking$time[seq(1, nrow(tracking), 2)]),"lat"=tracking$.attrs[seq(1, nrow(tracking), 2)], "lon"=tracking$.attrs[seq(2, nrow(tracking), 2)])
  
  tracking$ele<-as.numeric(levels(tracking$ele))[tracking$ele]
  tracking$lat<-as.numeric(levels(tracking$lat))[tracking$lat]
  tracking$lon<-as.numeric(levels(tracking$lon))[tracking$lon]
  
  time_pattern<-"%Y-%m-%dT%H:%M:%SZ"
  tracking$time<-strptime(as.character(tracking$time), time_pattern)
  tracking$min<-60*tracking$time$hour + tracking$time$min
  
  message(paste("read", nrow(tracking), "tracking points"))
  
  return(tracking)
}

## read track

track<-readTrackingFile("../../data/LJWSIZUT.gpx")
plot(track$lon, track$lat, pch=19, cex=0.5, xlab="Lon", ylab="Lat") # showed that some were far off
track<-track[track$lat > 30,]

#### track vacation ####

time_pattern<-"%Y-%m-%dT%H:%M:%SZ"
vacation_start<-strptime("2015-07-23T04:00:00Z", time_pattern)
vacation_end<-strptime("2015-08-04T22:00:00Z", time_pattern)

#### track cats ####

track_cat<-track[track$time<vacation_start | track$time>vacation_end,]

# prepare cats
cats<-read.xlsx("../tractive/data/Katzen1.xlsx", sheetIndex=1, header=FALSE, stringsAsFactors = FALSE)
names(cats)<-c("TrackingDate", "Cat")
cats<-cats[!is.na(cats$Cat),]
time_pattern<-"%d. %B %Y"
cats$TrackingDate<-strptime(paste(cats$TrackingDate, "2015"), format = time_pattern)

# add cat name
track_cat$cat<-"Unknown"
for (i in 1:nrow(track_cat)) {
  cat_idx<-which((cats$TrackingDate$mday == track_cat[i,"time"]$mday) 
                 & (cats$TrackingDate$mon+1 == track_cat[i,"time"]$mon+1)
                 & (cats$TrackingDate$year+1900 == track_cat[i,"time"]$year+1900))
  if (length(cat_idx) == 1) {
    track_cat[i,"cat"]<-cats[cat_idx, "Cat"]
  }
}

# remove NA

track_cat<-track_cat[!is.na(track_cat$lon),]
track_cat[track_cat$time > vacation_end,"cat"]<-"Teddy"

track_cat_teddy<-track_cat[abs(track_cat$ele-423)<30 & track_cat$cat=="Teddy",]
# one dot in pregarten at 14.53874 48.35198
#track_cat_teddy<- track_cat_teddy[!(track_cat_teddy$time < strptime("2015-07-24", "%Y-%m-%d") & track_cat_teddy$time > strptime("2015-07-22", "%Y-%m-%d")),]

## map of teddy
monthCol<-c("blue", "green", "yellow", "purple", "brown", "orange")
month<-c("March", "May", "June", "July", "August", "November")
catMap<-leaflet() %>% addTiles()
for (i in 1:length(unique(track_cat_teddy$time$mon))) {
  m<-unique(track_cat_teddy$time$mon)[i]
  catMap<-catMap %>% addPolylines(track_cat_teddy[track_cat_teddy$time$mon==m,"lon"], track_cat_teddy[track_cat_teddy$time$mon==m,"lat"], col=monthCol[i], group=m)   
}
catMap

catMap %>%
  addLayersControl( 
    overlayGroups = month, 
    options = layersControlOptions(collapsed = FALSE))
