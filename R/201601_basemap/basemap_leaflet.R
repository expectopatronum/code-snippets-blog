geolandbasemap<-"http://{s}.wien.gv.at/basemap/geolandbasemap/normal/google3857/{z}/{y}/{x}.png"
bmapgrau<-"http://{s}.wien.gv.at/basemap/bmapgrau/normal/google3857/{z}/{y}/{x}.png"
bmapoverlay<-"http://{s}.wien.gv.at/basemap/bmapoverlay/normal/google3857/{z}/{y}/{x}.png"
bmaphidpi<-"http://{s}.wien.gv.at/basemap/bmaphidpi/normal/google3857/{z}/{y}/{x}.jpeg"
bmaportho<-"http://{s}.wien.gv.at/basemap/bmaporthofoto30cm/normal/google3857/{z}/{y}/{x}.jpeg"


# standard

basemap<-leaflet() %>% addTiles(geolandbasemap,
                                options=tileOptions(minZoom=0, subdomains=c("maps","maps1", "maps2", "maps3", "maps4")), 
                                attribution = "www.basemap.at") 

print(basemap)

basemap %>% setView(mean(track_cat$lon), mean(track_cat$lat), zoom = 12) # zoom to the mean location of my cats

# gray
basemap<-leaflet() %>% addTiles(bmapgrau,
                               options=tileOptions(minZoom=0, subdomains=c("maps","maps1", "maps2", "maps3", "maps4")), 
                               attribution = "www.basemap.at")

print(basemap)

# high dpi
basemap<-leaflet() %>% addTiles(bmaphidpi,
                                options=tileOptions(minZoom=0, subdomains=c("maps","maps1", "maps2", "maps3", "maps4")), 
                                attribution = "www.basemap.at")

print(basemap)


# ortho+overlay
basemap<-leaflet() %>% addTiles(bmaportho,
                                options=tileOptions(minZoom=0, subdomains=c("maps","maps1", "maps2", "maps3", "maps4")), 
                                attribution = "www.basemap.at") %>% 
  addTiles(bmapoverlay,
    options=tileOptions(minZoom=0, subdomains=c("maps","maps1", "maps2", "maps3", "maps4")), 
    attribution = "www.basemap.at")

print(basemap)

# openstreetmap

leaflet() %>% addTiles(urlTemplate = "http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", 
                       attribution = NULL, layerId = NULL, group = NULL, options = tileOptions())


#  addWMSTiles("http://www.basemap.at/wmts/1.0.0/WMTSCapabilities.xml", layers="bmapgrau",
#            options = WMSTileOptions(format = "image/png"), attribution = "basemap.at") 
