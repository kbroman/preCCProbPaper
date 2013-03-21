source("AA_AA.R")

A13 <- indAAAAtm(0.13)
A13e <- eigen(A13)
D13 <- diag(A13e$values)
V13 <- A13e$vectors
V13i <- solve(V13)
max(abs(A13 - V13 %*% D13 %*% V13i))
max(abs(A13%*%A13%*%A13 - V13 %*% diag(A13e$values^3) %*% V13i))

(startAA.AA %*% V13 %*% diag(A13e$values^3) %*% V13i %*% b)*4
(startAB.AB %*% V13 %*% diag(A13e$values^50) %*% V13i %*% b)*4
(startAC.AC %*% V13 %*% diag(A13e$values^50) %*% V13i %*% b)*8

######################################################################
# load results
######################################################################
r <- seq(0, 0.5, by=0.01)
indprob <- vector("list", length(r))
names(indprob) <- myround(r, 2)
for(i in seq(along=r)) {
  file <- paste("../indprob", myround(r[i], 2), ".txt", sep="")
  if(file.exists(file)) 
    indprob[[i]] <- read.table(file, skip=20, header=TRUE)
}
indprob <- indprob[sapply(indprob, length) > 0]
indprob <- lapply(indprob, function(a) a[,c("AA.AA","AB.AB","AC.AC")])

######################################################################
# exact calculation of a subset of those
######################################################################
indprob2 <- vector("list", length(indprob))
names(indprob2) <- names(indprob)
start <- rbind(startAA.AA, startAB.AB, startAC.AC)
for(i in seq(along=indprob2)) {
  r <- as.numeric(names(indprob2))[i]
  Am <- indAAAAtm(r)
  Ame <- eigen(Am)
  V <- Ame$vectors
  Vi <- solve(V)
  e <- Ame$values
  indprob2[[i]] <- matrix(ncol=3, nrow=nrow(indprob[[1]]))
  indprob2[[i]][1,] <- as.numeric(start %*% b)*c(4,4,8)
  for(j in 1:(nrow(indprob[[1]])-1)) {
    temp <- (V %*% diag(e^j) %*% Vi %*% b)
    indprob2[[i]][j+1,] <- as.numeric(start %*% temp)*c(4,4,8)
  }
}

logmaxdif <- rep(NA, length(indprob2))
for(i in seq(along=indprob2)) 
  logmaxdif[i] <- log10(max(abs(indprob2[[i]]-indprob[[i]])))
max(logmaxdif)
