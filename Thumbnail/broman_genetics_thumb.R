source("../R/rifig_func.R")
png("broman_genetics_thumb_big.png", height=1200, width=1200, res=288)

color <- c(rgb(240,240,  0,maxColorValue=255),
           rgb(128,128,128,maxColorValue=255),
           rgb(240,128,128,maxColorValue=255),
           rgb( 16, 16,240,maxColorValue=255),
           rgb(  0,160,240,maxColorValue=255),
           rgb(  0,160,  0,maxColorValue=255),
           rgb(240,  0,  0,maxColorValue=255),
           rgb(144,  0,224,maxColorValue=255))

par(mar=rep(0,4))
plot(0,0,xlim=c(-50,869),ylim=c(25,485),xaxt="n",yaxt="n",xlab="",ylab="",type="n")
u <- par("usr")
abline(v=u[1:2], h=u[3:4], lwd=5, lend=1, ljoin=1)
#mtext("Eight-way RIL by sibling mating",side=3,line=0.5)
#u <- par("usr")
#mtext(side=3,adj=0,line=0.5,"D",font=2)

u <- par("usr")
u[1] <- u[1]+10
text(u[1]/1.2,460,expression(G[0]),adj=c(0,0.5),cex=1.0)

xloc <- 10
for(i in 1:8) {
  rect(xloc-2,480,xloc+10,440,col=color[i],border=color[i], lend=1, ljoin=1)
  rect(xloc+28,480,xloc+40,440,col=color[i],border=color[i], lend=1, ljoin=1)
  text(xloc+19,430,LETTERS[i],adj=c(0.5,1),cex=1.0, lend=1, ljoin=1)

  if((i %% 2)==0) {
    points(xloc-27.5,460,pch=4,cex=0.7)
    arrows(xloc-27.5,445,xloc-27.5,410,len=0.04)
  }

  rect(xloc-2,480,xloc+10,440, lend=1, ljoin=1)
  rect(xloc+28,480,xloc+40,440,lend=1, ljoin=1)

  xloc <- xloc+38+55
  if((i %% 2)==0) xloc <- xloc+50
}

xloc <- 10+38+55-27.5
xxloc <- NULL
for(i in 1:4) {
  xxloc <- c(xxloc,xloc)
  rect(xloc-21,400,xloc- 9,360,col=color[2*i-1],border=color[2*i-1], lend=1, ljoin=1)
  rect(xloc+ 9,400,xloc+21,360,col=color[2*i],border=color[2*i], lend=1, ljoin=1)
  rect(xloc-21,400,xloc- 9,360,lend=1, ljoin=1)
  rect(xloc+ 9,400,xloc+21,360,lend=1, ljoin=1)
  xloc <- xloc+(38+55)*2+50
}
xxloc <- c(mean(xxloc[1:2]),mean(xxloc[3:4]))
points(xxloc[1],380,pch=4,cex=0.7)
arrows(xxloc[1],365,xxloc[1],330,len=0.04)
points(xxloc[2],380,pch=4,cex=0.7)
arrows(xxloc[2],365,xxloc[2],330,len=0.04)
text(u[1]/1.2,380,expression(G[1]),adj=c(0,0.5),cex=1.0)

file <- "../R/risib8w_sim.RData"
if(!file.exists(file)) {
  f1 <- vector("list",4)
  for(i in 1:4) f1[[i]] <- create.par(100,c(2*i-1,2*i))
  set.seed(112115+38)
  f2a <- cross(f1[[1]],f1[[2]],m=10,obl=TRUE)
  f2b <- cross(f1[[3]],f1[[4]],m=10,obl=TRUE)
  f3a <- cross(f2a,f2b,m=10,obl=TRUE)
  f3b <- cross(f2a,f2b,m=10,obl=TRUE)
  f4a <- cross(f3a,f3b,m=10,obl=TRUE)
  f4b <- cross(f3a,f3b,m=10,obl=TRUE)
  temp <- list(f4a,f4b)
  for(i in 1:60) {
    fa <- cross(temp[[1]],temp[[2]],m=10,obl=TRUE)
    fb <- cross(temp[[1]],temp[[2]],m=10,obl=TRUE)
    temp <- list(fa,fb)
  }
  save(f1,f2a,f2b,f3a,f3b,f4a,f4b,fa,file=file)
} else load(file)

