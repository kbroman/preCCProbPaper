rm(list=ls())
source("onelocusA4.R")

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
function(k)
c("newver"=4*pik(k)[1],
  "notebook"= # notebook 15 , page 43
   4*( (3-sqrt(5))/8 * ((1-sqrt(5))/4)^k * ((15-7*sqrt(5))/(20*sqrt(5))) +
       (3+sqrt(5))/8 * ((1+sqrt(5))/4)^k * ((-15-7*sqrt(5))/(20*sqrt(5))) +
      -(1/4)*(1/4)^k * 1/5 + (1/2)^k*(1/4) + 1/4))

k <- 0:50
dif <- rep(0, length(k))
for(i in seq(along=k))
  dif[i] <- abs(diff(fixation.2ways(k[i])))
max(abs(dif))

fixation.2waysB <-
function(k)
c("newver"=4*pik(k)[1],
  "notebook"= # notebook 15 , page 44
   1 + (1/2)^k - (1/5)*(1/4)^k - ((9-4*sqrt(5))/10)*((1-sqrt(5))/4)^k -
    ((9+4*sqrt(5))/10)*((1+sqrt(5))/4)^k)


k <- 0:50
dif <- rep(0, length(k))
for(i in seq(along=k))
  dif[i] <- abs(diff(fixation.2waysB(k[i])))
max(abs(dif))
