source(file = "./barma.r")
library(stats)

data_set <- scan("./data.txt")


size_set <- length(data_set)

#Date to combine with dataset
x <- seq(as.Date("1990/01/01"), by = "month", length.out = size_set)
training_date <- x[0:(size_set - 10)]
validation_date <- x[(size_set - 10): size_set]
# Example: [1] "2014-09-04" "2014-09-05" "2014-09-06" "2014-09-07" "2014-09-08"

training_set <- data_set[0:(size_set - 10)]

validation_set <- data_set[(size_set - 10):size_set]

plot(training_set, type = 'l', col = 'blue', lwd = 2, xlab = 'Time', ylab = 'Value')

# ACF - 15 as parameter 
acf(training_set)
#PACF - 3 as parameter
pacf(training_set)

#Gaussian Arma model
gfit <- glm.fit(training_date, training_set, family = gaussian())

#Beta arma model 
barma_model <- barma(ts(training_set, start=c(1990, 1), frequency = 12), ar = c(1,3), ma =c(1,15), h=10, resid=2)

# Getting the residuals
barma_res = barma_model$resid3
gfit_res = resid(gfit)


# Plotting the residuals
plot(barma_res, type='h')
hist(barma_res)

plot(gfit_res, type="l")

# Optimize barma, pretty much lost hope for gaussian since it builds off on the wrong foundation