vmodel = fore.garch@model$modeldesc$vmodel
# 1. Time Series:
nr = fore.garch@forecast$n.roll

n = fore.garch@forecast$n.ahead
N = fore.garch@forecast$N - fore.garch@forecast$n.start
forseries = fore.garch@forecast$seriesFor[,0+1]
forsigma = fore.garch@forecast$sigmaFor[,0+1]
xdates = fore.garch@model$modeldata$index[(N+0-min(N,100)):(N+0)]
fdates = seq(tail(xdates,1), by = fore.garch@model$modeldata$period, length.out = n+1)[-1]
series = fore.garch@model$modeldata$data[(N+0-min(N,100)):(N+0)]

xforseries = c(series, forseries)
series = c(series, rep(NA, n))
ylim=c(0.95*min(xforseries,na.rm=TRUE), 1.05*max(xforseries,na.rm=TRUE))

  plot(c(xdates, fdates), as.numeric(xforseries), type="l", col="black",
       ylab="Returns",xlab="Observations")
  abline(h = 0, col = "grey", lty = 3)
  Zup = forseries+1*forsigma
  Zdn = forseries-1*forsigma
  for(i in 2:n) rect(fdates[i-1], Zdn[i-1], fdates[i], Zup[i], col = "#b1b5ce", border=NA)

lines(c(xdates, fdates), series, col="black")
lines(fdates, forseries, col="blue", lwd = 2)
lines(fdates, valid.data, col = "black")

