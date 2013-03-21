source("male_hap.R")

r <- seq(0, 0.5, by=0.01)
res1 <- vector("list", length(r))
names(res1) <- myround(r, 2)
for(i in seq(along=r)) {
  res1[[i]] <- matrix(ncol=4, nrow=51)
  for(k in 1:nrow(res1[[i]])) 
    res1[[i]][k,] <- malehap(r[i], k-1)
}

res2 <- vector("list", length(r))
names(res2) <- myround(r, 2)
for(i in seq(along=r)) {
  A <- malehaptm(r[i])
  Ae <- eigen(A)
  V <- Ae$vectors
  Vi <- solve(V)
  Ae <- Ae$values
  res2[[i]] <- matrix(ncol=4, nrow=51)
  res2[[i]][1,] <- as.numeric(malehapstart %*% b)
  for(k in 2:nrow(res2[[i]])) 
    res2[[i]][k,] <- as.numeric(malehapstart %*% V %*% diag(Ae^(k-1)) %*% Vi %*% b)
}

lmaxdif <- rep(NA, length(res1))
for(i in seq(along=res1)) 
  lmaxdif[i] <- log10(max(abs(res2[[i]] - res1[[i]])))
max(lmaxdif)

######################################################################
# load results
######################################################################
r <- seq(0, 0.5, by=0.01)
res3 <- vector("list", length(r))
names(res3) <- myround(r, 2)
for(i in seq(along=r)) {
  file <- paste("../male", myround(r[i], 2), ".txt", sep="")
  if(file.exists(file)) 
    res3[[i]] <- read.table(file, skip=20, header=TRUE)
}
res3 <- res3[sapply(res3, length) > 0]

res1sub <- res1[names(res3)]
lmaxdif <- rep(NA, length(res3))
for(i in seq(along=res3)) 
  lmaxdif[i] <- log10(max(abs(res3[[i]] - t(t(res1sub[[i]])*c(2,2,4,1)))))
max(lmaxdif)

######################################################################
# compare to revised version with fancy latex fractions
######################################################################
r <- seq(0, 0.5, len=51)
res1 <- res2 <- vector("list", length(r))
for(i in seq(along=res1)) {
  res1[[i]] <- res2[[i]] <- matrix(ncol=4, nrow=51)
  for(k in 0:50) {
    res1[[i]][k+1,] <- malehaporig(r[i], k)
    res2[[i]][k+1,] <- malehap(r[i], k)
  }
}
    
lmaxdif <- rep(NA, length(res1))
for(i in seq(along=res1))
  lmaxdif[i] <- log10(max(abs(res1[[i]] - res2[[i]])))
max(lmaxdif)
