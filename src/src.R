url <- "http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist.zip"
download.file(url, "eurofxref-hist.zip")
rates <- read.csv(unz("eurofxref-hist.zip", "eurofxref-hist.csv"), header = T)
str(rates$Date)
rates$Date <- as.Date(rates$Date, "%Y-%m-%d")
str(rates$Date)
range(rates$Date)
rates <- rates[order(rates$Date), ]
plot(rates$Date, rates$USD, type = "l")
#plot(rates$Date, rates$INR, type = "l")
head(rates$Date, 20)
years <- format(rates$Date, "%Y")
tab <- table(years)
tab
mean(tab[1:(length(tab) - 1)])
source('forecast.R')
result.arima <- forecastArima(rates, n.ahead = 90)
source("plotForecastResult.R")
plotForecastResult(result.arima, title = "Exchange rate forecasting with ARIMA")
result.stl <- forecastStl(rates, n.ahead = 90)
plotForecastResult(result.stl, title = "Exchange rate forecasting with STL")
## exchange rate in 2014
result <- subset(result.stl, date >= "2014-01-01")
plotForecastResult(result, title = "Exchange rate forecasting with STL (2014)")
