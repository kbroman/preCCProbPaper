# one autosomal locus, 4-way RIL by sib mating

# no. states
nstates <- c("AAxAA"=4, "AAxAB"=4, "AAxAC"=8, "AAxBB"=2, "AAxBC"=8, "AAxCC"=4, "AAxCD"=4, "ABxAB"=2, "ABxAC"=8, "ABxCD"=1, "ACxAC"=4, "ACxAD"=4, "ACxBD"=2)

# starting distribution
pi0 <- c("AAxAA"=0, "AAxAB"=0, "AAxAC"=0, "AAxBB"=0, "AAxBC"=0, "AAxCC"=0, "AAxCD"=0, "ABxAB"=0, "ABxAC"=0, "ABxCD"=1, "ACxAC"=0, "ACxAD"=0, "ACxBD"=0)

# transition matrix
P <- 
    rbind(
      "AAxAA"=c("AAxAA"=1, "AAxAB"=0, "AAxAC"=0, "AAxBB"=0, "AAxBC"=0, "AAxCC"=0, "AAxCD"=0, "ABxAB"=0, "ABxAC"=0, "ABxCD"=0, "ACxAC"=0, "ACxAD"=0, "ACxBD"=0),
      "AAxAB"=c("AAxAA"=1/4, "AAxAB"=1/2, "AAxAC"=0, "AAxBB"=0, "AAxBC"=0, "AAxCC"=0, "AAxCD"=0, "ABxAB"=1/4, "ABxAC"=0, "ABxCD"=0, "ACxAC"=0, "ACxAD"=0, "ACxBD"=0),
      "AAxAC"=c("AAxAA"=1/4, "AAxAB"=0, "AAxAC"=1/2, "AAxBB"=0, "AAxBC"=0, "AAxCC"=0, "AAxCD"=0, "ABxAB"=0, "ABxAC"=0, "ABxCD"=0, "ACxAC"=1/4, "ACxAD"=0, "ACxBD"=0),
      "AAxBB"=c("AAxAA"=0, "AAxAB"=0, "AAxAC"=0, "AAxBB"=0, "AAxBC"=0, "AAxCC"=0, "AAxCD"=0, "ABxAB"=1, "ABxAC"=0, "ABxCD"=0, "ACxAC"=0, "ACxAD"=0, "ACxBD"=0),
      "AAxBC"=c("AAxAA"=0, "AAxAB"=0, "AAxAC"=0, "AAxBB"=0, "AAxBC"=0, "AAxCC"=0, "AAxCD"=0, "ABxAB"=1/4, "ABxAC"=1/2, "ABxCD"=0, "ACxAC"=1/4, "ACxAD"=0, "ACxBD"=0),
      "AAxCC"=c("AAxAA"=0, "AAxAB"=0, "AAxAC"=0, "AAxBB"=0, "AAxBC"=0, "AAxCC"=0, "AAxCD"=0, "ABxAB"=0, "ABxAC"=0, "ABxCD"=0, "ACxAC"=1, "ACxAD"=0, "ACxBD"=0),
      "AAxCD"=c("AAxAA"=0, "AAxAB"=0, "AAxAC"=0, "AAxBB"=0, "AAxBC"=0, "AAxCC"=0, "AAxCD"=0, "ABxAB"=0, "ABxAC"=0, "ABxCD"=0, "ACxAC"=1/2, "ACxAD"=1/2, "ACxBD"=0),
      "ABxAB"=c("AAxAA"=1/8, "AAxAB"=1/2, "AAxAC"=0, "AAxBB"=1/8, "AAxBC"=0, "AAxCC"=0, "AAxCD"=0, "ABxAB"=1/4, "ABxAC"=0, "ABxCD"=0, "ACxAC"=0, "ACxAD"=0, "ACxBD"=0),
      "ABxAC"=c("AAxAA"=1/16, "AAxAB"=1/8, "AAxAC"=1/8, "AAxBB"=0, "AAxBC"=1/8, "AAxCC"=0, "AAxCD"=0, "ABxAB"=1/16, "ABxAC"=1/4, "ABxCD"=0, "ACxAC"=1/8, "ACxAD"=1/8, "ACxBD"=0),
      "ABxCD"=c("AAxAA"=0, "AAxAB"=0, "AAxAC"=0, "AAxBB"=0, "AAxBC"=0, "AAxCC"=0, "AAxCD"=0, "ABxAB"=0, "ABxAC"=0, "ABxCD"=0, "ACxAC"=1/4, "ACxAD"=1/2, "ACxBD"=1/4),
      "ACxAC"=c("AAxAA"=1/8, "AAxAB"=0, "AAxAC"=1/2, "AAxBB"=0, "AAxBC"=0, "AAxCC"=1/8, "AAxCD"=0, "ABxAB"=0, "ABxAC"=0, "ABxCD"=0, "ACxAC"=1/4, "ACxAD"=0, "ACxBD"=0),
      "ACxAD"=c("AAxAA"=1/16, "AAxAB"=0, "AAxAC"=1/4, "AAxBB"=0, "AAxBC"=0, "AAxCC"=0, "AAxCD"=1/8, "ABxAB"=1/16, "ABxAC"=1/4, "ABxCD"=0, "ACxAC"=1/8, "ACxAD"=1/8, "ACxBD"=0),
      "ACxBD"=c("AAxAA"=0, "AAxAB"=0, "AAxAC"=0, "AAxBB"=0, "AAxBC"=0, "AAxCC"=0, "AAxCD"=0, "ABxAB"=1/8, "ABxAC"=1/2, "ABxCD"=1/8, "ACxAC"=1/8, "ACxAD"=0, "ACxBD"=1/8))

