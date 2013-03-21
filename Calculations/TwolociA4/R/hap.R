# autosomal haplotype probabilities for 4-way RIL by sib mating
haporig <- function(r,k) c(
"AA"= (1/4)*(1/(1+6*r) + 
       (6*r^2-7*r+3*r*sqrt(4*r^2-12*r+5))/((1+6*r)*sqrt(4*r^2-12*r+5))*
       ((1 - 2*r - sqrt(4*r^2-12*r+5))/4)^k - 
       (6*r^2-7*r-3*r*sqrt(4*r^2-12*r+5))/((1+6*r)*sqrt(4*r^2-12*r+5))*
       ((1 - 2*r + sqrt(4*r^2-12*r+5))/4)^k)
,
"AB"= (1/4)*(2*r/(1+6*r) - 
       (10*r^2-r+r*sqrt(4*r^2-12*r+5))/((1+6*r)*sqrt(4*r^2-12*r+5))*
       ((1 - 2*r - sqrt(4*r^2-12*r+5))/4)^k + 
       (10*r^2-r-r*sqrt(4*r^2-12*r+5))/((1+6*r)*sqrt(4*r^2-12*r+5))*
       ((1 - 2*r + sqrt(4*r^2-12*r+5))/4)^k)
,
"AC"= (1/8)*(4*r/(1+6*r) + 
       (4*r^2+6*r-2*r*sqrt(4*r^2-12*r+5))/((1+6*r)*sqrt(4*r^2-12*r+5))*
       ((1 - 2*r - sqrt(4*r^2-12*r+5))/4)^k - 
       (4*r^2+6*r+2*r*sqrt(4*r^2-12*r+5))/((1+6*r)*sqrt(4*r^2-12*r+5))*
       ((1 - 2*r + sqrt(4*r^2-12*r+5))/4)^k)
)# autosomal haplotype probabilities for 4-way RIL by sib mating
hap <- function(r,k) {
  if(r == 0.5) {
    if(k==0) return(c(0.25, 0, 0))
    if(k==1) return(c(1/8, 1/8, 0))
    return(c(1/16, 1/16, 1/16))
  }
    
  c(
"AA"= ((1)/(4*(1+6*r))) - (((6*r^2-7*r-3*r*sqrt(4*r^2-12*r+5))/(4*(1+6*r)*sqrt(4*r^2-12*r+5))))*(((1 - 2*r + sqrt(4*r^2-12*r+5))/(4)))^k + (((6*r^2-7*r+3*r*sqrt(4*r^2-12*r+5))/(4*(1+6*r)*sqrt(4*r^2-12*r+5))))*(((1 - 2*r - sqrt(4*r^2-12*r+5))/(4)))^k,
"AB"= ((r)/(2*(1+6*r))) + (((10*r^2-r-r*sqrt(4*r^2-12*r+5))/(4*(1+6*r)*sqrt(4*r^2-12*r+5))))*(((1 - 2*r + sqrt(4*r^2-12*r+5))/(4)))^k - (((10*r^2-r+r*sqrt(4*r^2-12*r+5))/(4*(1+6*r)*sqrt(4*r^2-12*r+5))))*(((1 - 2*r - sqrt(4*r^2-12*r+5))/(4)))^k,
"AC"= ((r)/(2*(1+6*r))) - (((2*r^2+3*r+r*sqrt(4*r^2-12*r+5))/(4*(1+6*r)*sqrt(4*r^2-12*r+5))))*(((1 - 2*r + sqrt(4*r^2-12*r+5))/(4)))^k + (((2*r^2+3*r-r*sqrt(4*r^2-12*r+5))/(4*(1+6*r)*sqrt(4*r^2-12*r+5))))* (((1 - 2*r - sqrt(4*r^2-12*r+5))/(4)))^k)
}

# matrix for calculating autosomal haplotype probabilities for 4-way RIL by sib mating 
haptm <- function(r) rbind(
"AA" = c("AA" = 1-r, "AB" = 0, "AC" = 1/4)
,
"AB" = c("AA" = r, "AB" = 0, "AC" = 1/4)
,
"AC" = c("AA" = 0, "AB" = 1, "AC" = 1/2)
)


# starting values for calculating autosomal haplotype probabilities for 4-way RIL by sib mating 
hapstart <- rbind(
"AA" = c("AA" = 1/4, "AB" = 0, "AC" = 0)
,
"AB" = c("AA" = 0, "AB" = 1/4, "AC" = 0)
,
"AC" = c("AA" = 0, "AB" = 0, "AC" = 1/8)
)


b <- rbind(1, 0, 0)
