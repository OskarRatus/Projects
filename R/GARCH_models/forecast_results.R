n.valid = 7
n.train = length(data) - n.valid


train.data = window(data, end = n.train)
valid.data = window(data, start = n.train+1, frequency = 7)


#ARMA fit
#order c(3,0,7)
  final.arima = arima(train.data, order=c(3,0,7))
  #forecast
  fore.arima=forecast(final.arima, h = 30)
  
  plot(fore.arima, include = 100, main="", ylab="Returns", xlab = "Observations")
  lines(test.data)
  plot(fore.arima$mean)
  
  accuracy(fore.arima, valid.data)



#ARMA-GARCH fit
#order (3,7)-(1,1)
  spec = ugarchspec(variance.model=list(garchOrder=c(1,1)),
                    mean.model=list(armaOrder=c(3, 7), include.mean=T),
                    distribution.model="std")    
  fit = ugarchfit(spec, train.data, solver = 'hybrid')
  #forecast
  fore.garch = ugarchforecast(fit,train.data,n.ahead = 30)
  
  plot(fore.garch)
  lines(valid.data)
  plot(fore.garch@forecast[["seriesFor"]],type="l")

plot(train.data+fore.garch@forecast[["seriesFor"]])

  accuracy(fore.garch@forecast$seriesFor)

#naive
  naive = snaive(ts(train.data,frequency = 7),h=30, drift = TRUE)
  plot(naive,include=100, main="", ylab = "Returns", xlab = "Observations")
  valid.data = ts(data.all, frequency = 7)
  valid.data = window(valid.data, start = c(204,4), end = c(208,5))
  lines(valid.data)
  
  accuracy(naive, valid.data)



#fore day-ahead
fore.garch = ugarchforecast(fit,window(data,end=1453),n.ahead = 7)
fore.arima = forecast(final.arima,h=7)




#Errors
real.value = test.data

#GARCH
pred.value = fore.garch@forecast[["seriesFor"]]
#ARMA
pred.value = as.numeric(fore.arima$mean)
#Naive
pred.value = naive$mean
real.value = valid.data

################
pred.value = as.numeric(fit@fit$fitted.values)
###################

#MSE
MSE = mean((real.value - pred.value)^2)

#MAE
MAE = mean(abs(real.value - pred.value))
MAE
#MAPE
MAPE = mean(abs(real.value - pred.value)/real.value)

#RMSE
RMSE = (MSE)^(1/2)

err.garch = c(MSE,MAE,MAPE,RMSE)
err.arima = c(MSE,MAE,MAPE,RMSE)
err.naive = c(MSE,MAE,MAPE,RMSE)
