tm <- vector("list", 11)
r <- names(tm) <- seq(0, 0.5, by=0.05)

loadtm <-
function(file)
{
  x <- scan(file, sep="\t", what=character())
  wh <- grep("::$", x)
  y <- vector("list", length(wh))
  names(y) <- sub("::", "", x[wh])
  wh <- c(wh, length(x)+1)
  for(i in 1:(length(wh)-1)) {
    y[[i]] <- as.numeric(x[seq(wh[i]+2, wh[i+1], by=2)])
    names(y[[i]]) <- sub(":", "", x[seq(wh[i]+1, wh[i+1]-1, by=2)])
  }
  y
}
    

for(i in seq(along=r)) {
  j <- r[i]*100
  if(j < 10) j <- paste("0", j, sep="")
  tm[[i]] <- loadtm(paste("tm4A_", j, ".txt", sep=""))
}

rn <- names(tm[[1]])

ind1 <- sapply(strsplit(rn, "x"), function(a) a[1])
ind2 <- sapply(strsplit(rn, "x"), function(a) a[2])
hap11 <- sapply(strsplit(ind1, "\\|"), function(a) a[1])
hap12 <- sapply(strsplit(ind1, "\\|"), function(a) a[2])
hap21 <- sapply(strsplit(ind2, "\\|"), function(a) a[1])
hap22 <- sapply(strsplit(ind2, "\\|"), function(a) a[2])
hap11a <- sapply(hap11, substr, 1, 1)
hap11b <- sapply(hap11, substr, 2, 2)
hap12a <- sapply(hap12, substr, 1, 1)
hap12b <- sapply(hap12, substr, 2, 2)
hap21a <- sapply(hap21, substr, 1, 1)
hap21b <- sapply(hap21, substr, 2, 2)
hap22a <- sapply(hap22, substr, 1, 1)
hap22b <- sapply(hap22, substr, 2, 2)

B <- matrix(0, nrow=length(tm[[1]]), ncol=17)
dimnames(B) <- list(rn, c("AA|ABx--|--", "AA|--xAB|--", "AA|--xA-|-B",
                          "A-|-AxAB|--", "A-|-AxA-|-B", "AA|-Bx--|--",
                          "AA|A-x-B|--", "AA|--x-B|--", "AA|-BxA-|--",
                          "AB|-AxA-|--", "AB|A-x-A|--", "AB|--x-A|--",
                          "A-|-Bx-A|--", "A-|A-x-A|-B", "A-|--x-A|-B",
                          "A-|-Ax-B|--", "AB|-Ax--|--"))
                          

B[hap11=="AA" & hap12=="AB",1] <- B[hap11=="AA" & hap12=="AB",1] + 0.5 
B[hap21=="AA" & hap22=="AB",1] <- B[hap21=="AA" & hap22=="AB",1] + 0.5 

B[hap11=="AA" & hap21=="AB",2] <- B[hap11=="AA" & hap21=="AB",2] + 0.25
B[hap11=="AA" & hap22=="AB",2] <- B[hap11=="AA" & hap22=="AB",2] + 0.25
B[hap12=="AA" & hap21=="AB",2] <- B[hap12=="AA" & hap21=="AB",2] + 0.25
B[hap12=="AA" & hap22=="AB",2] <- B[hap12=="AA" & hap22=="AB",2] + 0.25
B[hap21=="AA" & hap11=="AB",2] <- B[hap21=="AA" & hap11=="AB",2] + 0.25
B[hap21=="AA" & hap12=="AB",2] <- B[hap21=="AA" & hap12=="AB",2] + 0.25
B[hap22=="AA" & hap11=="AB",2] <- B[hap22=="AA" & hap11=="AB",2] + 0.25
B[hap22=="AA" & hap12=="AB",2] <- B[hap22=="AA" & hap12=="AB",2] + 0.25

