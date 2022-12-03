library(forecast)
library(tseries)
library(stats)

source(file = "./barma.r")

data_set <- scan("./data.txt")
size_set <- length(data_set)

#Date to combine with dataset
x <- seq(as.Date("1990/01/01"), by = "month", length.out = size_set)
training_date <- x[0:(size_set - 10)]
validation_date <- x[(size_set - 10): size_set]

training_set <- data_set[0:(size_set - 10)]
validation_set <- data_set[(size_set - 10):size_set]

# Convert to time series object
training_set <- ts(training_set, start = c(1990, 1), frequency = 12)
validation_set_ts <- ts(validation_set, start = c(2004, 1), frequency = 12)

plot(training_set, type = "l", col = "blue", lwd = 2, xlab = "Time", ylab = "Value")

adf.test(training_set) # Not stationary


# ACF - 12 as parameter
acf(training_set)
#PACF - 3 as parameter
pacf(training_set)

# ARIMA
detrended_set <- Arima(training_set, order = c(3, 1, 12))
checkresiduals(detrended_set)
plot(forecast(detrended_set))
lines(validation_set_ts, type="l", col="red")



#Beta arma model
ma_param <- 15
barma_model <- barma(training_set, ar = 1:3, ma = 1:ma_param, h = 11, diag=1)

plot(validation_set, type = "l", col = "red", lwd = 2, xlab = "Time", ylab = "Value")
lines(barma_model$forecast, type="l", col="blue", lwd = 2)

# Plotting the residuals
checkresiduals(barma_model$resid1)
