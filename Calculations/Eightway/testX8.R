system("convertResults.pl statesX8_revalt.txt")
source("statesX8.R")
######################################################################
# load results
######################################################################
r <- seq(0, 0.5, by=0.01)
femprob4 <- vector("list", length(r))
names(femprob4) <- myround(r, 2)
for(i in seq(along=r)) {
  file <- paste("femprob/female", myround(r[i], 2), ".txt", sep="")
  if(file.exists(file)) 
    femprob4[[i]] <- as.matrix(read.table(file, skip=20, header=TRUE, as.is=TRUE))
  colnames(femprob4[[i]]) <- sub("\\.", "|", colnames(femprob4[[i]]))
}
femprob4 <- femprob4[sapply(femprob4, length) > 0]

# get individual-level probs
femmult4 <- c("AA|AA"=  2, "AB|AB"=  2, "AC|AC"=  4, "CC|CC"=  1, 
              "AA|AB"=  4, "AA|AC"=  4, "AB|AC"=  4, "AC|BC"=  2, "AC|CC"=  4,
              "AA|BB"=  1, "AA|BC"=  4, "AA|CC"=  2,
              "AB|BA"=  1, "AB|BC"=  4, "AB|CC"=  2,
              "AC|CA"=  2, "AC|CB"=  2)

m <- match(colnames(femprob4[[1]]), names(femmult4))
femmult4 <- femmult4[m]

femprob4 <- femprob4
for(i in seq(along=femprob4)) 
  femprob4[[i]] <- t(t(femprob4[[i]])/femmult4)

femprob8 <- vector("list", length=length(femprob4))
names(femprob8) <- names(femprob4)
for(i in seq(along=femprob8)) {
  v <- statesA8(r[i])
  femprob8[[i]] <- matrix(0, ncol=nrow(v), nrow=nrow(femprob4[[i]]))
  dimnames(femprob8[[i]]) <- list(rownames(femprob4[[i]]), rownames(v))
  for(j in 1:nrow(v)) 
    femprob8[[i]][,j] <- femprob4[[i]][,v[j,2]]*v[j,3]
}

femprob8b <- femprob8
for(i in seq(along=femprob8)) 
  femprob8b[[i]] <- t(t(femprob8[[i]])*v[,1])

log10(max(abs(sapply(femprob8b,apply, 1, sum)-1)))

# any of these have matching probabilities for all recombination fractions?
#d <- matrix(NA, ncol(v), ncol(v))
#v <- femprob8[[41]]
#for(i in 1:(ncol(d)-1)) 
#  for(j in (i+1):ncol(d)) 
#    if(any(v[,i] > 1e-12) && any(v[,j] > 1e-12))
#      d[i,j] <- d[j,i] <- max(abs(v[,i] - v[,j]))
#min(d, na.rm=TRUE) # all columns distinct