B[hap11=="AA" & hap21a=="A" & hap22b=="B",3] <- B[hap11=="AA" & hap21a=="A" & hap22b=="B",3] + 0.25
B[hap11=="AA" & hap22a=="A" & hap21b=="B",3] <- B[hap11=="AA" & hap22a=="A" & hap21b=="B",3] + 0.25
B[hap12=="AA" & hap21a=="A" & hap22b=="B",3] <- B[hap12=="AA" & hap21a=="A" & hap22b=="B",3] + 0.25
B[hap12=="AA" & hap22a=="A" & hap21b=="B",3] <- B[hap12=="AA" & hap22a=="A" & hap21b=="B",3] + 0.25
B[hap21=="AA" & hap11a=="A" & hap12b=="B",3] <- B[hap21=="AA" & hap11a=="A" & hap12b=="B",3] + 0.25
B[hap21=="AA" & hap12a=="A" & hap11b=="B",3] <- B[hap21=="AA" & hap12a=="A" & hap11b=="B",3] + 0.25
B[hap22=="AA" & hap11a=="A" & hap12b=="B",3] <- B[hap22=="AA" & hap11a=="A" & hap12b=="B",3] + 0.25
B[hap22=="AA" & hap12a=="A" & hap11b=="B",3] <- B[hap22=="AA" & hap12a=="A" & hap11b=="B",3] + 0.25

B[hap11=="AB" & hap21a=="A" & hap22b=="A",4] <- B[hap11=="AB" & hap21a=="A" & hap22b=="A",4] + 0.25
B[hap11=="AB" & hap22a=="A" & hap21b=="A",4] <- B[hap11=="AB" & hap22a=="A" & hap21b=="A",4] + 0.25
B[hap12=="AB" & hap21a=="A" & hap22b=="A",4] <- B[hap12=="AB" & hap21a=="A" & hap22b=="A",4] + 0.25
B[hap12=="AB" & hap22a=="A" & hap21b=="A",4] <- B[hap12=="AB" & hap22a=="A" & hap21b=="A",4] + 0.25
B[hap21=="AB" & hap11a=="A" & hap12b=="A",4] <- B[hap21=="AB" & hap11a=="A" & hap12b=="A",4] + 0.25
B[hap21=="AB" & hap12a=="A" & hap11b=="A",4] <- B[hap21=="AB" & hap12a=="A" & hap11b=="A",4] + 0.25
B[hap22=="AB" & hap11a=="A" & hap12b=="A",4] <- B[hap22=="AB" & hap11a=="A" & hap12b=="A",4] + 0.25
B[hap22=="AB" & hap12a=="A" & hap11b=="A",4] <- B[hap22=="AB" & hap12a=="A" & hap11b=="A",4] + 0.25

B[hap11a=="A" & hap12b=="A" & hap21a=="A" & hap22b=="B",5] <- B[hap11a=="A" & hap12b=="A" & hap21a=="A" & hap22b=="B",5] + 0.25
B[hap11a=="A" & hap12b=="A" & hap22a=="A" & hap21b=="B",5] <- B[hap11a=="A" & hap12b=="A" & hap22a=="A" & hap21b=="B",5] + 0.25
B[hap12a=="A" & hap11b=="A" & hap21a=="A" & hap22b=="B",5] <- B[hap12a=="A" & hap11b=="A" & hap21a=="A" & hap22b=="B",5] + 0.25
B[hap12a=="A" & hap11b=="A" & hap22a=="A" & hap21b=="B",5] <- B[hap12a=="A" & hap11b=="A" & hap22a=="A" & hap21b=="B",5] + 0.25
B[hap21a=="A" & hap22b=="A" & hap11a=="A" & hap12b=="B",5] <- B[hap21a=="A" & hap22b=="A" & hap11a=="A" & hap12b=="B",5] + 0.25
B[hap21a=="A" & hap22b=="A" & hap12a=="A" & hap11b=="B",5] <- B[hap21a=="A" & hap22b=="A" & hap12a=="A" & hap11b=="B",5] + 0.25
B[hap22a=="A" & hap21b=="A" & hap11a=="A" & hap12b=="B",5] <- B[hap22a=="A" & hap21b=="A" & hap11a=="A" & hap12b=="B",5] + 0.25
B[hap22a=="A" & hap21b=="A" & hap12a=="A" & hap11b=="B",5] <- B[hap22a=="A" & hap21b=="A" & hap12a=="A" & hap11b=="B",5] + 0.25

