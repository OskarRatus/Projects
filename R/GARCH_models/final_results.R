#ARMA resids
resids = residuals(final.arima)[-1]
plot(resids, type="l")
acf(resids,main="Residuals of ARIMA Fit")
acf(resids^2,main="Squared Residuals of ARIMA Fit")

Box.test(resid(final.arima), lag=20, type="Ljung-Box")
Box.test(resid(final.arima), lag=10, type="Ljung-Box")
Box.test(resid(final.arima), lag=5, type="Ljung-Box")

Box.test(resid(final.arima)^2, lag=20, type="Ljung-Box")
Box.test(resid(final.arima)^2, lag=10, type="Ljung-Box")
Box.test(resid(final.arima)^2, lag=5, type="Ljung-Box")

#p-value calculation
(1-pnorm(abs(final.arima$coef)/sqrt(diag(final.arima$var.coef))))*2

#GARCH resids
Gresids= residuals(fit)
plot(Gresids)
acf(Gresids, main = "Residuals of ARMA-GARCH fit")
acf(Gresids^2, main = "")

Box.test(residuals(fit)^2, lag=20, type="Ljung-Box")
Box.test(residuals(fit)^2, lag=10, type="Ljung-Box")
Box.test(residuals(fit)^2, lag=5, type="Ljung-Box")

#Plots
plot(data,col="red", main = "Data fit")
plot(fit@fit$residuals)
#ARMA
lines(fitted(final.arima),col="blue")
#GARCH
lines(fit@fit$fitted.values,col="green")

