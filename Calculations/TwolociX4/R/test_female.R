source("female.R")

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

res1sub <- lapply(res1, function(a) a[,c("AA.AA","AB.AB","AC.AC","CC.CC")])

r <- as.numeric(names(res1))
res2 <- vector("list", length(res1))
names(res2) <- names(res1)
for(i in seq(along=r)) {
  A <- femaleAAAAtm(r[i])
  Ae <- eigen(A)
  V <- Ae$vectors
  Vi <- solve(V)
  Ae <- Ae$values
  res2[[i]] <- matrix(ncol=4, nrow=nrow(res1[[1]]))
  res2[[i]][1,] <- as.numeric(femaleAAAAstart %*% b)*c(2,2,4,1)
  for(k in 2:nrow(res2[[i]]))
    res2[[i]][k,] <- as.numeric(femaleAAAAstart %*% V %*% diag(Ae^(k-1)) %*% Vi %*% b)*c(2,2,4,1)
}                      

lmaxdif <- rep(NA, length(res1sub))
for(i in seq(along=res1sub)) 
  lmaxdif[i] <- log10(max(abs(res2[[i]] - res1sub[[i]])))
max(lmaxdif)
