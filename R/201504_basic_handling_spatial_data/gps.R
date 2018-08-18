#### READ GPX FILES ####

readTrackingFile<-function(filename) {
  require(XML)
  require(plyr)
  xmlfile<-xmlParse(filename)
  xmltop<-xmlRoot(xmlfile)
  tracking<-ldply(xmlToList(xmltop[['trk']][['trkseg']]), function(x) {
    data.frame(x)
  })
  
  tracking<-data.frame("ele"=tracking$ele[seq(1, nrow(tracking), 2)], "time"=as.character(tracking$time[seq(1, nrow(tracking), 2)]),"lat"=tracking$.attrs[seq(1, nrow(tracking), 2)], "lon"=tracking$.attrs[seq(2, nrow(tracking), 2)])
  
  tracking$ele<-as.numeric(levels(tracking$ele))[tracking$ele]
  tracking$lat<-as.numeric(levels(tracking$lat))[tracking$lat]
  tracking$lon<-as.numeric(levels(tracking$lon))[tracking$lon]
  
  x<-strptime(as.character(tracking$time), "%Y-%m-%dT%H:%M:%SZ")
  tracking$min<-60*x$hour + x$min
  
  message(paste("read", nrow(tracking), "tracking points"))
  
  return(tracking)
}

track<-readTrackingFile("data/LJWSIZUT_04_11.gpx")
head(track)

#### READ PLAIN TEXT FILES ####

# important to set locale

testLines<-read.table("~/ownCloud/Bananenhauptquartier/Blog/gps/testCoords.txt", sep=";" ,header=F, quote="", stringsAsFactors = FALSE)$V1

testLines

for (t in testLines) {
  parseCoord(t)
}

#### PARSE CHARACTER STRINGS ####

# min2dec, sec2dec, dec2sec, dec2min, parseCoord

# http://stackoverflow.com/a/7719860/1117932
# http://stackoverflow.com/a/2261149/1117932
# http://stackoverflow.com/a/17415028/1117932
# http://stackoverflow.com/a/16348379/1117932

parseCoord<-function(coordChar) {
  if (!is.character(coordChar)) {
    stop("coord is not in character format.")
  }
  coordChar<-trim(coordChar)
  direction<-substr(coordChar, 1, 1)
  
  if ((direction %in% c("N", "E", "S", "W"))) {
    coordChar<-substr(coordChar, 2, nchar(coordChar))
    coordChar<-trim(coordChar)
  }
  
  splitted<-unlist(strsplit(coordChar, "[ °'\"]"))
  splitted<-splitted[which(splitted!="")]
  deg<-as.numeric(splitted[1])
  
  min<-NULL
  sec<-NULL
  
  if (length(splitted) > 1) { # means it also contains minutes
    min<-as.numeric(splitted[2])
    
    if (length(splitted) > 2) { # means it also contains seconds
      sec<-as.numeric(splitted[3])
    } 
  } else {
    warning ("your coordinates do not seem to contain minutes.")
  }

  return(list("dir"=direction, "deg"=deg, "min"=min, "sec"=sec))
}


p1<-parseCoord("N 48 12.123")
p2<-parseCoord("N 48° 12.123")
p3<-parseCoord("N 48°12'123")
p4<-parseCoord("N 48 12' 123\"")

p1
p2
p3
p4



#### CHECK AND CONVERT ####

trim <- function (x) gsub("^\\s+|\\s+$", "", x)

isSecond<-function(coord) {
  if (is.null(coord[["deg"]])) { return (FALSE) }
  if (is.null(coord[["min"]])) { return (FALSE) }
  if (is.null(coord[["sec"]])) { return (FALSE) }
  
  if (!is.numeric(coord[["deg"]])) {return (FALSE) }
  if (!is.numeric(coord[["min"]]) || coord[["min"]] > 60 || coord[["min"]] < 0) {return (FALSE) }
  if (!is.numeric(coord[["sec"]]) || coord[["sec"]] > 60 || coord[["sec"]] < 0) { return (FALSE) }
  
  return (TRUE)
}

isMinute<-function(coord) {
  if (is.null(coord[["deg"]])) { return (FALSE) }
  if (is.null(coord[["min"]])) { return (FALSE) }
  if (!is.null(coord[["sec"]])) { return (FALSE) }
  
  if (!is.numeric(coord[["deg"]])) { return (FALSE) }
  if (!is.numeric(coord[["min"]]) || coord[["min"]] > 60 || coord[["min"]] < 0) { 
    return (FALSE) 
  }
  return (TRUE)
}

min2dec<-function(coord) {
  
  if (!isMinute(coord)) {
    stop("coord is not in minute format.")
  }  
  dec <- coord$deg + coord$min / 60
  return (dec)
}

sec2dec<-function(coord) {
  if (!isSecond(coord)) {
    stop("coord is not in second format.")
  }  
  dec <- coord$deg + coord$min / 60 + coord$sec / 3600 
  return (dec)
}



#### DISTANCES, ANGLES, ANTIPODES ####

house<-list("lat"=48.320237, "lon"=14.625828)

distMeeus(c(track$lon[1], track$lat[1]), c(house$lon, house$lat))
distCosine(c(track$lon[1], track$lat[1]), c(house$lon, house$lat))
distHaversine(c(track$lon[1], track$lat[1]), c(house$lon, house$lat))

northpol<-list("lat"=90, "lon"=0)

distMeeus(c(northpol$lon, northpol$lat), c(house$lon, house$lat))/1000
distCosine(c(northpol$lon, northpol$lat), c(house$lon, house$lat))/1000
distHaversine(c(northpol$lon, northpol$lat), c(house$lon, house$lat))/1000

bearing(c(house$lon, house$lat), c(track$lon[1], track$lat[1]))
antipode(c(house$lon, house$lat))

#### BASIC PLOT ####

png("track.png")
plot(track$lon, track$lat, pch=19, cex=0.5, col=c("green", rep("black", length(track$lon)-2), "orange"))
points(house$lon, house$lat, col="blue", pch=19)
lines(track$lon, track$lat)
for (i in 1:length(track$lon)) {
  d<-round(distMeeus(c(track$lon[i], track$lat[i]), c(house$lon, house$lat)), digits=0)  
  if (d > 25) {
    a<-round(bearing(c(track$lon[i], track$lat[i]), c(house$lon, house$lat)), digits=2) 
    text(track$lon[i], track$lat[i] + 0.00005 , labels=paste(d, "m", a), col="red", cex=0.7)
  }
}
dev.off()
