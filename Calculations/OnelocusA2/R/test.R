source("onelocusA2.R")

fixation.2ways <-
function(k)
c("newver"=2*pik(k)[1],
  "notebook"= # notebook 15 , page 44
   1 + (2/5)*(1/4)^k - ((7-3*sqrt(5))/10)*((1-sqrt(5))/4)^k -
    ((7+3*sqrt(5))/10)*((1+sqrt(5))/4)^k)


k <- 0:50
dif <- rep(0, length(k))
for(i in seq(along=k))
  dif[i] <- abs(diff(fixation.2ways(k[i])))
max(abs(dif))
