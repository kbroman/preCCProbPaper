

b <- rbind(1, 0, 0, 0)

# female X chr haplotype probabilities for 4-way RIL by sib mating
femalehaporig <- function(r,k) c(
"AA"= (1/2)*(2/(12*r+3) + 1/(3*r+3)*(-1/2)^k - 
       (4*r^3 - sqrt(r^2-10*r+5)*(4*r^2+3*r)+3*r^2-5*r)/((8*r^2+10*r+2)*sqrt(r^2-10*r+5))*
       ((1 - r + sqrt(r^2-10*r+5))/4)^k + 
       (4*r^3 + sqrt(r^2-10*r+5)*(4*r^2+3*r)+3*r^2-5*r)/((8*r^2+10*r+2)*sqrt(r^2-10*r+5))*
       ((1 - r - sqrt(r^2-10*r+5))/4)^k)
,
"AB"= 2*r/(12*r+3) + r/(3*r+3)*(-1/2)^k + 
       (2*r^3 +6*r^2 - sqrt(r^2-10*r+5)*(2*r^2+r))/((8*r^2+10*r+2)*sqrt(r^2-10*r+5))*
       ((1 - r + sqrt(r^2-10*r+5))/4)^k + 
      -(2*r^3 +6*r^2 + sqrt(r^2-10*r+5)*(2*r^2+r))/((8*r^2+10*r+2)*sqrt(r^2-10*r+5))*
       ((1 - r - sqrt(r^2-10*r+5))/4)^k
,
"AC"= 2*r/(12*r+3) - r/(6*r+6)*(-1/2)^k - 
       (9*r^2 +5*r + r*sqrt(r^2-10*r+5))/((16*r^2+20*r+4)*sqrt(r^2-10*r+5))*
       ((1 - r + sqrt(r^2-10*r+5))/4)^k + 
       (9*r^2 +5*r - r*sqrt(r^2-10*r+5))/((16*r^2+20*r+4)*sqrt(r^2-10*r+5))*
       ((1 - r - sqrt(r^2-10*r+5))/4)^k
,
"CC"= 1/(12*r+3) - 1/(3*r+3)*(-1/2)^k + 
       (9*r^2 +5*r + r*sqrt(r^2-10*r+5))/((8*r^2+10*r+2)*sqrt(r^2-10*r+5))*
       ((1 - r + sqrt(r^2-10*r+5))/4)^k - 
       (9*r^2 +5*r - r*sqrt(r^2-10*r+5))/((8*r^2+10*r+2)*sqrt(r^2-10*r+5))*
       ((1 - r - sqrt(r^2-10*r+5))/4)^k
)# female X chr haplotype probabilities for 4-way RIL by sib mating
femalehap <- function(r,k) c(
"AA"= ((1)/(3*(1+4*r))) + ((1)/(6*(1+r)))*(-((1)/(2)))^k - (((4*r^3 - (4*r^2+3*r)*sqrt(r^2-10*r+5)+3*r^2-5*r)/(4*(4*r^2+5*r+1)*sqrt(r^2-10*r+5))))*(((1 - r + sqrt(r^2-10*r+5))/(4)))^k + (((4*r^3 + (4*r^2+3*r)*sqrt(r^2-10*r+5)+3*r^2-5*r)/(4*(4*r^2+5*r+1)*sqrt(r^2-10*r+5))))*(((1 - r - sqrt(r^2-10*r+5))/(4)))^k,
"AB"= ((2*r)/(3*(1+4*r))) + ((r)/(3*(1+r)))*(-((1)/(2)))^k + (((2*r^3 +6*r^2 - (2*r^2+r)*sqrt(r^2-10*r+5))/(2*(4*r^2+5*r+1)*sqrt(r^2-10*r+5))))*(((1 - r + sqrt(r^2-10*r+5))/(4)))^k - (((2*r^3 +6*r^2 + (2*r^2+r)*sqrt(r^2-10*r+5))/(2*(4*r^2+5*r+1)*sqrt(r^2-10*r+5))))*(((1 - r - sqrt(r^2-10*r+5))/(4)))^k,
"AC"= ((2*r)/(3*(1+4*r))) - ((r)/(6*(1+r)))*(-((1)/(2)))^k - (((9*r^2 +5*r + r*sqrt(r^2-10*r+5))/(4*(4*r^2+5*r+1)*sqrt(r^2-10*r+5))))*(((1 - r + sqrt(r^2-10*r+5))/(4)))^k + (((9*r^2 +5*r - r*sqrt(r^2-10*r+5))/(4*(4*r^2+5*r+1)*sqrt(r^2-10*r+5))))*(((1 - r - sqrt(r^2-10*r+5))/(4)))^k,
"CC"= ((1)/(3*(1+4*r))) - ((1)/(3*(1+r)))*(-((1)/(2)))^k + (((9*r^2 +5*r + r*sqrt(r^2-10*r+5))/(2*(4*r^2+5*r+1)*sqrt(r^2-10*r+5))))*(((1 - r + sqrt(r^2-10*r+5))/(4)))^k - (((9*r^2 +5*r - r*sqrt(r^2-10*r+5))/(2*(4*r^2+5*r+1)*sqrt(r^2-10*r+5))))*(((1 - r - sqrt(r^2-10*r+5))/(4)))^k)

# matrix for calculating female X chr haplotype probabilities for 4-way RIL by sib mating 
femalehaptm <- function(r) rbind(
"AA" = c("AA" = (1-r)/2, "AB" = 0, "AC" = 1-r, "CC" = 1/4)
,
"AB" = c("AA" = r/2, "AB" = 0, "AC" = r, "CC" = 1/4)
,
"AC" = c("AA" = 1/2, "AB" = 0, "AC" = 0, "CC" = 0)
,
"CC" = c("AA" = 0, "AB" = 1, "AC" = 0, "CC" = 1/2)
)


# starting values for calculating female X chr haplotype probabilities for 4-way RIL by sib mating 
femalehapstart <- rbind(
"AA" = c("AA" = 1/2, "AB" = 0, "AC" = 0, "CC" = 0)
,
"AB" = c("AA" = 0, "AB" = 1/2, "AC" = 0, "CC" = 0)
,
"AC" = c("AA" = 0, "AB" = 0, "AC" = 0, "CC" = 1/4)
,
"CC" = c("AA" = 0, "AB" = 0, "AC" = 1, "CC" = 0)
)


bhap <- rbind(1, 0, 0, 0)
