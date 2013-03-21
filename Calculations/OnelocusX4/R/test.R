rm(list=ls())
source("onelocusX4.R")

k <- 1:25

maxdif0 <- max(abs(pi0 - nstates*pik(0)))
max(maxdif0)

maxdif <- rep(0, length(k))
curpi <- pi0
for(j in k) {
  curpi <- curpi %*% P
  maxdif[j] <- max(abs(curpi - nstates*pik(j)))
}
max(maxdif)


fixation.2ways <-
function(k) {
  temp <- pik(k)
c("newver"=2*temp[1]+temp[10],
  "notebook"= # notebook 15 , page 70
   1 + (1/2)*(1/2)^k + ((-15+7*sqrt(5))/20)*((1-sqrt(5))/4)^k +
    ((-15-7*sqrt(5))/20)*((1+sqrt(5))/4)^k)
}

k <- 0:50
dif <- rep(0, length(k))
for(i in seq(along=k))
  dif[i] <- abs(diff(fixation.2ways(k[i])))
max(abs(dif))
