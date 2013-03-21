# one X chr locus, 2-way RIL by sib mating

# no. states
nstates <- c("AAxA"=1, "AAxB"=1, "ABxA"=1, "ABxB"=1, "BBxA"=1, "BBxB"=1)

# starting distribution
pi0 <- c("AAxA"=0, "AAxB"=1, "ABxA"=0, "ABxB"=0, "BBxA"=0, "BBxB"=0)

# transition matrix
P <- 
    rbind(
      "AAxA"=c("AAxA"=1, "AAxB"=0, "ABxA"=0, "ABxB"=0, "BBxA"=0, "BBxB"=0),
      "AAxB"=c("AAxA"=0, "AAxB"=0, "ABxA"=1, "ABxB"=0, "BBxA"=0, "BBxB"=0),
      "ABxA"=c("AAxA"=1/4, "AAxB"=1/4, "ABxA"=1/4, "ABxB"=1/4, "BBxA"=0, "BBxB"=0),
      "ABxB"=c("AAxA"=0, "AAxB"=0, "ABxA"=1/4, "ABxB"=1/4, "BBxA"=1/4, "BBxB"=1/4),
      "BBxA"=c("AAxA"=0, "AAxB"=0, "ABxA"=0, "ABxB"=1, "BBxA"=0, "BBxB"=0),
      "BBxB"=c("AAxA"=0, "AAxB"=0, "ABxA"=0, "ABxB"=0, "BBxA"=0, "BBxB"=1))

# kth generation probabilities
pik <- function(k)
    c(
      "AAxA"=2/3 + (1/12)*(-1/2)^k-(1/4)*(1/2)^k-((5-3*sqrt(5))/20)*((1-sqrt(5))/4)^k-((5+3*sqrt(5))/20)*((1+sqrt(5))/4)^k,
      "AAxB"=(1/4)*(-1/2)^k+(1/4)*(1/2)^k+((5+sqrt(5))/20)*((1-sqrt(5))/4)^k+((5-sqrt(5))/20)*((1+sqrt(5))/4)^k,
      "ABxA"=(-1/2)*(-1/2)^k + (1/2)*(1/2)^k - (sqrt(5)/5)*((1-sqrt(5))/4)^k + (sqrt(5)/5)*((1+sqrt(5))/4)^k,
      "ABxB"=(1/2)*(-1/2)^k - (1/2)*(1/2)^k - (sqrt(5)/5)*((1-sqrt(5))/4)^k + (sqrt(5)/5)*((1+sqrt(5))/4)^k,
      "BBxA"=(-1/4)*(-1/2)^k-(1/4)*(1/2)^k+((5+sqrt(5))/20)*((1-sqrt(5))/4)^k+((5-sqrt(5))/20)*((1+sqrt(5))/4)^k,
      "BBxB"=1/3+(-1/12)*(-1/2)^k+(1/4)*(1/2)^k-((5-3*sqrt(5))/20)*((1-sqrt(5))/4)^k-((5+3*sqrt(5))/20)*((1+sqrt(5))/4)^k)

