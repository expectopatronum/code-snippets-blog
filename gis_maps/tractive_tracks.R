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
  #x<-strptime(as.character(tracking$time), "%Y-%m-%dT%H:%M:%SZ")
  tracking$min<-60*tracking$time$hour + tracking$time$min
  
  message(paste("read", nrow(tracking), "tracking points"))
  
  return(tracking)
}

## libraries

library(devtools)
devtools::install_github("rstudio/leaflet")
library(leaflet)
library(xlsx)

## read track

track<-readTrackingFile("../../data/LJWSIZUT.gpx")
plot(track$lon, track$lat, pch=19, cex=0.5) # showed that some were far off
track_saved<-track
head(track)
track<-track[track$lat > 30,]

#### track vacation ####

time_pattern<-"%Y-%m-%dT%H:%M:%SZ"
vacation_start<-strptime("2015-07-23T05:00:00Z", time_pattern)
vacation_end<-strptime("2015-08-04T22:00:00Z", time_pattern)
track_vacation<-track[track$time>vacation_start & track$time<vacation_end,]
track_vacation<-track_vacation[!is.na(track_vacation$min),]

write.csv(track_vacation, file="../../data/track_vacation.csv", row.names=FALSE)

#### create map ####

myMap <- leaflet() %>% addTiles()
myMap  # a map with the default OSM tile layer

myMap %>% fitBounds(min(track$lon), min(track$lat), max(track$lon), max(track$lat))
myMap %>% addPolylines(track_vacation$lon, track_vacation$lat)


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
summary(track_cat[,c("lon","lat")])
summary(track_cat[abs(track_cat$ele-423)<30,c("lon","lat")])

time_pattern<-"%Y-%m-%d %H:%M:%S"
track_cat[track_cat$time > strptime("2015-06-25 23:54:10", format=time_pattern),"cat"]<-"Teddy"
track_cat_clean<-track_cat[abs(track_cat$ele-423)<30,]
track_cat_teddy<-track_cat[abs(track_cat$ele-423)<30,]
track_cat_teddy[track_cat_teddy$time > strptime("2015-06-25 23:54:10", format=time_pattern),"cat"]<-"Teddy"
track_cat_teddy <- track_cat_teddy[track_cat_teddy$cat=="Teddy",]
# one dot in pregarten at 14.53874 48.35198
track_cat_teddy<- track_cat_teddy[!track_cat_teddy$lat>48.32,]

write.csv(track_cat, file="../../data/track_cat.csv", row.names=FALSE)
write.csv(track_cat_clean[track_cat_clean$cat!="Unknown",], file="/Volumes/Vero/Repos/tractive_data/track_cat_clean.csv", row.names=FALSE)

col<-c("gray", "blue", "pink", "red", "green")
mycats<-unique(track_cat$cat)

catMap<-leaflet() %>% addTiles()
for (i in 1:length(mycats)) {
  cat<-mycats[i]
  catMap<-catMap %>% addPolylines(track_cat[track_cat$cat==cat,"lon"], track_cat[track_cat$cat==cat,"lat"], col=col[i], group=cat)
}

print(catMap)

## map of cleaned cat data

catMap<-leaflet() %>% addTiles()

for (i in 1:length(mycats)) {
  cat<-mycats[i]
  if (cat != "Unknown") {
    catMap<-catMap %>% addPolylines(track_cat_clean[track_cat_clean$cat==cat,"lon"], track_cat_clean[track_cat_clean$cat==cat,"lat"], col=col[i], group=cat) 
  }
}

catMap %>%
addLayersControl( 
  overlayGroups = mycats[2:5], 
  options = layersControlOptions(collapsed = FALSE))

## map of teddy

## map of cleaned cat data

track_cat_teddy<- track_cat_teddy[!(track_cat_teddy$time < strptime("2015-07-24", "%Y-%m-%d") & track_cat_teddy$time > strptime("2015-07-22", "%Y-%m-%d")),]

monthCol<-c("blue", "green", "yellow", "purple", "brown", "orange")
month<-c("March", "May", "June", "July", "August", "November")
catMap<-leaflet() %>% addTiles()
for (i in 1:length(unique(track_cat_teddy$time$mon))) {
  m<-unique(track_cat_teddy$time$mon)[i]
  catMap<-catMap %>% addPolylines(track_cat_teddy[track_cat_teddy$time$mon==m,"lon"], track_cat_teddy[track_cat_teddy$time$mon==m,"lat"], col=monthCol[i], group=month[i])   
}
catMap

catMap %>%
  addLayersControl( 
    overlayGroups = month, 
    options = layersControlOptions(collapsed = FALSE))
