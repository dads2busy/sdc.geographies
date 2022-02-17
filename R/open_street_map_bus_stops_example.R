library(osmdata)
library(sf)
library(ggplot2)
library(ggmap)

#building the query
#set the bounding box to Arlington
#add bus stops (which is a tag "bus_stop" of the feature "highway")
q <- getbb("Arlington County, Virginia") %>%
  opq() %>%
  add_osm_feature("highway", "bus_stop")

str(q) #look query structure

#get the data
bus_stops <- osmdata_sf(q)
bus_stops

#get a background map
arl_map <- get_map(getbb("Arlington County, Virginia"), maptype = "toner-background")

#create final map
ggmap(arl_map)+
  geom_sf(data = bus_stops$osm_points,
          inherit.aes = FALSE,
          colour = "#238443",
          fill = "#004529",
          alpha = .5,
          size = 4,
          shape = 21)+
  labs(x = "", y = "")
