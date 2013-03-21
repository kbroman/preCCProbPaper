source("femaleAAAB.R")
source("func.R")
pi0 <- femaleAAABstart*c(4, 4, 4, 2, 4)

######################################################################
# load results
######################################################################
r <- seq(0, 0.5, by=0.01)
res1 <- vector("list", length(r))
names(res1) <- myround(r, 2)
for(i in seq(along=r)) {
  file <- paste("../female", myround(r[i], 2), ".txt", sep="")
  if(file.exists(file)) 
    res1[[i]] <- as.matrix(read.table(file, skip=20, header=TRUE))
}
res1 <- res1[sapply(res1, length) > 0]
res1 <- lapply(res1, function(a) a[,c("AA.AB","AA.AC","AB.AC","AC.BC","AC.CC")])

r <- as.numeric(names(res1))
res2 <- vector("list", length(res1))
names(res2) <- names(res1)
for(i in seq(along=r)) {
  A <- femaleAAABtm(r[i])
  res2[[i]] <- matrix(ncol=5, nrow=nrow(res1[[1]]))
  colnames(res2[[i]]) <- colnames(res1[[1]])
  cur <- pi0
  res2[[i]][1,] <- as.numeric(pi0 %*% b)
  for(k in 2:nrow(res2[[i]])) {
    cur <- cur %*% A
    res2[[i]][k,] <- cur %*% b
  }
}

lmaxdif <- rep(NA, length(res1))
for(i in seq(along=res1)) 
  lmaxdif[i] <- log10(max(abs(res2[[i]] - res1[[i]])))
max(lmaxdif)



r <- as.numeric(names(res1))
res3 <- vector("list", length(res1))
names(res3) <- names(res1)
for(i in seq(along=r)) {
  A <- femaleAAABtm(r[i])
  Ae <- eigen(A)
  V <- Ae$vectors
  Vi <- solve(V)
  Ae <- Ae$values
  res3[[i]] <- matrix(ncol=5, nrow=nrow(res1[[1]]))
  colnames(res3[[i]]) <- colnames(res1[[1]])
  res3[[i]][1,] <- as.numeric(pi0 %*% b)
  cur <- pi0
  for(k in 2:nrow(res2[[i]])) {
    cur <- cur %*% A
    res3[[i]][k,] <- as.numeric(cur %*% b)
  }
}


lmaxdif2 <- rep(NA, length(res1))
for(i in seq(along=res1)) 
  lmaxdif2[i] <- log10(max(abs(res3[[i]] - res1[[i]])))
max(lmaxdif2)