B[hap11=="AA" & hap12b=="B",6] <- B[hap11=="AA" & hap12b=="B",6] + 0.5
B[hap12=="AA" & hap11b=="B",6] <- B[hap12=="AA" & hap11b=="B",6] + 0.5
B[hap21=="AA" & hap22b=="B",6] <- B[hap21=="AA" & hap22b=="B",6] + 0.5
B[hap22=="AA" & hap21b=="B",6] <- B[hap22=="AA" & hap21b=="B",6] + 0.5

B[hap11=="AA" & hap12a=="A" & hap21b=="B",7] <- B[hap11=="AA" & hap12a=="A" & hap21b=="B",7] + 0.25
B[hap11=="AA" & hap12a=="A" & hap22b=="B",7] <- B[hap11=="AA" & hap12a=="A" & hap22b=="B",7] + 0.25
B[hap12=="AA" & hap11a=="A" & hap21b=="B",7] <- B[hap12=="AA" & hap11a=="A" & hap21b=="B",7] + 0.25
B[hap12=="AA" & hap11a=="A" & hap22b=="B",7] <- B[hap12=="AA" & hap11a=="A" & hap22b=="B",7] + 0.25
B[hap21=="AA" & hap22a=="A" & hap11b=="B",7] <- B[hap21=="AA" & hap22a=="A" & hap11b=="B",7] + 0.25
B[hap21=="AA" & hap22a=="A" & hap12b=="B",7] <- B[hap21=="AA" & hap22a=="A" & hap12b=="B",7] + 0.25
B[hap22=="AA" & hap21a=="A" & hap11b=="B",7] <- B[hap22=="AA" & hap21a=="A" & hap11b=="B",7] + 0.25
B[hap22=="AA" & hap21a=="A" & hap12b=="B",7] <- B[hap22=="AA" & hap21a=="A" & hap12b=="B",7] + 0.25

B[hap11=="AA" & hap21b=="B",8] <- B[hap11=="AA" & hap21b=="B",8] + 0.25
B[hap11=="AA" & hap22b=="B",8] <- B[hap11=="AA" & hap22b=="B",8] + 0.25
B[hap12=="AA" & hap21b=="B",8] <- B[hap12=="AA" & hap21b=="B",8] + 0.25
B[hap12=="AA" & hap22b=="B",8] <- B[hap12=="AA" & hap22b=="B",8] + 0.25
B[hap21=="AA" & hap11b=="B",8] <- B[hap21=="AA" & hap11b=="B",8] + 0.25
B[hap21=="AA" & hap12b=="B",8] <- B[hap21=="AA" & hap12b=="B",8] + 0.25
B[hap22=="AA" & hap11b=="B",8] <- B[hap22=="AA" & hap11b=="B",8] + 0.25
B[hap22=="AA" & hap12b=="B",8] <- B[hap22=="AA" & hap12b=="B",8] + 0.25

