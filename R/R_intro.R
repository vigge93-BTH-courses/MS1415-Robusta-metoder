dnorm(0)

data_sum <- function(n=10) {
    k <- sample(1:6, size = n, replace = TRUE)
    return(sum(k))
}

x <- 1:24
a <- matrix(1:24, nrow = 4, ncol = 6)
a_3 <- array(1:24, c(3, 4, 2))

x <- rnorm(1000)
mean(x)
var(x)
summary(x)

hist(x)
hist(x, prob = TRUE)
lines(density(x), col = "red")
library(MASS)
truehist(x)

f <- function(x, y) {
    z = (1 / (2 * pi)) * exp(-0.5 * (x ^ 2 + y ^2))
    # z <- rnorm(250000)
}
y <- x <- seq(-3, 3, length = 500)
z <- outer(x, y, f)
persp(x, y, z)
persp(x, y, z, theta = 45, phi = 30, expand = 0.8)
contour(x, y, z)
image(x, y, z)
