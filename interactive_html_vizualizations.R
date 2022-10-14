## PART 3. INTERACTIVE DATA VISUALIZATIONS

# htmlwidgets were developed by RStudio to allow you to build rich, interactive data visualizations, ready to deploy on the web. You may publish them to the web with RPubs, RMarkdown, or Shiny (we will explore these options later in the semester).

# Install and load each of the htmlwidgets packages (Most available on CRAN) highcharter, leaflet, plotly, DT,sf, geojsonio, gapminder.
install.packages('highcharter')
install.packages('leaflet')
install.packages('plotly')
install.packages('DT')
install.packages('sf')

library(highcharter)#  Makes Interactive Charts
library(leaflet) # Makes Interactive Maps
library(plotly) # Makes Java Script Visualizations
library(DT) # Makes Interactive Tables
library(sf) # Makes simple features

###### DELIVERABLE 30: INSTALL AND LOAD oidnChaRts from GITHUB
# Install and load oidnChaRts from github (rather than CRAN). This package allows you to visualize how a specific htmlwidget library will plot/display your data. It also comes with several built in datasets for plotting. package allows you to visualize how a specific htmlwidget library will plot/display your data.
remotes::install_github("martinjhnhadley/oidnChaRts")
library(oidnChaRts)

###### DELIVERABLE 31: CREATE AND VIEW THE DATA WE WILL PLOT
data_to_plot <- data_stacked_bar_chart %>%
  group_by(country_group, occupation) %>%
  summarise(total = sum(count)) %>%
  ungroup()

data_to_plot %>%
  view()

###### DELIVERABLE 32: VIEW DATA IN HIGHCHARTER 
# Let's start by viewing our data in the highcharter package.
library(highcharter)
data_to_plot %>%
  stacked_bar_chart(
    library = "highcharter",
    categories.column = ~ country_group,
    subcategories.column = ~ occupation,
    value.column = ~ total
  )

###### DELIVERABLE 33: VIEW DATA IN PLOTLY 
# Let's start by viewing our data in the plotly package.
library(plotly)
data_to_plot %>%
  stacked_bar_chart(
    library = "plotly",
    categories.column = ~ country_group,
    subcategories.column = ~ occupation,
    value.column = ~ total
  ) %>%
  layout(margin = list(l = 150),
         yaxis = list(title = ""))

## Scatter Geo Markers
data_geo_marker_plot %>%
  leaflet() %>%
  addTiles() %>%
  addMarkers(label = ~city)

## Scatter Geo Plots
data_geo_marker_plot %>%
  leaflet() %>%
  addTiles() %>%
  addCircleMarkers(radius = ~count/8,
                   label = ~city)

## Clustered Scatter Geo Plots
data_geo_marker_plot %>%
  leaflet() %>%
  addTiles() %>%
  addCircleMarkers(radius = ~count/8,
                   label = ~city,
                   clusterOptions = markerClusterOptions())


###### DELIVERABLE 37: READ IN SHAPEFILES AND VIEW IN CLOROPLETH MAP 
## Choropleth - These maps are particularly valuable, but require a few additional steps. A choroplet map has defined regions, which are shaded according to a variable in your data. NB: Note, as you move your cursor over the map, you are provided data for the specific variable in that region; and the legend at the bottom changes to indicate the
# One of the biggest challenges to creating a Choropleth map is finding the "shape files" required for Highcharter (you must provide these, they are not included in Highcharter) and then converting them to the geoJSON format required by Highcharter.
# To read shapefiles in both esri and json formats
esri_shapefile <- read_sf("data/world-shape-files/")
geojson_shapefile <- read_sf("data/world-geojson.json")
shp_as_sf <- read_sf("data/world-shape-files/")
converted_geojson <- geojson_list(shp_as_sf)
gapminder_most_recent <- gapminder %>%
  filter(year == max(year))
highchart(type = "map") %>%
  hc_add_series_map(map = converted_geojson,
                    df = gapminder_most_recent,
                    value = "pop",
                    joinBy = c("name_long", "country")) %>%
  hc_title(text = "Population Choropleth for 2007 (Source: Gapminder)")

