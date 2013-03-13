source("map_expansion_func.R")
postscript("../Figs/map_expansion.eps", height=5, width=6.5, pointsize=12, onefile=TRUE, horizontal=FALSE)

maxgen <- 20
par(las=1)
par(mar=c(5.1,4.1,2.1,1.1))
plot(0:maxgen, c(0,meself2(1:maxgen)), xlab=expression(paste("Generation ", F[k])),
     ylab="Map expansion",
     type="l", lwd=2, col="blue",
     xaxs="i", yaxs="i", ylim=c(0, 7), lty=2)
axis(side=1, at=c(1:4, 6:9, 11:14, 16:19, 21:24), labels=rep("",20), tck=-0.015)
lines(0:maxgen, c(0, meself4(1:maxgen)), col="red", lwd=2, lty=2)
lines(0:maxgen, c(0, meself8(1:maxgen)), col="black", lwd=2,lty=2)
text(17.0, mesibA8(17)-0.1, "Eight-way", col="black", adj=c(0,1))
text(17.0, mesibA4(17)-0.1, "Four-way",  col="red",   adj=c(0,1))
text(17.0, mesibA2(17)-0.1, "Two-way",   col="blue",  adj=c(0,1))

lines(0:maxgen, mesibA2(0:maxgen), lwd=2, col="blue")
lines(0:maxgen, mesibA4(0:maxgen), lwd=2, col="red")
lines(0:maxgen, mesibA8(0:maxgen), lwd=2, col="black")

legend("bottomright", lwd=2, lty=1:2, c("Sib-mating", "Selfing"))

dev.off()
