# one X chr locus, 4-way RIL by sib mating

# no. states
nstates <- c("AAxA"=2, "AAxB"=2, "AAxC"=2, "ABxA"=2, "ABxC"=1, "ACxA"=2, "ACxB"=2, "ACxC"=2, "CCxA"=2, "CCxC"=1)

# starting distribution
pi0 <- c("AAxA"=0, "AAxB"=0, "AAxC"=0, "ABxA"=0, "ABxC"=1, "ACxA"=0, "ACxB"=0, "ACxC"=0, "CCxA"=0, "CCxC"=0)

# transition matrix
P <- 
    rbind(
      "AAxA"=c("AAxA"=1, "AAxB"=0, "AAxC"=0, "ABxA"=0, "ABxC"=0, "ACxA"=0, "ACxB"=0, "ACxC"=0, "CCxA"=0, "CCxC"=0),
      "AAxB"=c("AAxA"=0, "AAxB"=0, "AAxC"=0, "ABxA"=1, "ABxC"=0, "ACxA"=0, "ACxB"=0, "ACxC"=0, "CCxA"=0, "CCxC"=0),
      "AAxC"=c("AAxA"=0, "AAxB"=0, "AAxC"=0, "ABxA"=0, "ABxC"=0, "ACxA"=1, "ACxB"=0, "ACxC"=0, "CCxA"=0, "CCxC"=0),
      "ABxA"=c("AAxA"=1/4, "AAxB"=1/4, "AAxC"=0, "ABxA"=1/2, "ABxC"=0, "ACxA"=0, "ACxB"=0, "ACxC"=0, "CCxA"=0, "CCxC"=0),
      "ABxC"=c("AAxA"=0, "AAxB"=0, "AAxC"=0, "ABxA"=0, "ABxC"=0, "ACxA"=1/2, "ACxB"=1/2, "ACxC"=0, "CCxA"=0, "CCxC"=0),
      "ACxA"=c("AAxA"=1/4, "AAxB"=0, "AAxC"=1/4, "ABxA"=0, "ABxC"=0, "ACxA"=1/4, "ACxB"=0, "ACxC"=1/4, "CCxA"=0, "CCxC"=0),
      "ACxB"=c("AAxA"=0, "AAxB"=0, "AAxC"=0, "ABxA"=1/4, "ABxC"=1/4, "ACxA"=0, "ACxB"=1/4, "ACxC"=1/4, "CCxA"=0, "CCxC"=0),
      "ACxC"=c("AAxA"=0, "AAxB"=0, "AAxC"=0, "ABxA"=0, "ABxC"=0, "ACxA"=1/4, "ACxB"=0, "ACxC"=1/4, "CCxA"=1/4, "CCxC"=1/4),
      "CCxA"=c("AAxA"=0, "AAxB"=0, "AAxC"=0, "ABxA"=0, "ABxC"=0, "ACxA"=0, "ACxB"=0, "ACxC"=1, "CCxA"=0, "CCxC"=0),
      "CCxC"=c("AAxA"=0, "AAxB"=0, "AAxC"=0, "ABxA"=0, "ABxC"=0, "ACxA"=0, "ACxB"=0, "ACxC"=0, "CCxA"=0, "CCxC"=1))