rect(xxloc[1]-21,320,xxloc[1]- 9,280,col=color[1],border=color[1], lend=1, ljoin=1)
rect(xxloc[1]+ 9,320,xxloc[1]+21,280,col=color[3],border=color[3], lend=1, ljoin=1)
rect(xxloc[2]-21,320,xxloc[2]- 9,280,col=color[5],border=color[5], lend=1, ljoin=1)
rect(xxloc[2]+ 9,320,xxloc[2]+21,280,col=color[7],border=color[7], lend=1, ljoin=1)

mult <- 40/f2a$mat[1,ncol(f2a$mat)]
temp <- f2a$mat
for(j in 2:ncol(temp)) {
  if(temp[2,j]==2)
    rect(xxloc[1]-21,280+temp[1,j]*mult,xxloc[1]-9,280+temp[1,j-1]*mult,
         col=color[2],border=color[2], lend=1, ljoin=1)
}
temp <- f2a$pat
for(j in 2:ncol(temp)) {
  if(temp[2,j]==4)
    rect(xxloc[1]+ 9,280+temp[1,j]*mult,xxloc[1]+21,280+temp[1,j-1]*mult,
         col=color[4],border=color[4], lend=1, ljoin=1)
}
temp <- f2b$mat
for(j in 2:ncol(temp)) {
  if(temp[2,j]==6)
    rect(xxloc[2]-21,280+temp[1,j]*mult,xxloc[2]-9,280+temp[1,j-1]*mult,
         col=color[6],border=color[6], lend=1, ljoin=1)
}
temp <- f2b$pat
for(j in 2:ncol(temp)) {
  if(temp[2,j]==8)
    rect(xxloc[2]+9,280+temp[1,j]*mult,xxloc[2]+21,280+temp[1,j-1]*mult,
         col=color[8],border=color[8], lend=1, ljoin=1)
}

rect(xxloc[1]-21,320,xxloc[1]- 9,280,lend=1, ljoin=1)
rect(xxloc[1]+ 9,320,xxloc[1]+21,280,lend=1, ljoin=1)
rect(xxloc[2]-21,320,xxloc[2]- 9,280,lend=1, ljoin=1)
rect(xxloc[2]+ 9,320,xxloc[2]+21,280,lend=1, ljoin=1)

text(u[1]/1.2,300,expression(G[2]),adj=c(0,0.5),cex=1.0)
xxloc <- mean(xxloc)
points(xxloc,300,pch=4,cex=0.7)
segments(xxloc,285,xxloc,265)
segments(xxloc-39,265,xxloc+39,265)
arrows(xxloc+39*c(-1,1),265,xxloc+39*c(-1,1),245,len=0.04)


rect(xxloc-60,235,xxloc-48,195,col=color[1],border=color[1], lend=1, ljoin=1)
rect(xxloc-32,235,xxloc-20,195,col=color[5],border=color[5], lend=1, ljoin=1)
rect(xxloc+20,235,xxloc+32,195,col=color[1],border=color[1], lend=1, ljoin=1)
rect(xxloc+48,235,xxloc+60,195,col=color[5],border=color[5], lend=1, ljoin=1)

temp <- f3a$mat
for(j in 2:ncol(temp)) {
  if(temp[2,j]!=1)
    rect(xxloc-60,195+temp[1,j]*mult,xxloc-48,195+temp[1,j-1]*mult,
         col=color[temp[2,j]],border=color[temp[2,j]], lend=1, ljoin=1)
}
temp <- f3a$pat
for(j in 2:ncol(temp)) {
  if(temp[2,j]!=5)
    rect(xxloc-32,195+temp[1,j]*mult,xxloc-20,195+temp[1,j-1]*mult,
         col=color[temp[2,j]],border=color[temp[2,j]], lend=1, ljoin=1)
}
temp <- f3b$mat
for(j in 2:ncol(temp)) {
  if(temp[2,j]!=1)
    rect(xxloc+20,195+temp[1,j]*mult,xxloc+32,195+temp[1,j-1]*mult,
         col=color[temp[2,j]],border=color[temp[2,j]], lend=1, ljoin=1)
}
temp <- f3b$pat
for(j in 2:ncol(temp)) {
  if(temp[2,j]!=5)
    rect(xxloc+48,195+temp[1,j]*mult,xxloc+60,195+temp[1,j-1]*mult,
         col=color[temp[2,j]],border=color[temp[2,j]], lend=1, ljoin=1)
}
rect(xxloc-60,235,xxloc-48,195,lend=1, ljoin=1)
rect(xxloc-32,235,xxloc-20,195,lend=1, ljoin=1)
rect(xxloc+20,235,xxloc+32,195,lend=1, ljoin=1)
rect(xxloc+48,235,xxloc+60,195,lend=1, ljoin=1)

