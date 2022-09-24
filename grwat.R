
source("Lib.R")
library(grwat)
library(ggplot2)
library(dplyr)
library(tidyr)
library(lubridate)

mapviewOptions(fgb = FALSE)

path = system.file("extdata", "spas-zagorye.txt", package = "grwat")

hdata_raw = read_delim(path, 
                       col_names = c('d', 'm', 'y', 'q'), 
                       col_types = 'iiid', delim = ' ') 
hdata = hdata_raw %>% 
  transmute(Date = lubridate::make_date(y, m, d), 
            Q = q)
gaps = gr_get_gaps(hdata)
gr_plot_acf(hdata)
hdata = hdata_raw %>% 
  transmute(Date = lubridate::make_date(y, m, d), 
            Q = q)
gaps = gr_get_gaps(hdata)
fhdata = gr_fill_gaps(hdata, nobserv = 10)
path = system.file("extdata", "spas-zagorye.gpkg", package = "grwat")
basin = st_read(path, layer = 'basin') # read basin region
gauge = st_read(path, layer = 'gauge') # read gauge point
mapview(basin) + mapview(gauge)
rean = gr_read_rean('/Volumes/Data/Spatial/Reanalysis/grwat/pre_1880-2021.nc',
                    '/Volumes/Data/Spatial/Reanalysis/grwat/temp_1880-2021.nc') # read reanalysis data
fhdata_rean = gr_join_rean(fhdata, rean, basin_buffer) # join reanalysis data to hydrological series
head(fhdata_rean)
resbase = fhdata %>% 
  mutate(Qbase = gr_baseflow(Q, method = 'lynehollick'))
resbase %>% 
  filter(lubridate::year(Date) == 2020) %>% 
  ggplot() +
  geom_area(aes(Date, Q), fill = 'steelblue', color = 'black') +
  geom_area(aes(Date, Qbase), fill = 'orangered', color = 'black')

