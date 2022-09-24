source("Lib.R")
options(scipen = 999)

reg_sf = st_read('data/KirovUTF8.shx')
## Reading layer `Kirov' from data source `/Users/tsamsonov/GitHub/r-geo-course/data/Kirov.gpkg' using driver `GPKG'
## Simple feature collection with 40 features and 20 fields
## geometry type:  POLYGON
## dimension:      XY
## bbox:           xmin: -216808.3 ymin: 2896149 xmax: 227259 ymax: 3455774
## projected CRS:  unnamed
reg = st_geometry(reg_sf)

coords = reg %>% 
  st_centroid() %>% 
  st_coordinates()

par(mar = c(1,1,1,1))
knn = knearneigh(coords, k = 1)

plot(reg, border = "grey70")
plot(knn, coords, pch = 19, cex = 0.5, add = TRUE)
title(main = paste("Ближайшие соседи (k = ", 3, ")", sep = ''))