text(u[1]/1.2,215,expression(paste(G[2], ":", F[1])),adj=c(0,0.5),cex=1.0)
points(xxloc,215,pch=4,cex=0.7)
segments(xxloc,200,xxloc,180)
segments(xxloc-39,180,xxloc+39,180)
arrows(xxloc+39*c(-1,1),180,xxloc+39*c(-1,1),160,len=0.04)


rect(xxloc-60,150,xxloc-48,110,col=color[1],border=color[1], lend=1, ljoin=1)
rect(xxloc-32,150,xxloc-20,110,col=color[1],border=color[1], lend=1, ljoin=1)
rect(xxloc+20,150,xxloc+32,110,col=color[1],border=color[1], lend=1, ljoin=1)
rect(xxloc+48,150,xxloc+60,110,col=color[1],border=color[1], lend=1, ljoin=1)

temp <- f4a$mat
for(j in 2:ncol(temp)) {
  if(temp[2,j]!=1)
    rect(xxloc-60,110+temp[1,j]*mult,xxloc-48,110+temp[1,j-1]*mult,
         col=color[temp[2,j]],border=color[temp[2,j]], lend=1, ljoin=1)
}
temp <- f4a$pat
for(j in 2:ncol(temp)) {
  if(temp[2,j]!=1)
    rect(xxloc-32,110+temp[1,j]*mult,xxloc-20,110+temp[1,j-1]*mult,
         col=color[temp[2,j]],border=color[temp[2,j]], lend=1, ljoin=1)
}
temp <- f4b$mat
for(j in 2:ncol(temp)) {
  if(temp[2,j]!=1)
    rect(xxloc+20,110+temp[1,j]*mult,xxloc+32,110+temp[1,j-1]*mult,
         col=color[temp[2,j]],border=color[temp[2,j]], lend=1, ljoin=1)
}
temp <- f4b$pat
for(j in 2:ncol(temp)) {
  if(temp[2,j]!=1)
    rect(xxloc+48,110+temp[1,j]*mult,xxloc+60,110+temp[1,j-1]*mult,
         col=color[temp[2,j]],border=color[temp[2,j]], lend=1, ljoin=1)
}
rect(xxloc-60,150,xxloc-48,110,lend=1, ljoin=1)
rect(xxloc-32,150,xxloc-20,110,lend=1, ljoin=1)
rect(xxloc+20,150,xxloc+32,110,lend=1, ljoin=1)
rect(xxloc+48,150,xxloc+60,110,lend=1, ljoin=1)

text(u[1]/1.2,130,expression(paste(G[2], ":", F[2])),adj=c(0,0.5),cex=1.0)
points(xxloc,130,pch=4,cex=0.7)
arrows(xxloc,82,xxloc,75,len=0.04)
arrows(xxloc,115,xxloc,75,len=0.04,lty=3)

points(rep(u[1]/1.2+10,3),c(-8,0,8)+mean(c(140,65/2)),pch=16,cex=0.2)
a <- 25
text(u[1]/1.2,(65+a)/2,expression(paste(G[2], ":", F[infinity])),adj=c(0,0.5),cex=1.0)
mult <- (65-a)/fa$mat[1,ncol(fa$mat)]
rect(xxloc+21*c(-1,1),rep(65,2),xxloc+9*c(-1,1),rep(a,2),col=color[1],border=color[1], lend=1, ljoin=1)
temp <- fa$mat
for(j in 2:ncol(fa$mat)) {
  if(temp[2,j]!=1)
    rect(xxloc+21*c(-1,1),rep(a,2)+temp[1,j]*mult,xxloc+9*c(-1,1),rep(a,2)+temp[1,j-1]*mult,
         col=color[temp[2,j]],border=color[temp[2,j]], lend=1, ljoin=1)
}
rect(xxloc+21*c(-1,1),rep(65,2),xxloc+9*c(-1,1),rep(a,2),lend=1, ljoin=1)

dev.off()
