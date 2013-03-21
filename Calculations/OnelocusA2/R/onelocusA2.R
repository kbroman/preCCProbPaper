# one autosomal locus, 2-way RIL by sib mating

# no. states
nstates <- c("AAxAA"=2, "AAxAB"=2, "AAxBB"=1, "ABxAB"=1)

# starting distribution
pi0 <- c("AAxAA"=0, "AAxAB"=0, "AAxBB"=1, "ABxAB"=0)

# transition matrix
P <- 
    rbind(
      "AAxAA"=c("AAxAA"=1, "AAxAB"=0, "AAxBB"=0, "ABxAB"=0),
      "AAxAB"=c("AAxAA"=1/4, "AAxAB"=1/2, "AAxBB"=0, "ABxAB"=1/4),
      "AAxBB"=c("AAxAA"=0, "AAxAB"=0, "AAxBB"=0, "ABxAB"=1),
      "ABxAB"=c("AAxAA"=1/8, "AAxAB"=1/2, "AAxBB"=1/8, "ABxAB"=1/4))

# kth generation probabilities
pik <- function(k)
    c(
      "AAxAA"=(1/2) + (1/5)*(1/4)^k - ((7-3*sqrt(5))/20)*((1-sqrt(5))/4)^k - ((7+3*sqrt(5))/20)*((1+sqrt(5))/4)^k,
      "AAxAB"=(-4/5)*(1/4)^k + (2/5)*((1-sqrt(5))/4)^k + (2/5)*((1+sqrt(5))/4)^k,
      "AAxBB"=(2/5)*(1/4)^k + ((3+sqrt(5))/10)*((1-sqrt(5))/4)^k + ((3-sqrt(5))/10)*((1+sqrt(5))/4)^k,
      "ABxAB"=(4/5)*(1/4)^k - ((2 + 2*sqrt(5))/5)*((1-sqrt(5))/4)^k - ((2-2*sqrt(5))/5)*((1+sqrt(5))/4)^k)

