self <- function(k) 1-(1/2)^(k-1)

sibA <- 
function(k, nstr=c("2","4")) {
  nstr <- match.arg(nstr)
  if(nstr=="2")
    return(2*((1/2) + (1/5)*(1/4)^k - ((7-3*sqrt(5))/20)*((1-sqrt(5))/4)^k - ((7+3*sqrt(5))/20)*((1+sqrt(5))/4)^k))
  
  (4*(1/4 + (1/4)*(1/2)^k - (1/20)*(1/4)^k - ((9-4*sqrt(5))/40)*((1-sqrt(5))/4)^k - ((9+4*sqrt(5))/40)*((1+sqrt(5))/4)^k))
}

sibX <- 
function(k, nstr=c("2","4")) {
  nstr <- match.arg(nstr)
  if(nstr=="2")
    return(2/3 + (1/12)*(-1/2)^k-(1/4)*(1/2)^k-((5-3*sqrt(5))/20)*((1-sqrt(5))/4)^k-((5+3*sqrt(5))/20)*((1+sqrt(5))/4)^k + 1/3+(-1/12)*(-1/2)^k+(1/4)*(1/2)^k-((5-3*sqrt(5))/20)*((1-sqrt(5))/4)^k-((5+3*sqrt(5))/20)*((1+sqrt(5))/4)^k)

2*(  1/3+(1/24)*(-1/2)^k + (1/8)*(1/2)^k - ((5-2*sqrt(5))/20)*((1-sqrt(5))/4)^k - ((5+2*sqrt(5))/20)*((1+sqrt(5))/4)^k) +
  1/3 - (1/12)*(-1/2)^k + (1/4)*(1/2)^k - ((5-3*sqrt(5))/20)*((1-sqrt(5))/4)^k-((5+3*sqrt(5))/20)*((1+sqrt(5))/4)^k

}


postscript("../Figs/fixation_time.eps", height=5, width=6.5, pointsize=10, onefile=TRUE, horizontal=FALSE)

maxgen <- 20
par(las=1, mfrow=c(2,1))
par(mar=c(5.1,4.1,2.1,1.1))
plot(0:maxgen, c(0,self(1:maxgen)), xlab=expression(paste("Generation ", F[k])),
     ylab=expression(paste("Pr( fixed  by  ", F[k], " )")),
     type="l", lwd=2, col="green",
     xaxs="i", yaxs="i", ylim=c(0, 1))
axis(side=1, at=c(1:4, 6:9, 11:14, 16:19, 21:24), labels=rep("",20), tck=-0.03)
lines(0:maxgen, sibA(0:maxgen, "2"), lwd=2, col="blue")
lines(0:maxgen, sibX(0:maxgen, "2"), lwd=2, col="blue", lty=2)
lines(0:maxgen, sibA(0:maxgen, "4"), lwd=2, col="red")
lines(0:maxgen, sibX(0:maxgen, "4"), lwd=2, col="red", lty=2)
legend("bottomright",
       c("selfing", "2-way, sib-mating, X chr", "2-way, sib-mating, autosome", 
         "4-way, sib-mating, X chr", "4-way, sib-mating, autosome"), lwd=2,
       col=c("green", "blue", "blue", "red", "red"), lty=c(1,2,1,2,1))
u <- par("usr")
text(u[1]-diff(u[1:2])*0.1, u[4]+diff(u[3:4])*0.16, "A", font=2, xpd=TRUE, cex=1.3)

par(mar=c(4.6,4.1,2.6,1.1))
plot(0:maxgen, c(0,0,self(2:maxgen)-self(1:(maxgen-1))), xlab=expression(paste("Generation ", F[k])),
     ylab=expression(paste("Pr( fixed  at  ", F[k], " )")),
     type="l", lwd=2, col="green",
     xaxs="i", yaxs="i", xlim=c(0,maxgen))
axis(side=1, at=c(1:4, 6:9, 11:14, 16:19, 21:24), labels=rep("",20), tck=-0.03)
lines(0:maxgen, c(0,0,sibA(2:maxgen, "2") - sibA(1:(maxgen-1), "2")), lwd=2, col="blue")
lines(0:maxgen, c(0,0,sibX(2:maxgen, "2") - sibX(1:(maxgen-1), "2")), lwd=2, col="blue", lty=2)
lines(0:maxgen, c(0,0,sibA(2:maxgen, "4") - sibA(1:(maxgen-1), "4")), lwd=2, col="red")
lines(0:maxgen, c(0,0,sibX(2:maxgen, "4") - sibX(1:(maxgen-1), "4")), lwd=2, col="red", lty=2)
#legend("topright",
#       c("selfing", "2-way, sib-mating, X chr", "2-way, sib-mating, autosome", 
#         "4-way, sib-mating, X chr", "4-way, sib-mating, autosome"), lwd=2,
#       col=c("green", "blue", "blue", "red", "red"), lty=c(1,2,1,2,1))
u <- par("usr")
text(u[1]-diff(u[1:2])*0.1, u[4]+diff(u[3:4])*0.16, "B", font=2, xpd=TRUE, cex=1.3)
dev.off()
