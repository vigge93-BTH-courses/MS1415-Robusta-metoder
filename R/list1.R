library("Rfast")
beta_mle <- function(data) {
    beta.mle(data);
}

x <- rbeta(1000000, 1, 4);
print(beta_mle(x));