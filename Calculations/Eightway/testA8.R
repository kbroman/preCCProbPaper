system("convertResults.pl statesA8_rev.txt")
source("statesA8.R")
######################################################################
# load results
######################################################################
r <- seq(0, 0.5, by=0.01)
indprob4 <- vector("list", length(r))
names(indprob4) <- myround(r, 2)
for(i in seq(along=r)) {
  file <- paste("indprob/indprob", myround(r[i], 2), ".txt", sep="")
  if(file.exists(file)) 
    indprob4[[i]] <- read.table(file, skip=20, header=TRUE, as.is=TRUE)
  colnames(indprob4[[i]]) <- sub("\\.", "|", colnames(indprob4[[i]]))
}
indprob4 <- indprob4[sapply(indprob4, length) > 0]

# get individual-level probs
mult4 <- c("AA|AA"=4, "AB|AB"=4,  "AC|AC"=8,
           "AA|AB"=8, "AA|AC"=16, "AB|AC"=16,
           "AC|AD"=8, "AA|BB"=2,  "AA|BC"=16,
           "AA|CC"=4, "AA|CD"=8,  "AB|BA"=2, 
           "AB|BC"=16,"AB|CD"=4,  "AC|BD"=4,
           "AC|CA"=4, "AC|CB"=8,  "AC|DB"=4)
m <- match(colnames(indprob4[[1]]), names(mult4))
mult4 <- mult4[m]

indprob4 <- indprob4
for(i in seq(along=indprob4)) 
  indprob4[[i]] <- t(t(indprob4[[i]])/mult4)

indprob8 <- vector("list", length=length(indprob4))
names(indprob8) <- names(indprob4)
for(i in seq(along=indprob8)) {
  v <- statesA8(r[i])
  indprob8[[i]] <- matrix(0, ncol=nrow(v), nrow=nrow(indprob4[[i]]))
  dimnames(indprob8[[i]]) <- list(rownames(indprob4[[i]]), rownames(v))
  for(j in 1:nrow(v)) 
    indprob8[[i]][,j] <- indprob4[[i]][,v[j,2]]*v[j,3]
}

indprob8b <- indprob8
for(i in seq(along=indprob8)) 
  indprob8b[[i]] <- t(t(indprob8[[i]])*v[,1])

log10(max(abs(sapply(indprob8b,apply, 1, sum)-1)))

# any of these have matching probabilities for all recombination fractions?
d <- matrix(NA, ncol(v), ncol(v))
v <- indprob8[[41]]
for(i in 1:(ncol(d)-1)) 
  for(j in (i+1):ncol(d)) 
    if(any(v[,i] > 1e-12) && any(v[,j] > 1e-12))
      d[i,j] <- d[j,i] <- max(abs(v[,i] - v[,j]))
min(d, na.rm=TRUE) # all columns distinct