B[hap11=="AA" & hap12b=="B" & hap21a=="A",9] <- B[hap11=="AA" & hap12b=="B" & hap21a=="A",9] + 0.25
B[hap11=="AA" & hap12b=="B" & hap22a=="A",9] <- B[hap11=="AA" & hap12b=="B" & hap22a=="A",9] + 0.25
B[hap12=="AA" & hap11b=="B" & hap21a=="A",9] <- B[hap12=="AA" & hap11b=="B" & hap21a=="A",9] + 0.25
B[hap12=="AA" & hap11b=="B" & hap22a=="A",9] <- B[hap12=="AA" & hap11b=="B" & hap22a=="A",9] + 0.25
B[hap21=="AA" & hap22b=="B" & hap11a=="A",9] <- B[hap21=="AA" & hap22b=="B" & hap11a=="A",9] + 0.25
B[hap21=="AA" & hap22b=="B" & hap12a=="A",9] <- B[hap21=="AA" & hap22b=="B" & hap12a=="A",9] + 0.25
B[hap22=="AA" & hap21b=="B" & hap11a=="A",9] <- B[hap22=="AA" & hap21b=="B" & hap11a=="A",9] + 0.25
B[hap22=="AA" & hap21b=="B" & hap12a=="A",9] <- B[hap22=="AA" & hap21b=="B" & hap12a=="A",9] + 0.25

B[hap11=="AB" & hap12b=="A" & hap21a=="A",10] <- B[hap11=="AB" & hap12b=="A" & hap21a=="A",10] + 0.25
B[hap11=="AB" & hap12b=="A" & hap22a=="A",10] <- B[hap11=="AB" & hap12b=="A" & hap22a=="A",10] + 0.25
B[hap12=="AB" & hap11b=="A" & hap21a=="A",10] <- B[hap12=="AB" & hap11b=="A" & hap21a=="A",10] + 0.25
B[hap12=="AB" & hap11b=="A" & hap22a=="A",10] <- B[hap12=="AB" & hap11b=="A" & hap22a=="A",10] + 0.25
B[hap21=="AB" & hap22b=="A" & hap11a=="A",10] <- B[hap21=="AB" & hap22b=="A" & hap11a=="A",10] + 0.25
B[hap21=="AB" & hap22b=="A" & hap12a=="A",10] <- B[hap21=="AB" & hap22b=="A" & hap12a=="A",10] + 0.25
B[hap22=="AB" & hap21b=="A" & hap11a=="A",10] <- B[hap22=="AB" & hap21b=="A" & hap11a=="A",10] + 0.25
B[hap22=="AB" & hap21b=="A" & hap12a=="A",10] <- B[hap22=="AB" & hap21b=="A" & hap12a=="A",10] + 0.25

B[hap11=="AB" & hap12a=="A" & hap21b=="A",11] <- B[hap11=="AB" & hap12a=="A" & hap21b=="A",11] + 0.25
B[hap11=="AB" & hap12a=="A" & hap22b=="A",11] <- B[hap11=="AB" & hap12a=="A" & hap22b=="A",11] + 0.25
B[hap12=="AB" & hap11a=="A" & hap21b=="A",11] <- B[hap12=="AB" & hap11a=="A" & hap21b=="A",11] + 0.25
B[hap12=="AB" & hap11a=="A" & hap22b=="A",11] <- B[hap12=="AB" & hap11a=="A" & hap22b=="A",11] + 0.25
B[hap21=="AB" & hap22a=="A" & hap11b=="A",11] <- B[hap21=="AB" & hap22a=="A" & hap11b=="A",11] + 0.25
B[hap21=="AB" & hap22a=="A" & hap12b=="A",11] <- B[hap21=="AB" & hap22a=="A" & hap12b=="A",11] + 0.25
B[hap22=="AB" & hap21a=="A" & hap11b=="A",11] <- B[hap22=="AB" & hap21a=="A" & hap11b=="A",11] + 0.25
B[hap22=="AB" & hap21a=="A" & hap12b=="A",11] <- B[hap22=="AB" & hap21a=="A" & hap12b=="A",11] + 0.25

