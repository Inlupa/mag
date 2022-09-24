source("Lib.R")

#data_in = read.csv("E:\\Магистерская\\Данные\\Zhusha-Mcesk-20210405T202209Z-001\\Zhusha-Mcesk\\in.csv", header=FALSE,  sep=";")

#загрузка данных с диска 
data_grwat = read.csv("E:\\Магистерская\\Данные\\Zhusha-Mcesk-20210405T202209Z-001\\Zhusha-Mcesk\\AllGrWat.csv", header=TRUE,  sep=";")
# определение кол-ва измерений из всего списка(если нужно)
data_grwat = data_grwat[1:1000,]


#определение начальной и конечной даты рассмаририваемых данных
startDate <- data_grwat$Date[1]
endDate <- data_grwat$Date[length(data_grwat$Date)]

#переопределение даты в формаь POSIXct    
startDate = as.POSIXct(startDate, format="%d.%m.%Y")
endDate = as.POSIXct(endDate , format="%d.%m.%Y")

#создание векроров данных
#сосредоточенные осадки
P = data_grwat$Pin
#эвапотрансперация
PET = rep(1, 1000)
#дневной сток
Qobs =  data_grwat$Qin

#расчетные функции для определения бассейнов 
BasinData_in <- BasinData("input", startDate, endDate, P, PET, Qobs, fill = "GR4J")
BaseflowFilter_Example <- BaseflowFilter(BasinData_in, 1000, updateFunction = 'quadr')

#Расчет подземного стока
BaseflowFilter_Example <- perform_filtering(BaseflowFilter_Example)

# Построение графика и сохранение данных в дата-фрейм
plot(BaseflowFilter_Example)
BaseflowFilter_Example = as.data.frame(BaseflowFilter_Example)
