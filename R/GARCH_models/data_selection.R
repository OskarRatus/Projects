library(tseries)
library(forecast)
library(timeSeries)
library(xts)
library(rugarch)
library(quantmod)
library(dvmisc)
library(seewave)
library(lmtest)
library(readxl)

data_raw <- read_excel("C:/Users/Oskar/Desktop/Dane do modelu.xlsx")
#sdata = msts(data_raw[,2],seasonal.periods = c(365),start = 1)
sdata = ts(data_raw[,2],start = 1,frequency = 7)
plot(sdata, ylab="Electricity spot price",xlab="Obervations")
hist(sdata, main = "")

################
#CORELOGRAMS
acf(log(sdata),lag.max = 100, main = "ACF")
pacf(sdata, lag.max = 100, main = "PACF")

acf(sdata, main = "ACF")
pacf(sdata, main = "PACF")

##################
#OUTLAYER'S
sdata = tsclean(sdata)
plot(sdata)

###############
#STATIONARITY
data = diff(log(sdata),7)
data.all = ts(data = data,start = 1)
plot(data.all)

train.data = window(data.all, end = (length(data.all)-30))
test.data = window(data.all, start = (length(data.all)-30)+1)
#, end = (length(data.all)-30+7)


acf(data)
pacf(data)

test = diff()

hist(data)
lines(dnorm())