B[hap11=="AB" & hap21b=="A",12] <- B[hap11=="AB" & hap21b=="A",12] + 0.25
B[hap11=="AB" & hap22b=="A",12] <- B[hap11=="AB" & hap22b=="A",12] + 0.25
B[hap12=="AB" & hap21b=="A",12] <- B[hap12=="AB" & hap21b=="A",12] + 0.25
B[hap12=="AB" & hap22b=="A",12] <- B[hap12=="AB" & hap22b=="A",12] + 0.25
B[hap21=="AB" & hap11b=="A",12] <- B[hap21=="AB" & hap11b=="A",12] + 0.25
B[hap21=="AB" & hap12b=="A",12] <- B[hap21=="AB" & hap12b=="A",12] + 0.25
B[hap22=="AB" & hap11b=="A",12] <- B[hap22=="AB" & hap11b=="A",12] + 0.25
B[hap22=="AB" & hap12b=="A",12] <- B[hap22=="AB" & hap12b=="A",12] + 0.25

B[hap11a=="A" & hap12b=="B" & hap21b=="A",13] <- B[hap11a=="A" & hap12b=="B" & hap21b=="A",13] + 0.25
B[hap11a=="A" & hap12b=="B" & hap22b=="A",13] <- B[hap11a=="A" & hap12b=="B" & hap22b=="A",13] + 0.25
B[hap12a=="A" & hap11b=="B" & hap21b=="A",13] <- B[hap12a=="A" & hap11b=="B" & hap21b=="A",13] + 0.25
B[hap12a=="A" & hap11b=="B" & hap22b=="A",13] <- B[hap12a=="A" & hap11b=="B" & hap22b=="A",13] + 0.25
B[hap21a=="A" & hap22b=="B" & hap11b=="A",13] <- B[hap21a=="A" & hap22b=="B" & hap11b=="A",13] + 0.25
B[hap21a=="A" & hap22b=="B" & hap12b=="A",13] <- B[hap21a=="A" & hap22b=="B" & hap12b=="A",13] + 0.25
B[hap22a=="A" & hap21b=="B" & hap11b=="A",13] <- B[hap22a=="A" & hap21b=="B" & hap11b=="A",13] + 0.25
B[hap22a=="A" & hap21b=="B" & hap12b=="A",13] <- B[hap22a=="A" & hap21b=="B" & hap12b=="A",13] + 0.25

B[hap11a=="A" & hap12a=="A" & hap21b=="A" & hap22b=="B",14] <- B[hap11a=="A" & hap12a=="A" & hap21b=="A" & hap22b=="B",14] + 0.5
B[hap11a=="A" & hap12a=="A" & hap21b=="B" & hap22b=="A",14] <- B[hap11a=="A" & hap12a=="A" & hap21b=="B" & hap22b=="A",14] + 0.5
B[hap21a=="A" & hap22a=="A" & hap11b=="A" & hap12b=="B",14] <- B[hap21a=="A" & hap22a=="A" & hap11b=="A" & hap12b=="B",14] + 0.5
B[hap21a=="A" & hap22a=="A" & hap11b=="B" & hap12b=="A",14] <- B[hap21a=="A" & hap22a=="A" & hap11b=="B" & hap12b=="A",14] + 0.5

B[hap11a=="A" & hap21b=="A" & hap22b=="B",15] <- B[hap11a=="A" & hap21b=="A" & hap22b=="B",15] + 0.25
B[hap11a=="A" & hap21b=="B" & hap22b=="A",15] <- B[hap11a=="A" & hap21b=="B" & hap22b=="A",15] + 0.25
B[hap21a=="A" & hap11b=="A" & hap12b=="B",15] <- B[hap21a=="A" & hap11b=="A" & hap12b=="B",15] + 0.25
B[hap21a=="A" & hap11b=="B" & hap12b=="A",15] <- B[hap21a=="A" & hap11b=="B" & hap12b=="A",15] + 0.25
B[hap12a=="A" & hap21b=="A" & hap22b=="B",15] <- B[hap12a=="A" & hap21b=="A" & hap22b=="B",15] + 0.25
B[hap12a=="A" & hap21b=="B" & hap22b=="A",15] <- B[hap12a=="A" & hap21b=="B" & hap22b=="A",15] + 0.25
B[hap22a=="A" & hap11b=="A" & hap12b=="B",15] <- B[hap22a=="A" & hap11b=="A" & hap12b=="B",15] + 0.25
B[hap22a=="A" & hap11b=="B" & hap12b=="A",15] <- B[hap22a=="A" & hap11b=="B" & hap12b=="A",15] + 0.25

