source("../Calculations/TwolociA4/R/hap.R")
source("../Calculations/TwolociX4/R/female_hap.R")
source("../Calculations/TwolociX4/R/male_hap.R")

r <- seq(0, 0.5, len=251)
#k <- c(0:19, 500)
k <- c(0:6, 500)
hapA <- array(dim=c(length(r), 3, length(k)))
hapXm <- hapXf <- array(dim=c(length(r), 4, length(k)))
dimnames(hapA) <- list(r, c("AA","AB", "AC"), k)
dimnames(hapXf) <- dimnames(hapXm) <- list(r, c("AA","AB", "AC", "CC"), k)
for(i in seq(along=r)) {
  for(j in seq(along=k)) {
    hapA[i,,j] <- hap(r[i], k[j])
    hapXf[i,,j] <- femalehap(r[i], k[j])
    hapXm[i,,j] <- malehap(r[i], k[j])
  }
}
hapA[hapA < 1e-12] <- 0
hapXf[hapXf < 1e-12] <- 0
hapXm[hapXm < 1e-12] <- 0



postscript("../Figs/happrob_fig.eps", height=7.4, width=6.5, pointsize=10, onefile=TRUE, horizontal=FALSE)
par(oma=c(0, 0, 1, 0), mar=c(4.1, 5.1, 3.1, 1.1))

layout(cbind(c(1:3,12), 4:7, 8:11))
par(las=1)
ymx <- c(0.5, 0.25, 1/8, 1)

thecol <- c("red", "orange", "yellow3", "green", "cyan", "blue", "purple", "black")

for(i in 1:3) {
  plot(r, hapA[,i,1], type="l", xlab="recombination fraction", ylim=c(0,ymx[i]),
       ylab="Haplotype probability", 
       xaxs="i", col=thecol[1])
  title(main=colnames(hapA)[i], line=0.5, xpd=TRUE)
  if(i==1) title(main="Autosome", line=2.2, xpd=TRUE)
  for(j in 2:7)
    lines(r, hapA[,i,j], col=thecol[j], lty=ifelse(j==2, 2, 1))
  lines(r, hapA[,i,length(k)], col=thecol[length(thecol)])
}


for(i in 1:4) {
  plot(r, hapXf[,i,1], type="l", xlab="recombination fraction", ylim=c(0,ymx[i]),
       ylab="Haplotype probability", 
       xaxs="i", col=thecol[1])
  title(main=colnames(hapXf)[i], line=0.5, xpd=TRUE)
  if(i==1) title(main="Female X chromosome", line=2.2, xpd=TRUE)
  for(j in 2:7)
    lines(r, hapXf[,i,j], col=thecol[j], lty=ifelse(j==2, 2, 1))
  lines(r, hapXf[,i,length(k)], col=thecol[length(thecol)])
}


for(i in 1:4) {
  plot(r, hapXm[,i,1], type="l", xlab="recombination fraction", ylim=c(0,ymx[i]),
       ylab="Haplotype probability", 
       xaxs="i", col=thecol[1])
  title(main=colnames(hapXm)[i], line=0.5, xpd=TRUE)
  if(i==1) title(main="Male X chromosome", line=2.2, xpd=TRUE)
  for(j in 2:7)
    lines(r, hapXm[,i,j], col=thecol[j], lty=ifelse(j==2, 2, 1))
  lines(r, hapXm[,i,length(k)], col=thecol[length(thecol)])
}

par(mar=rep(0.1, 4))
plot(0,0,bty="n", xlab="", ylab="", xaxt="n", yaxt="n", type="n")
legend("center", lwd=2, col=thecol, lty=c(1,2,1,1,1,1,1,1), seg.len=5,
       c(expression(F[0]),
         expression(F[1]),
         expression(F[2]),
         expression(F[3]),
         expression(F[4]),
         expression(F[5]),
         expression(F[6]),
         expression(F[infinity])))
         

dev.off()
