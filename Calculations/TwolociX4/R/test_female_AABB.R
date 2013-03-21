source("femaleAABB.R")

######################################################################
# load results
######################################################################
r <- seq(0, 0.5, by=0.01)
res1 <- vector("list", length(r))
names(res1) <- myround(r, 2)
for(i in seq(along=r)) {
  file <- paste("../female", myround(r[i], 2), ".txt", sep="")
  if(file.exists(file)) 
    res1[[i]] <- read.table(file, skip=20, header=TRUE)
}
res1 <- res1[sapply(res1, length) > 0]
res1 <- lapply(res1, function(a) a[,c("AA.BB","AA.BC","AA.CC","AB.BA","AB.BC","AB.CC","AC.CA","AC.CB")])

r <- as.numeric(names(res1))
res2 <- vector("list", length(res1))
names(res2) <- names(res1)
for(i in seq(along=r)) {
  A <- femaleAABBtm(r[i])
  Ae <- eigen(A)
  V <- Ae$vectors
  Vi <- solve(V)
  Ae <- Ae$values
  res2[[i]] <- matrix(ncol=8, nrow=nrow(res1[[1]]))
  res2[[i]][1,] <- as.numeric(femaleAABBstart %*% b)*c(1,4,2,1,4,2,2,2)
  for(k in 2:nrow(res2[[i]]))
    res2[[i]][k,] <- as.numeric(femaleAABBstart %*% V %*% diag(Ae^(k-1)) %*% Vi %*% b)*c(1,4,2,1,4,2,2,2)
}

lmaxdif <- rep(NA, length(res1))
for(i in seq(along=res1)) 
  lmaxdif[i] <- log10(max(abs(res2[[i]] - res1[[i]])))
max(lmaxdif)

