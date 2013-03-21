# two loci, 2-way RIL by selfing 

# no. states
nstates <- c("AA|AA"=2, "AB|AB"=2, "AA|AB"=4, "AA|BB"=1, "AB|BA"=1)

# starting distribution
pi0 <- c("AA|AA"=0, "AB|AB"=0, "AA|AB"=0, "AA|BB"=1, "AB|BA"=0)

# transition matrix
P <- function(r)
    rbind(
      "AA|AA"=c("AA|AA"=1, "AB|AB"=0, "AA|AB"=0, "AA|BB"=0, "AB|BA"=0),
      "AB|AB"=c("AA|AA"=0, "AB|AB"=1, "AA|AB"=0, "AA|BB"=0, "AB|BA"=0),
      "AA|AB"=c("AA|AA"=1/4, "AB|AB"=1/4, "AA|AB"=1/2, "AA|BB"=0, "AB|BA"=0),
      "AA|BB"=c("AA|AA"=(1-r)^2/2, "AB|AB"=r^2/2, "AA|AB"=2*r*(1-r), "AA|BB"=(1-r)^2/2, "AB|BA"=r^2/2),
      "AB|BA"=c("AA|AA"=r^2/2, "AB|AB"=(1-r)^2/2, "AA|AB"=2*r*(1-r), "AA|BB"=r^2/2, "AB|BA"=(1-r)^2/2))

# kth generation probabilities
pik <- function(r, k)
    c(
      "AA|AA"=((1)/(2*(1+2*r))) - (((1)/(2)))^(k+1) * (2 - (1-2*r+2*r^2)^(k-1) + (((1-2*r)^k)/(1+2*r)) ),
      "AB|AB"=((r)/(1+2*r)) - (((1)/(2)))^(k+1) * (2 - (1-2*r+2*r^2)^(k-1) - (((1-2*r)^k)/(1+2*r)) ),
      "AA|AB"=(((1)/(2)))^k * ( 1 - (1-2*r+2*r^2)^(k-1) ),
      "AA|BB"=(((1)/(2)))^k * ( (1 - 2*r + 2*r^2)^(k-1) + (1-2*r)^(k-1) ),
      "AB|BA"=(((1)/(2)))^k * ( (1 - 2*r + 2*r^2)^(k-1) - (1-2*r)^(k-1) ))

