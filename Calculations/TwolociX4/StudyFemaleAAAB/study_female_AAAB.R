tm <- vector("list", 51)
names(tm) <- seq(0, 0.5, by=0.01)
for(i in 1:51) {
  if(i < 11) j <- paste("0", i-1, sep="")
  else j <- i-1
  tm[[i]] <- as.matrix(read.table(paste("tm4X_", j, ".txt", sep=""), header=TRUE))
}

rn <- rownames(tm[[1]])

female <- sapply(strsplit(rn, "x"), function(a) a[1])
hap1 <- sapply(strsplit(female, "\\|"), function(a) a[1])
hap2 <- sapply(strsplit(female, "\\|"), function(a) a[2])
male <- sapply(strsplit(rn, "x"), function(a) a[2])
hap1a <- sapply(hap1, substr, 1, 1)
hap1b <- sapply(hap1, substr, 2, 2)
hap2a <- sapply(hap2, substr, 1, 1)
hap2b <- sapply(hap2, substr, 2, 2)
malea <- sapply(male, substr, 1, 1)
maleb <- sapply(male, substr, 2, 2)

B <- matrix(0, nrow=ncol(tm[[1]]), ncol=18)
dimnames(B) <- list(rn, c("AA|ABx--", "AA|--xAB", "A-|-AxAB",
                          "AB|--xAA", "A-|-BxAA", "AA|-Bx--",
                          "AB|-Ax--", "A-|ABx-A", "AB|--x-A",
                          "A-|-Bx-A", "AA|A-x-B", "AA|--x-B",
                          "A-|-Ax-B", "AA|-BxA-", "AB|-AxA-",
                          "-B|--xAA", "-A|--xAB", "-A|-BxA-"))

B[(hap1=="AA" & hap2=="AB") | (hap1=="AB" & hap2=="AA"),1] <- 1

B[hap1=="AA" & male=="AB", 2] <- B[hap1=="AA" & male=="AB", 2] + 0.5
B[hap2=="AA" & male=="AB", 2] <- B[hap2=="AA" & male=="AB", 2] + 0.5

B[hap1a=="A" & hap2b=="A" & male=="AB", 3] <- B[hap1a=="A" & hap2b=="A" & male=="AB", 3] + 0.5
B[hap2a=="A" & hap1b=="A" & male=="AB", 3] <- B[hap2a=="A" & hap1b=="A" & male=="AB", 3] + 0.5

B[hap1=="AB" & male=="AA", 4] <- B[hap1=="AB" & male=="AA", 4] + 0.5
B[hap2=="AB" & male=="AA", 4] <- B[hap2=="AB" & male=="AA", 4] + 0.5

B[hap1a=="A" & hap2b=="B" & male=="AA", 5] <- B[hap1a=="A" & hap2b=="B" & male=="AA", 5] + 0.5
B[hap2a=="A" & hap1b=="B" & male=="AA", 5] <- B[hap2a=="A" & hap1b=="B" & male=="AA", 5] + 0.5

B[hap1=="AA" & hap2b=="B", 6] <- B[hap1=="AA" & hap2b=="B", 6] + 0.5
B[hap2=="AA" & hap1b=="B", 6] <- B[hap2=="AA" & hap1b=="B", 6] + 0.5

B[hap1=="AB" & hap2b=="A", 7] <- B[hap1=="AB" & hap2b=="A", 7] + 0.5
B[hap2=="AB" & hap1b=="A", 7] <- B[hap2=="AB" & hap1b=="A", 7] + 0.5

B[hap1a=="A" & hap2=="AB" & maleb=="A", 8] <- B[hap1a=="A" & hap2=="AB" & maleb=="A", 8] + 0.5
B[hap2a=="A" & hap1=="AB" & maleb=="A", 8] <- B[hap2a=="A" & hap1=="AB" & maleb=="A", 8] + 0.5

B[hap1=="AB" & maleb=="A", 9] <- B[hap1=="AB" & maleb=="A", 9] + 0.5
B[hap2=="AB" & maleb=="A", 9] <- B[hap2=="AB" & maleb=="A", 9] + 0.5

B[hap1a=="A" & hap2b=="B" & maleb=="A", 10] <- B[hap1a=="A" & hap2b=="B" & maleb=="A", 10] + 0.5
B[hap2a=="A" & hap1b=="B" & maleb=="A", 10] <- B[hap2a=="A" & hap1b=="B" & maleb=="A", 10] + 0.5

B[hap1=="AA" & hap2a=="A" & maleb=="B", 11] <- B[hap1=="AA" & hap2a=="A" & maleb=="B", 11] + 0.5
B[hap2=="AA" & hap1a=="A" & maleb=="B", 11] <- B[hap2=="AA" & hap1a=="A" & maleb=="B", 11] + 0.5

B[hap1=="AA" & maleb=="B", 12] <- B[hap1=="AA" & maleb=="B", 12] + 0.5
B[hap2=="AA" & maleb=="B", 12] <- B[hap2=="AA" & maleb=="B", 12] + 0.5

B[hap1a=="A" & hap2b=="A" & maleb=="B", 13] <- B[hap1a=="A" & hap2b=="A" & maleb=="B", 13] + 0.5
B[hap2a=="A" & hap1b=="A" & maleb=="B", 13] <- B[hap2a=="A" & hap1b=="A" & maleb=="B", 13] + 0.5

B[hap1=="AA" & hap2b=="B" & malea=="A", 14] <- B[hap1=="AA" & hap2b=="B" & malea=="A", 14] + 0.5
B[hap2=="AA" & hap1b=="B" & malea=="A", 14] <- B[hap2=="AA" & hap1b=="B" & malea=="A", 14] + 0.5

B[hap1=="AB" & hap2b=="A" & malea=="A", 15] <- B[hap1=="AB" & hap2b=="A" & malea=="A", 15] + 0.5
B[hap2=="AB" & hap1b=="A" & malea=="A", 15] <- B[hap2=="AB" & hap1b=="A" & malea=="A", 15] + 0.5

B[hap1b=="B" & male=="AA", 16] <- B[hap1b=="B" & male=="AA", 16] + 0.5
B[hap2b=="B" & male=="AA", 16] <- B[hap2b=="B" & male=="AA", 16] + 0.5

B[hap1b=="A" & male=="AB", 17] <- B[hap1b=="A" & male=="AB", 17] + 0.5
B[hap2b=="A" & male=="AB", 17] <- B[hap2b=="A" & male=="AB", 17] + 0.5

B[hap1b=="A" & hap2b=="B" & malea=="A", 18] <- 1
B[hap2b=="A" & hap1b=="B" & malea=="A", 18] <- 1

A <- array(dim=c(ncol(B), ncol(B), length(tm)))
dimnames(A) <- list(colnames(B), colnames(B), names(tm))
for(i in seq(along=tm)) {
  z <- tm[[i]] %*% B
  for(j in 1:ncol(B))
    A[,j,i] <- lm(I(z[,j]) ~ -1 + B)$coef
}
A[abs(A) < 1e-12] <- 0