# kth generation probabilities
pik <- function(k)
    c(
      "AAxAA"=((1)/(4)) + ((1)/(4))*(((1)/(2)))^k - ((1)/(20))*(((1)/(4)))^k - (((9+4*sqrt(5))/(40)))*(((1+sqrt(5))/(4)))^k - (((9-4*sqrt(5))/(40)))*(((1-sqrt(5))/(4)))^k,
      "AAxAB"=((1)/(6))*(-((1)/(4)))^k+((1)/(10))*(((1)/(4)))^k-((1)/(6))*(((1)/(2)))^k-(((1-sqrt(5))/(20)))*(((1+sqrt(5))/(4)))^k - (((1+sqrt(5))/(20)))*(((1-sqrt(5))/(4)))^k,
      "AAxAC"=-((1)/(12))*(-((1)/(4)))^k+((1)/(20))*(((1)/(4)))^k-((1)/(6))*(((1)/(2)))^k + ((1)/(10))*((((1+sqrt(5))/(4)))^k + (((1-sqrt(5))/(4)))^k),
      "AAxBB"=((1)/(3))*(-((1)/(4)))^k-((2)/(15))*(-((1)/(8)))^k+((1)/(30))*(((1)/(4)))^k-((1)/(30))*(((1)/(2)))^k-(((2-sqrt(5))/(20)))*(((1+sqrt(5))/(4)))^k-(((2+sqrt(5))/(20)))*(((1-sqrt(5))/(4)))^k,
      "AAxBC"=-((1)/(12))*(-((1)/(4)))^k + ((2)/(15))*(-((1)/(8)))^k - ((1)/(12))*(((1)/(4)))^k + ((1)/(30))*(((1)/(2)))^k,
      "AAxCC"=-((1)/(6))*(-((1)/(4)))^k + ((1)/(30))*(-((1)/(8)))^k + ((1)/(60))*(((1)/(4)))^k - ((1)/(30))*(((1)/(2)))^k +(((3-sqrt(5))/(40)))*(((1+sqrt(5))/(4)))^k+(((3+sqrt(5))/(40)))*(((1-sqrt(5))/(4)))^k,
      "AAxCD"=((1)/(6))*(-((1)/(4)))^k - ((1)/(5))*(-((1)/(8)))^k + ((1)/(30))*(((1)/(2)))^k,
      "ABxAB"=-((2)/(3))*(-((1)/(4)))^k+((2)/(15))*(-((1)/(8)))^k+((1)/(15))*(((1)/(4)))^k-((2)/(15))*(((1)/(2)))^k +(((3-sqrt(5))/(10)))*(((1+sqrt(5))/(4)))^k+(((3+sqrt(5))/(10)))*(((1-sqrt(5))/(4)))^k,
      "ABxAC"=((1)/(6))*(-((1)/(4)))^k-((2)/(15))*(-((1)/(8)))^k-((1)/(6))*(((1)/(4)))^k+((2)/(15))*(((1)/(2)))^k,
      "ABxCD"=((2)/(3))*(-((1)/(8)))^k+((1)/(3))*(((1)/(4)))^k,
      "ACxAC"=((1)/(3))*(-((1)/(4)))^k-((1)/(30))*(-((1)/(8)))^k+((1)/(30))*(((1)/(4)))^k-((2)/(15))*(((1)/(2)))^k -(((2-2*sqrt(5))/(20)))*(((1+sqrt(5))/(4)))^k-(((2+2*sqrt(5))/(20)))*(((1-sqrt(5))/(4)))^k,
      "ACxAD"=-((1)/(3))*(-((1)/(4)))^k + ((1)/(5))*(-((1)/(8)))^k+((2)/(15))*(((1)/(2)))^k,
      "ACxBD"=-((1)/(3))*(-((1)/(8)))^k + ((1)/(3))*(((1)/(4)))^k)

# individual probabilities
indk <- function(k) c("AA"= ((1)/(4)) - (((5+3*sqrt(5))/(40))) * (((1+sqrt(5))/(4)))^k - (((5-3*sqrt(5))/(40))) * (((1-sqrt(5))/(4)))^k
, "AB"= (((5-sqrt(5))/(20))) * (((1+sqrt(5))/(4)))^k + (((5+sqrt(5))/(20))) * (((1-sqrt(5))/(4)))^k
, "AC"= ((sqrt(5))/(10)) * ((((1+sqrt(5))/(4)))^k - (((1-sqrt(5))/(4)))^k)
)


# fixation probabilities
fixprob <- function(k) c("fourwayA"= 1 + (((1)/(2)))^k - (((1)/(5)))*(((1)/(4)))^k - (((9+4*sqrt(5))/(10)))*(((1+sqrt(5))/(4)))^k - (((9-4*sqrt(5))/(10)))*(((1-sqrt(5))/(4)))^k
, "twowayA"= 1 + (((2)/(5)))*(((1)/(4)))^k - (((7+3*sqrt(5))/(10)))*(((1+sqrt(5))/(4)))^k - (((7-3*sqrt(5))/(10)))*(((1-sqrt(5))/(4)))^k
)
