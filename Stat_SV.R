#source("Lib.R")
library(sf)
library(tidyverse)
library(dplyr)
library(ggplot2)
library(dtwclust)
sv = read.csv('C:\\Users\\miroshnichenko\\Desktop\\R\\Seasonal_variation.csv', header=TRUE, sep=";")
cryptos = read.csv('C:\\Users\\miroshnichenko\\Documents\\Rjourney\\cryptos_price.csv', header=TRUE, sep=",")
(sv <- as_data_frame(sv, key = Well_ID, index = date_part))
sv =sv %>% select("Well_ID", "SV", "date_part")

# Преобразование исходных данных в список с 22 элементами,
# содержащими отдельные временные ряды:
sv_list <- sv %>% 
  mutate(SV = log(SV)) %>% 
  pivot_wider(., names_from = Well_ID, values_from = SV) %>% 
  arrange(date_part) %>% 
  dplyr::select(-date_part) %>% as.list()

# Кластеризация:
hc_4_ward <- tsclust(
  sv,
  k = 4,                 # запрашиваемое число кластеров
  type = "hierarchical", # тип кластеризации
  distance = "dtw",      # мера расстояния
  seed = 42,
  control = 
    hierarchical_control(method = "ward.D2"), # метод агломерации
  args = 
    tsclust_args(dist = list(window.size = 7)) # размер окна Сакэ-Чиба
) 

hc_4_ward 

par(mar = c(0, 4, 2, 2))
plot(hc_4_ward, xlab = "", sub = "", main = "")