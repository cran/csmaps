## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(csmaps)
library(ggplot2)
library(data.table)
library(magrittr)

## ----fig.height=6, fig.width=6------------------------------------------------
pd <- copy(csmaps::nor_municip_map_b2024_default_dt)
q <- ggplot()
q <- q + geom_polygon(data = pd, aes( x = long, y = lat, group = group), 
                      color="black", fill="white", linewidth = 0.2)
q <- q + theme_void()
q <- q + coord_quickmap()
q <- q + labs(title = "Default layout")
q

## ----fig.height=6, fig.width=6------------------------------------------------
pd <- copy(csmaps::nor_municip_map_b2024_split_dt)
q <- ggplot()
q <- q + geom_polygon(data = pd, aes( x = long, y = lat, group = group), 
                      color="black", fill="white", linewidth = 0.2)
q <- q + theme_void()
q <- q + coord_quickmap()
q <- q + labs(title = "Split layout")
q

## ----fig.height=6, fig.width=6------------------------------------------------
pd <- copy(csmaps::nor_municip_map_b2024_insert_oslo_dt)
q <- ggplot()
q <- q + geom_polygon(data = pd, aes( x = long, y = lat, group = group), 
                      color="black", fill="white", linewidth = 0.2)

# add title "Oslo"
q <- q + annotate(
  "text", 
  x = csmaps::nor_xxx_position_title_insert_oslo_b2024_insert_oslo_dt$long, 
  y = csmaps::nor_xxx_position_title_insert_oslo_b2024_insert_oslo_dt$lat,
  label = "Oslo"
  )
q <- q + theme_void()
q <- q + coord_quickmap()
q <- q + labs(title = "Insert Oslo layout")
q

## ----fig.height=6, fig.width=6------------------------------------------------
pd <- copy(csmaps::oslo_ward_map_b2024_default_dt)
q <- ggplot()
q <- q + geom_polygon(data = pd, aes(x = long, y = lat, group = group), 
                      color="black", fill="white", linewidth = 0.2)
q <- q + theme_void()
q <- q + coord_quickmap()
q <- q + labs(title = "Oslo wards")
q

