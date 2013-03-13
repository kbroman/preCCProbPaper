source("../Calculations/OnelocusA4/R/onelocusA4.R")
source("../Calculations/OnelocusX4/R/onelocusX4.R")

postscript("../Figs/onelocus_fig.eps", height=7, width=6.5, pointsize=12, onefile=TRUE, horizontal=FALSE)

k <- 0:10

femaleprob <- matrix(ncol=4, nrow=length(k))
for(i in k) femaleprob[i+1,] <- femalek(i)
dimnames(femaleprob) <- list(k, names(femalek(0)))
femaleprob[femaleprob < 1e-12] <- 0

maleprob <- matrix(ncol=2, nrow=length(k))
for(i in k) maleprob[i+1,] <- malek(i)
dimnames(maleprob) <- list(k, names(malek(0)))
maleprob[maleprob < 1e-12] <- 0

indprob <- matrix(ncol=3, nrow=length(k))
for(i in k) indprob[i+1,] <- indk(i)
dimnames(indprob) <- list(k, names(indk(0)))
indprob[indprob < 1e-12] <- 0

par(mfrow=c(3,1))
plot(k, indprob[,1], ylim=c(0,1), type="l", lwd=2,
     xlab=expression(paste("Generation ", F[k])), ylab="Genotype probability",
     yaxs="i", xaxs="i", las=1,
     main="Autosome, random individual")
lines(k, indprob[,2], col="blue", lwd=2)
lines(k, indprob[,3], col="red", lwd=2)
legend("topright", lwd=2, col=c("black", "blue", "red"),
       colnames(indprob))
u <- par("usr")
text(u[1]-diff(u[1:2])*0.07, u[4]+diff(u[3:4])*0.23, "A", font=2, xpd=TRUE, cex=1.3)

plot(k, femaleprob[,1], ylim=c(0,1), type="l", lwd=2,
     xlab=expression(paste("Generation ", F[k])), ylab="Genotype probability",
     yaxs="i", xaxs="i", las=1,
     main="X chromosome, female")
lines(k, femaleprob[,2], col="blue", lwd=2)
lines(k, femaleprob[,3], col="red", lwd=2)
lines(k, femaleprob[,4], col="green", lwd=2)
legend("topright", lwd=2, col=c("black", "blue", "red", "green"),
       colnames(femaleprob))
u <- par("usr")
text(u[1]-diff(u[1:2])*0.07, u[4]+diff(u[3:4])*0.23, "B", font=2, xpd=TRUE, cex=1.3)


plot(k, maleprob[,1], ylim=c(0,1), type="l", lwd=2,
     xlab=expression(paste("Generation ", F[k])), ylab="Genotype probability",
     yaxs="i", xaxs="i", las=1, col="blue",
     main="X chromosome, male")
lines(k, maleprob[,2], col="red", lwd=2)
legend("topright", lwd=2, col=c("blue", "red"),
       colnames(maleprob))
u <- par("usr")
text(u[1]-diff(u[1:2])*0.07, u[4]+diff(u[3:4])*0.23, "C", font=2, xpd=TRUE, cex=1.3)

dev.off()
