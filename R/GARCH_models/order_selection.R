#ARMA order fit

final.aic = Inf
final.order = c(0,0,0)
for (p in 1:6) for (d in 0:1) for (q in 1:6) {
  current.aic = AIC(arima(data, order=c(p, d, q)))
  print(c(p,d,q))
  print(current.aic)
  if (current.aic < final.aic) {
    final.aic = current.aic
    final.order = c(p, d, q)
    final.arima = arima(data, order=final.order)
  }
}

#GARCH order fit
final.bic = Inf
final.order = c(0,0)
for (p in 1:3) for (q in 1:3){
  spec = ugarchspec(variance.model=list(garchOrder=c(p,q)),
                    mean.model=list(armaOrder=c(final.order[1],final.order[2]), include.mean=T),
                    distribution.model="std")    
  fit = ugarchfit(spec, data, solver = 'hybrid')
  current.bic = infocriteria(fit)[2] 
  if (current.bic < final.bic) {
    final.bic = current.bic
    final.order = c(p, q)
  }
}

## Refine the ARMA order
final.bic = Inf
final.order.arma = c(0,0)
for (p in 0:6) for (q in 0:6){
  spec = ugarchspec(variance.model=list(garchOrder=c(final.order[1],final.order[2])),
                    mean.model=list(armaOrder=c(p, q), include.mean=T),
                    distribution.model="std")    
  fit = ugarchfit(spec, data, solver = 'hybrid')
  current.bic = infocriteria(fit)[2] 
  if (current.bic < final.bic) {
    final.bic = current.bic
    final.order.arma = c(p, q)
  }
}


## Refine the GARCH order
final.bic = Inf
final.order.garch = c(0,0)
for (p in 1:3) for (q in 1:3){
  spec = ugarchspec(variance.model=list(garchOrder=c(p,q)),
                    mean.model=list(armaOrder=c(final.order.arma[1], final.order.arma[2]), 
                                    include.mean=T), distribution.model="std")    
  fit = ugarchfit(spec, data, solver = 'hybrid')
  current.bic = infocriteria(fit)[2] 
  if (current.bic < final.bic) {
    final.bic = current.bic
    final.order.garch = c(p, q)
  }
}

