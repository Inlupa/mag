source("Lib.R")
# Loading example data from airGR package
data(L0123001, package = 'airGR')
# Defining BasinData object
Name <- BasinInfo$BasinName
startDate <- BasinObs$DatesR[1]
endDate <- BasinObs$DatesR[length(BasinObs$DatesR)]
P <- BasinObs$P
PET <- BasinObs$E
Qobs <- BasinObs$Qmm
BasinData_Example <- BasinData(Name, startDate, endDate, P, PET, Qobs, fill = "GR4J")
# Creating BaseflowFilter object
BaseflowFilter_Example <- BaseflowFilter(BasinData_Example, 1000, updateFunction = 'quadr')
# Computing baseflow
BaseflowFilter_Example <- perform_filtering(BaseflowFilter_Example)
# Plotting computed separation
plot(BaseflowFilter_Example)
BaseflowFilter_Example = as.data.frame(BaseflowFilter_Example)

