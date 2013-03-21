source("AA_BB.R")
source("func.R")

######################################################################
# load results
######################################################################
r <- seq(0, 0.5, by=0.01)
indprob <- vector("list", length(r))
names(indprob) <- myround(r, 2)
for(i in seq(along=r)) {
  file <- paste("../indprob", myround(r[i], 2), ".txt", sep="")
  if(file.exists(file)) 
    indprob[[i]] <- as.matrix(read.table(file, skip=20, header=TRUE))
}
indprob <- indprob[sapply(indprob, length) > 0]
indprob <- lapply(indprob, function(a) a[,sub("\\|", ".", rownames(indAABBstart))])


######################################################################
# exact calculation of a subset of those
######################################################################
indprob2 <- vector("list", length(indprob))
names(indprob2) <- names(indprob)
r <- as.numeric(names(indprob))
for(i in seq(along=indprob2)) {
  Am <- indAABBtm(r[i])
  Ame <- eigen(Am)
  V <- Ame$vectors
  Vi <- solve(V)
  e <- Ame$values
  indprob2[[i]] <- matrix(ncol=nrow(pi0), nrow=nrow(indprob[[1]]))
  indprob2[[i]][1,] <- as.numeric(pi0 %*% b)
  for(j in 1:(nrow(indprob[[1]])-1)) {
    temp <- (V %*% diag(e^j) %*% Vi %*% b)
    indprob2[[i]][j+1,] <- as.numeric(pi0 %*% temp)
  }
}

######################################################################
# repeat without the eigen decompostion...directly via matrix multiplication
######################################################################
indprob3 <- vector("list", length(indprob))
names(indprob3) <- names(indprob)
r <- as.numeric(names(indprob))
for(i in seq(along=indprob3)) {
  Am <- indAABBtm(r[i])
  indprob3[[i]] <- matrix(ncol=nrow(pi0), nrow=nrow(indprob[[1]]))
  indprob3[[i]][1,] <- as.numeric(pi0 %*% b)
  cur <- pi0
  for(j in 1:(nrow(indprob[[1]])-1)) {
    cur <- cur %*% Am
    indprob3[[i]][j+1,] <- as.numeric(cur %*% b)
  }
}


######################################################################
# calculate differences from numerical calculations
######################################################################
logmaxdif <- rep(NA, length(indprob2))
for(i in seq(along=indprob2)) 
  logmaxdif[i] <- log10(max(abs(indprob2[[i]]-indprob[[i]])))
max(logmaxdif)

logmaxdif2 <- rep(NA, nrow(indprob2[[1]]))
for(i in seq(along=logmaxdif2))
  logmaxdif2[i] <- log10(max(abs(unlist(sapply(indprob, function(a) a[i,]))-unlist(sapply(indprob2, function(a) a[i,])))))
max(logmaxdif2)


logmaxdif3 <- rep(NA, length(indprob3))
for(i in seq(along=indprob3)) 
  logmaxdif3[i] <- log10(max(abs(indprob3[[i]]-indprob[[i]])))
max(logmaxdif3)

logmaxdif4 <- rep(NA, nrow(indprob3[[1]]))
for(i in seq(along=logmaxdif4))
  logmaxdif4[i] <- log10(max(abs(unlist(sapply(indprob, function(a) a[i,]))-unlist(sapply(indprob3, function(a) a[i,])))))
max(logmaxdif4)

