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
pd <- copy(csmaps::nor_county_map_b2024_insert_oslo_dt)

q <- ggplot()
q <- q + geom_polygon(
  data = pd, 
  mapping = aes(
    x = long, 
    y = lat,
    group = group,
    fill = location_code
  ),  
  color="black",
  linewidth = 0.2
)
q <- q + annotate(
  "text",
  x = csmaps::nor_xxx_position_title_insert_oslo_b2024_insert_oslo_dt$long,
  y = csmaps::nor_xxx_position_title_insert_oslo_b2024_insert_oslo_dt$lat,
  label = "Oslo"
)
q <- q + theme_void()
q <- q + coord_quickmap()
q <- q + labs(title = "")
q

## ----fig.height=6, fig.width=6, warning=FALSE---------------------------------
pd <- copy(csmaps::nor_county_map_b2024_insert_oslo_dt)

# assign each location a random category for different colors
location_info <- unique(pd[,c("location_code")])
location_info[,category:=rep(
  c("Good","Normal","Neutral","Bad","Very Bad"),
  each=3)[1:.N]
]
location_info[,category:=factor(
  category,
  levels=c("Good","Normal","Neutral","Bad","Very Bad")
  )
]
print(location_info)

# join the map data.table
pd[location_info,on="location_code",category:=category]

q <- ggplot()
q <- q + geom_polygon(
  data = pd, 
  mapping = aes(
    x = long,
    y = lat,
    group = group,
    fill=category
  ), 
  color="black", 
  size=0.25
)
q <- q + annotate(
  "text",
  x = csmaps::nor_xxx_position_title_insert_oslo_b2024_insert_oslo_dt$long,
  y = csmaps::nor_xxx_position_title_insert_oslo_b2024_insert_oslo_dt$lat,
  label = "Oslo"
)
q <- q + coord_quickmap()
q <- q + labs(title="")
q <- q + theme_void()
q

## ----fig.height=6, fig.width=6------------------------------------------------
pd <- copy(csmaps::nor_county_map_b2024_insert_oslo_dt)
q <- ggplot()
q <- q + geom_polygon(
  data = pd, 
  mapping = aes(
    x = long,
    y = lat,
    group = group,
    fill = location_code
  ),  
  color="black",
  linewidth = 0.2
)
q <- q + annotate(
  "text",
  x = csmaps::nor_xxx_position_title_insert_oslo_b2024_insert_oslo_dt$long,
  y = csmaps::nor_xxx_position_title_insert_oslo_b2024_insert_oslo_dt$lat,
  label = "Oslo"
)
q <- q + geom_label(
  data = csmaps::nor_county_position_geolabels_b2024_default_dt,
  mapping = aes(x = long, y = lat, label = location_code)
  )
# ggrepel::geom_label_repel() for avoiding overlap
q <- q + theme_void()
q <- q + coord_quickmap()
q <- q + labs(title = "")
q


## ----fig.height=6, fig.width=6------------------------------------------------
q <- ggplot(mapping = aes(x = long, y = lat))
q <- q + geom_polygon(
  data = csmaps::oslo_ward_map_b2024_default_dt,
  mapping = aes(group = group),
  color = "black",
  fill = "white",
  linewidth = 0.2
)
q <- q + geom_label(
  data = csmaps::oslo_ward_position_geolabels_b2024_default_dt,
  mapping = aes(label = location_code),
  color = "red",
  size = 3,
  label.size = 0.1,
  label.r = grid::unit(0, "lines")
)
q <- q + theme_void()
q <- q + coord_quickmap()
q


## ----fig.height=6, fig.width=6------------------------------------------------
# enrich with population and location name
dpop_2024 <- csdata::nor_population_by_age_cats()[calyear==2024]

# join, create label
labels <- copy(csmaps::nor_county_position_geolabels_b2024_insert_oslo_dt)
labels[
  dpop_2024, 
  on = "location_code",
  pop_total := pop_jan1_n
]
labels[
  csdata::nor_locations_names(), 
  on = "location_code",
  location_name := location_name
]
labels[, label := paste0(location_name, '\n', pop_total)]
print(head(labels))

# plot
pd <- copy(csmaps::nor_county_map_b2024_insert_oslo_dt)
q <- ggplot()
q <- q + geom_polygon(
  data = pd, 
  mapping = aes(
    x = long,
    y = lat,
    group = group,
    fill = location_code
  ),
  color="black",
  linewidth = 0.2
)
q <- q + annotate(
  "text",
  x = csmaps::nor_xxx_position_title_insert_oslo_b2024_insert_oslo_dt$long,
  y = csmaps::nor_xxx_position_title_insert_oslo_b2024_insert_oslo_dt$lat,
  label = "Oslo"
)
q <- q + ggrepel::geom_label_repel(
  data = labels,
  mapping = aes(x = long, y = lat, label = label)
)
q <- q + theme_void()
q <- q + coord_quickmap()
q <- q + labs(title = "")
q


## ----fig.height=6, fig.width=6------------------------------------------------
# enrich with population and location name
dpop_2024 <- csdata::nor_population_by_age_cats()[calyear==2024]

# join, create label
labels <- copy(csmaps::oslo_ward_position_geolabels_b2024_default_dt)
labels[
  dpop_2024, 
  on = "location_code",
  pop_total := pop_jan1_n
]
labels[
  csdata::nor_locations_names(), 
  on = "location_code",
  location_name := location_name
]
labels[, label := paste0(location_name, '\n', pop_total)]
print(head(labels))

q <- ggplot(mapping = aes(x = long, y = lat))
q <- q + geom_polygon(
  data = csmaps::oslo_ward_map_b2024_default_dt,
  mapping = aes(group = group),
  color = "black",
  fill = "white",
  linewidth = 0.2
)
q <- q + geom_label(
  data = labels,
  mapping = aes(label = label),
  color = "red",
  size = 3,
  label.size = 0.1,
  label.r = grid::unit(0, "lines")
)
q <- q + theme_void()
q <- q + coord_quickmap()
q


