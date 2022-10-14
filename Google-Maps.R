## PART 2. PLOTTING DATA ON MAPS

# Now let's look at data visualization on maps. If you would like to do this part of the lab on your own, you will need to acquire a Google Maps API key from Google. Google Maps will provide the base on which we will build our map visualizations. This procedure has changed and has become a little complicated. It now requires a credit card for payment, although at the level with which we will be accessing the API it remains functionally free. 

# Here is how to obtain your Google API key (which is free for our use).

# Visit: http://console.developers.google.com/apis/dashboard

#You must log into your Google account if you are not already logged in; then accept the terms (if you wish), and click the create project button. NB: This is where you will need to enable a billing plan for the project, or you will receive error messages later.

# devtools::install_github("dkahle/ggmap", force = TRUE)

# Now install ggmap and load the libraries

# install.packages("ggmap")

library(tidyverse)
library(ggmap) # - gives you the ability to plot maps in ggplot

# Now register your Google API with RStudio (the one below is fake)

register_google(key = "ThisIsMySecretGoogleAPISoIwillNotShareit")


## Basic Map Functions

qmap(location) # plots a quick map
get_map(location) # retrieves map data for a location
ggmap(location) # plots a stored map

# Let's make sure our API is loaded properly by first asking Google for a basic quick map of New York City by calling the qmap() function and providing a location argument.
qmap("New York, NY")

# We can adjust the scale of the map by adding a zoom= argument. You may play with the zoom level; larger number zoom in; smaller numbers zoom out (e.g. 7 would be all the east coast)
qmap("New York, NY", zoom=15)
qmap("New York, NY", zoom=7)


# Now, you may create a map object called nyc_map to use later. We do this by using the get_map() function.
nyc_map <- get_map("New York, NY", zoom=10)


# We can now plot that map (it will look the mostly same as our initial q map)
ggmap(nyc_map)


# Now, let's do some geocoding. The geocode(location) function, performs geocoding using the Google Maps API, and returns latitude and longitude for that location.
nyc <- geocode("New York, NY")
whitehouse <- geocode("White House")



# Notice the objects “nyc” and “whitehouse” were created.


# We can wrap functions
ggmap(get_map(whitehouse))



# Another way to pull up maps
whitehousemap <- ggmap(get_map(whitehouse, zoom=18))
whitehousemap


# Now, let's work with map types. Previously, we’ve only accessed the default terrain map. However, ggmaps has many options (e.g. terrain, terrain-labels, terrain-lines, roadmap, satellite, hybrid, toner, toner-lite, toner-background, watercolor). Try out these different types of maps.

ggmap(get_map(nyc, maptype = "terrain"))
ggmap(get_map(nyc, maptype = "roadmap"))
ggmap(get_map(nyc, maptype = "terrain-lines"))
ggmap(get_map(nyc, maptype = "satellite"))
ggmap(get_map(nyc, maptype = "hybrid"))
ggmap(get_map(nyc, maptype = "toner-lite"))
ggmap(get_map(nyc, maptype = "watercolor"))

# Now, lets combine the skills of pulling up maps, and geocoding, let's start plotting maps.

# First, let's geocode some locations
nyc <- geocode("New York, NY")
usa <- geocode("United States")


# Now, let's plot a map (ggmaps is similiar to ggplot)
ggmap(get_map(usa, zoom = 4)) +
  geom_point(mapping = aes(x=lon, y=lat), color="red", data=nyc)



# Let's now plot more than one datapoint
placenames <- c("New York, NY", "White House", "Mt. Rushmore", "The Alamo")
locations <- geocode(placenames)
places <- tibble(name=placenames, lat=locations$lat, lon=locations$lon)



# Now, rerun the plot, with data = places
ggmap(get_map(usa, zoom = 4)) +
  geom_point(mapping = aes(x=lon, y=lat), color="red", data=places)



# Now, we will add labels
ggmap(get_map(usa, zoom = 4)) +
  geom_point(mapping = aes(x=lon, y=lat), color="red", data=places) +
  geom_text(mapping=aes(x=lon, y=lat, label=name), color="red", data=places)



# Now, let's "nudge" the labels above the points slightly with the nudge

ggmap(get_map(usa, zoom = 4)) +
  geom_point(mapping = aes(x=lon, y=lat), color="red", data=places) +
  geom_text(mapping=aes(x=lon, y=lat, label=name), color="red", data=places, nudge_y = 1)


# Now, let's make it clearer to read by changing the map type from the default terrain map to the toner-background.
ggmap(get_map(usa, zoom = 4, maptype = "toner-background")) +
  geom_point(mapping = aes(x=lon, y=lat), color="red", data=places) +
  geom_text(mapping=aes(x=lon, y=lat, label=name), color="red", data=places, nudge_y = 1)



# and Watercolor

ggmap(get_map(usa, zoom = 4, maptype = "watercolor")) +
  geom_point(mapping = aes(x=lon, y=lat), color="red", data=places) +
  geom_text(mapping=aes(x=lon, y=lat, label=name), color="red", data=places, nudge_y = 2)
