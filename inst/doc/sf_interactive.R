## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(ggplot2)
library(data.table)
library(magrittr)

## ----fig.height=6, fig.width=6------------------------------------------------
pd_county <- csmaps::nor_county_map_b2024_default_sf
leaflet::leaflet(
  pd_county,
  options = leaflet::leafletOptions(preferCanvas = F)
) %>%
  leaflet::addProviderTiles(leaflet::providers$Esri.WorldGrayCanvas) %>%
  leaflet::addPolygons(
    weight = 0.3,
    opacity = 1,
    color = "black", 
    fillColor = "white",
    fillOpacity = 0.9
  )