# kth generation probabilities
# kth generation probabilities
pik <- function(k)
    c(
      "AAxA"=((1)/(3))+((1)/(24))*(-((1)/(2)))^k + ((1)/(8))*(((1)/(2)))^k - (((5+2*sqrt(5))/(20)))*(((1+sqrt(5))/(4)))^k - (((5-2*sqrt(5))/(20)))*(((1-sqrt(5))/(4)))^k,
      "AAxB"=((1)/(3))*(-((1)/(4)))^k - ((1)/(12))*(((1)/(2)))^k - (((5-3*sqrt(5))/(40)))*(((1+sqrt(5))/(4)))^k - (((5+3*sqrt(5))/(40)))*(((1-sqrt(5))/(4)))^k,
      "AAxC"=((1)/(8))*(-((1)/(2)))^k-((1)/(24))*(((1)/(2)))^k-((1)/(3))*(-((1)/(4)))^k+(((5-sqrt(5))/(40)))*(((1+sqrt(5))/(4)))^k+(((5+sqrt(5))/(40)))*(((1-sqrt(5))/(4)))^k,
      "ABxA"=-((1)/(6))*(((1)/(2)))^k-((1)/(3))*(-((1)/(4)))^k+(((5-sqrt(5))/(20)))*(((1+sqrt(5))/(4)))^k+(((5+sqrt(5))/(20)))*(((1-sqrt(5))/(4)))^k,
      "ABxC"=((1)/(3))*(((1)/(2)))^k + ((2)/(3))*(-((1)/(4)))^k,
      "ACxA"=-((1)/(4))*(-((1)/(2)))^k-((1)/(12))*(((1)/(2)))^k+((1)/(3))*(-((1)/(4)))^k+((sqrt(5))/(10))*((((1+sqrt(5))/(4)))^k-(((1-sqrt(5))/(4)))^k),
      "ACxB"=((1)/(3))*(((1)/(2)))^k - ((1)/(3))*(-((1)/(4)))^k,
      "ACxC"=((1)/(4))*(-((1)/(2)))^k-((1)/(4))*(((1)/(2)))^k+((sqrt(5))/(10))*((((1+sqrt(5))/(4)))^k-(((1-sqrt(5))/(4)))^k),
      "CCxA"=-((1)/(8))*(-((1)/(2)))^k-((1)/(8))*(((1)/(2)))^k+(((5-sqrt(5))/(40)))*(((1+sqrt(5))/(4)))^k+(((5+sqrt(5))/(40)))*(((1-sqrt(5))/(4)))^k,
      "CCxC"=((1)/(3)) - ((1)/(12))*(-((1)/(2)))^k + ((1)/(4))*(((1)/(2)))^k - (((5+3*sqrt(5))/(20)))*(((1+sqrt(5))/(4)))^k-(((5-3*sqrt(5))/(20)))*(((1-sqrt(5))/(4)))^k)

# individual probabilities
femalek <- function(k) c("AA"= ((1)/(3)) + ((1)/(6))*(-((1)/(2)))^k - (((5+sqrt(5))/(20)))*(((1+sqrt(5))/(4)))^k - (((5-sqrt(5))/(20)))*(((1-sqrt(5))/(4)))^k
, "AB"= (((5-sqrt(5))/(10)))*(((1+sqrt(5))/(4)))^k + (((5+sqrt(5))/(10)))*(((1-sqrt(5))/(4)))^k
, "AC"= ((sqrt(5))/(5)) * ((((1+sqrt(5))/(4)))^k - (((1-sqrt(5))/(4)))^k)
, "CC"= ((1)/(3)) + ((1)/(6))*(-((1)/(2)))^(k-1) - (((5+sqrt(5))/(20)))*(((1+sqrt(5))/(4)))^(k-1) - (((5-sqrt(5))/(20)))*(((1-sqrt(5))/(4)))^(k-1)
)
# individual probabilities
malek <- function(k) c("A"= ((1)/(3))*(1 - (-((1)/(2)))^k)
, "C"= ((1)/(3))*(1 + 2*(-((1)/(2)))^k)
)


# fixation probabilities
fixprob <- function(k) c("fourwayX"= 1 + (((1)/(2)))^(k+1) - (((15+7*sqrt(5))/(20)))*(((1+sqrt(5))/(4)))^k - (((15-7*sqrt(5))/(20)))*(((1-sqrt(5))/(4)))^k
, "twowayX"= 1 - (((5+3*sqrt(5))/(10)))*(((1+sqrt(5))/(4)))^k-(((5-3*sqrt(5))/(10)))*(((1-sqrt(5))/(4)))^k
)
