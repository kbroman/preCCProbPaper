rm(list=ls())
source("selfing.R")

r <- seq(0, 0.5, len=51)
k <- 1:25

maxdif0 <- rep(NA, length(r))
for(i in seq(along=r))
  maxdif0[i] <- max(abs(pi0 - nstates*pik(r[i], 1)))
max(maxdif0)

maxdif <- matrix(nrow=length(r), ncol=length(k))
for(i in seq(along=r)) {
  curpi <- pi0
  for(j in k) {
    curpi <- curpi %*% P(r[i])
    maxdif[i,j] <- max(abs(curpi - nstates*pik(r[i], j+1)))
  }
}
max(maxdif)

piinf <- function(r) c(1/(1+2*r), 2*r/(1+2*r), 0, 0, 0)
r <- seq(0, 0.5, len=51)
maxldif <- rep(NA, length(r))
for(i in seq(along=r))
  maxldif[i] <- max(abs(nstates*pik(r[i], 201) - piinf(r[i])))
max(maxldif)

handw <-
function(x, n, p)
{
  if(missing(p)) p <- x^2
  c("AA|AA" = (1 - (1/2 - x)^n)/(1+2*x) + 1/2*(1/2 - x + p)^(n-1) - (1/2)^(n-1),
    "AB|AB" = (2*x + (1/2 - x)^n)/(1+2*x) + 1/2*(1/2 - x + p)^(n-1) - (1/2)^(n-1))
}

r <- seq(0, 0.5, len=101)
k <- 1:50
res2 <- res1 <- array(dim=c(2, length(r), length(k)))
for(i in seq(along=r)) {
  for(j in seq(along=k)) {
    res1[,i,j] <- pik(r[i], k[j])[1:2]
    res2[,i,j] <- handw(r[i], k[j])/2
  }
}