B[hap11a=="A" & hap12b=="A" & hap21b=="B",16] <- B[hap11a=="A" & hap12b=="A" & hap21b=="B",16] + 0.25
B[hap11a=="A" & hap12b=="A" & hap22b=="B",16] <- B[hap11a=="A" & hap12b=="A" & hap22b=="B",16] + 0.25
B[hap12a=="A" & hap11b=="A" & hap21b=="B",16] <- B[hap12a=="A" & hap11b=="A" & hap21b=="B",16] + 0.25
B[hap12a=="A" & hap11b=="A" & hap22b=="B",16] <- B[hap12a=="A" & hap11b=="A" & hap22b=="B",16] + 0.25
B[hap21a=="A" & hap22b=="A" & hap11b=="B",16] <- B[hap21a=="A" & hap22b=="A" & hap11b=="B",16] + 0.25
B[hap21a=="A" & hap22b=="A" & hap12b=="B",16] <- B[hap21a=="A" & hap22b=="A" & hap12b=="B",16] + 0.25
B[hap22a=="A" & hap21b=="A" & hap11b=="B",16] <- B[hap22a=="A" & hap21b=="A" & hap11b=="B",16] + 0.25
B[hap22a=="A" & hap21b=="A" & hap12b=="B",16] <- B[hap22a=="A" & hap21b=="A" & hap12b=="B",16] + 0.25

B[hap11=="AB" & hap12b=="A",17] <- B[hap11=="AB" & hap12b=="A",17] + 0.5
B[hap12=="AB" & hap11b=="A",17] <- B[hap12=="AB" & hap11b=="A",17] + 0.5
B[hap21=="AB" & hap22b=="A",17] <- B[hap21=="AB" & hap22b=="A",17] + 0.5
B[hap22=="AB" & hap21b=="A",17] <- B[hap22=="AB" & hap21b=="A",17] + 0.5


z <- array(0, dim=c(length(rn), ncol(B), length(tm)))
dimnames(z) <- list(rn, colnames(B), names(tm))
#for(i in seq(along=tm)) {
for(i in 2:2) {
  for(j in seq(along=tm[[i]])) {
    if(j==round(j,-3)) cat(i,j,"\n")
    zr <- rep(0, length(rn))
    names(zr) <- rn
    zr[names(tm[[i]][[j]])] <- tm[[i]][[j]]
    z[j,,i] <- zr %*% B
  }
}


A <- array(dim=c(ncol(B), ncol(B), length(tm)))
dimnames(A) <- list(colnames(B), colnames(B), names(tm))
#for(i in seq(along=tm)) {
for(i in 2:2) {
  cat(i,"\n")
  for(j in 1:ncol(B)) {
    A[,j,i] <- lm(I(z[,j,i]) ~ -1 + B)$coef
  }
}
A[abs(A) < 1e-12] <- 0

#tm05 <- matrix(0,ncol=length(rn), nrow=length(rn))
#dimnames(tm05) <- list(rn,rn)
#for(i in seq(along=tm[[2]]))
#  tm05[i,names(tm[[2]][[i]])] <- tm[[2]][[i]]  
#pi0 <- rep(0, length(rn))
#names(pi0) <- rn
#pi0["AA|BBxCC|DD"] <- 1
#
#pik <- rep(0, 10)
#pik[1] <- pi0 %*% B[,1]
#D <- tm05
#pik[2] <- pi0 %*% tm05 %*% B[,1]
#for(k in 3:10) {
#  D <- D %*% tm05
#  pik[k] <- pi0 %*% D %*% B[,1]
#}
