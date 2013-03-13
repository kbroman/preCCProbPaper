source("rifig_func.R")
######################################################################
# figure 1: 2-, 4- and 8-way RILs
######################################################################
postscript("../Figs/rifig.eps", height=8, width=6.5, pointsize=10, onefile=TRUE, horizontal=FALSE)

color <- c(rgb(240,240,  0,maxColorValue=255),
           rgb(128,128,128,maxColorValue=255),
           rgb(240,128,128,maxColorValue=255),
           rgb( 16, 16,240,maxColorValue=255),
           rgb(  0,160,240,maxColorValue=255),
           rgb(  0,160,  0,maxColorValue=255),
           rgb(240,  0,  0,maxColorValue=255),
           rgb(144,  0,224,maxColorValue=255))

par(mfrow=c(2,2))

######################################################################
# A: 2-way selfing
######################################################################
file <- "riself_sim.RData"
if(!file.exists(file)) {
  f1 <- create.par(100,c(1,2))
  set.seed(3312238+7)
  f2 <- vector("list",4)
  for(i in 1:4) f2[[i]] <- cross(f1,f1,m=10,obl=TRUE)
  f3 <- vector("list",4)
  for(i in 1:4) 
    f3[[i]] <- cross(f2[[i]],f2[[i]],m=10,obl=TRUE)
  f4 <- vector("list",4)
  for(i in 1:4)
    f4[[i]] <- cross(f3[[i]],f3[[i]],m=10,obl=TRUE)
  temp <- f4
  my.ri8 <- vector("list",4)
  for(j in 1:60) {
    for(i in 1:4) {
      my.ri8[[i]] <- cross(temp[[i]],temp[[i]],m=10,obl=TRUE)
    }
    temp <- my.ri8
  }
  save(f1,f2,f3,f4,my.ri8,file=file)
} else load(file)

par(mar=c(0.6,0.1,2.1,1.1),las=1,fg="black",col="black",col.axis="black",col.lab="black",
    bg="white")
plot(0,0,xlim=c(-40,864),ylim=c(30,480),xaxt="n",yaxt="n",xlab="",ylab="",type="n")
mtext("Two-way RIL by selfing",side=3,line=0.5)
u <- par("usr")
mtext(side=3,adj=0,line=0.5,"A",font=2)

rect(c(300,326),c(480,480),c(312,338),c(440,440),col=color[1],border=color[1], lend=1, ljoin=1)
rect(c(526,552),c(480,480),c(538,564),c(440,440),col=color[5],border=color[5], lend=1, ljoin=1)
points(432,465,pch=4,cex=1.0)
arrows(432,450,432,410,len=0.04)
text(300-25,460,expression(A),adj=c(1,0.5),cex=1.0)
text(564+25,460,expression(B),adj=c(0,0.5),cex=1.0)
text(u[1]/1.2,460,expression(F[0]),adj=c(0,0.5),cex=1.0)
rect(c(300,326),c(480,480),c(312,338),c(440,440), lend=1, ljoin=1)
rect(c(526,552),c(480,480),c(538,564),c(440,440), lend=1, ljoin=1)

rect(413,400,425,360,col=color[1],border=color[1], lend=1, ljoin=1)
rect(439,400,451,360,col=color[5],border=color[5], lend=1, ljoin=1)
rect(413,400,425,360, lend=1, ljoin=1)
rect(439,400,451,360, lend=1, ljoin=1)

text(u[1]/1.2,380,expression(F[1]),adj=c(0,0.5),cex=1.0)
segments(432,360,432,350)
segments(92,350,772,350)
arrows(c(319,545,92,772),rep(350,4),c(319,545,92,772),rep(330,4),len=0.04)

xloc <- 92
mult <- 40/f2[[1]]$mat[1,ncol(f2[[1]]$mat)]
for(i in 1:4) {
  rect(xloc-19,320,xloc-7,280,col=color[1],border=color[1], lend=1, ljoin=1)
  rect(xloc+7,320,xloc+19,280,col=color[1],border=color[1], lend=1, ljoin=1)

  f2m <- f2[[i]]$mat
  for(j in 2:ncol(f2m)) {
    if(f2m[2,j]==2)
      rect(xloc-19,280+f2m[1,j]*mult,xloc-7,280+f2m[1,j-1]*mult,col=color[5],border=color[5], lend=1, ljoin=1)
  }

  f2m <- f2[[i]]$pat
  for(j in 2:ncol(f2m)) {
    if(f2m[2,j]==2)
      rect(xloc+7,280+f2m[1,j]*mult,xloc+19,280+f2m[1,j-1]*mult,col=color[5],border=color[5], lend=1, ljoin=1)
  }

  rect(xloc-19,320,xloc-7,280, lend=1, ljoin=1)
  rect(xloc+7,320,xloc+19,280, lend=1, ljoin=1)

  xloc <- xloc+227
}
text(u[1]/1.2,300,expression(F[2]),adj=c(0,0.5),cex=1.0)

arrows(c(319,545,92,772),rep(270,4),c(319,545,92,772),rep(250,4),len=0.04)

xloc <- 92
mult <- 40/f2[[1]]$mat[1,ncol(f2[[1]]$mat)]
for(i in 1:4) {
  rect(xloc-19,240,xloc-7,200,col=color[1],border=color[1], lend=1, ljoin=1)
  rect(xloc+7,240,xloc+19,200,col=color[1],border=color[1], lend=1, ljoin=1)

  f2m <- f3[[i]]$mat
  for(j in 2:ncol(f2m)) {
    if(f2m[2,j]==2)
      rect(xloc-19,200+f2m[1,j]*mult,xloc-7,200+f2m[1,j-1]*mult,col=color[5],border=color[5], lend=1, ljoin=1)
  }

  f2m <- f3[[i]]$pat
  for(j in 2:ncol(f2m)) {
    if(f2m[2,j]==2)
      rect(xloc+7,200+f2m[1,j]*mult,xloc+19,200+f2m[1,j-1]*mult,col=color[5],border=color[5], lend=1, ljoin=1)
  }

  rect(xloc-19,240,xloc-7,200,lend=1, ljoin=1)
  rect(xloc+7,240,xloc+19,200,lend=1, ljoin=1)

  xloc <- xloc+227
}
text(u[1]/1.2,220,expression(F[3]),adj=c(0,0.5),cex=1.0)
arrows(c(319,545,92,772),rep(190,4),c(319,545,92,772),rep(170,4),len=0.04)

xloc <- 92
mult <- 40/f2[[1]]$mat[1,ncol(f2[[1]]$mat)]
for(i in 1:4) {
  rect(xloc-19,160,xloc-7,120,col=color[1],border=color[1], lend=1, ljoin=1)
  rect(xloc+7,160,xloc+19,120,col=color[1],border=color[1], lend=1, ljoin=1)

  f2m <- f4[[i]]$mat
  for(j in 2:ncol(f2m)) {
    if(f2m[2,j]==2)
      rect(xloc-19,120+f2m[1,j]*mult,xloc-7,120+f2m[1,j-1]*mult,col=color[5],border=color[5], lend=1, ljoin=1)
  }

  f2m <- f4[[i]]$pat
  for(j in 2:ncol(f2m)) {
    if(f2m[2,j]==2)
      rect(xloc+7,120+f2m[1,j]*mult,xloc+19,120+f2m[1,j-1]*mult,col=color[5],border=color[5], lend=1, ljoin=1)
  }

  rect(xloc-19,160,xloc-7,120,lend=1, ljoin=1)
  rect(xloc+7,160,xloc+19,120,lend=1, ljoin=1)

  xloc <- xloc+227
}
text(u[1]/1.2,140,expression(F[4]),adj=c(0,0.5),cex=1.0)
arrows(c(319,545,92,772),rep(87,4),c(319,545,92,772),rep(80,4),len=0.04)
arrows(c(319,545,92,772),rep(110,4),c(319,545,92,772),rep(80,4),len=0.04,lty=3)

xloc <- 38
a <- 70-40
mult <- (70-a)/f2[[1]]$mat[1,ncol(f2[[1]]$mat)]
for(i in 1:4) {
  rect(xloc+54-19,70,xloc+54-7,a,col=color[1],border=color[1], lend=1, ljoin=1)
  rect(xloc+54+7,70,xloc+54+19,a,col=color[1],border=color[1], lend=1, ljoin=1)

  my.ri8m <- my.ri8[[i]]$mat
  for(j in 2:ncol(my.ri8m)) {
    if(my.ri8m[2,j]==2)
      rect(xloc+54-19,a+my.ri8m[1,j]*mult,xloc+54-7,a+my.ri8m[1,j-1]*mult,
           col=color[5],border=color[5], lend=1, ljoin=1)
  }
  my.ri8p <- my.ri8[[i]]$pat
  for(j in 2:ncol(my.ri8p)) {
    if(my.ri8p[2,j]==2)
      rect(xloc+54+7,a+my.ri8p[1,j]*mult,xloc+54+19,a+my.ri8p[1,j-1]*mult,
           col=color[5],border=color[5], lend=1, ljoin=1)
  }

  rect(xloc+54-19,70,xloc+54-7,a,lend=1, ljoin=1)
  rect(xloc+54+7,70,xloc+54+19,a,lend=1, ljoin=1)

  xloc <- xloc+227
}
text(u[1]/1.2,(70+a)/2,expression(F[infinity]),adj=c(0,0.5),cex=1.0)
points(rep(u[1]/1.2+10,3),c(-8,0,8)+mean(c(140,(70+a)/2)),pch=16,cex=0.2)



######################################################################
# B: 2-way sib-mating
######################################################################
par(mar=c(0.6,1.1,2.1,0.1))
plot(0,0,xlim=c(-40,864),ylim=c(30,480),xaxt="n",yaxt="n",xlab="",ylab="",type="n")
mtext("Two-way RIL by sibling mating",side=3,line=0.5)
u <- par("usr")
mtext(side=3,adj=0,line=0.5,"B",font=2)

rect(c(300,326),c(480,480),c(312,338),c(440,440),col=color[1],border=color[1], lend=1, ljoin=1)
rect(c(526,552),c(480,480),c(538,564),c(440,440),col=color[5],border=color[5], lend=1, ljoin=1)
rect(c(300,326),c(480,480),c(312,338),c(440,440),lend=1, ljoin=1)
rect(c(526,552),c(480,480),c(538,564),c(440,440),lend=1, ljoin=1)
points(432,465,pch=4,cex=0.7)
segments(432,450,432,430)
segments(319,430,545,430)
arrows(c(319,545),c(430,430),c(319,545),c(410,410),len=0.04)
text(300-25,460,expression(A),adj=c(1,0.5),cex=1.0)
text(564+25,460,expression(B),adj=c(0,0.5),cex=1.0)
text(u[1]/1.2,460,expression(F[0]),adj=c(0,0.5),cex=1.0)

rect(300,400,312,360,col=color[1],border=color[1], lend=1, ljoin=1)
rect(526,400,538,360,col=color[1],border=color[1], lend=1, ljoin=1)
rect(326,400,338,360,col=color[5],border=color[5], lend=1, ljoin=1)
rect(552,400,564,360,col=color[5],border=color[5], lend=1, ljoin=1)
rect(300,400,312,360,lend=1, ljoin=1)
rect(526,400,538,360,lend=1, ljoin=1)
rect(326,400,338,360,lend=1, ljoin=1)
rect(552,400,564,360,lend=1, ljoin=1)
text(u[1]/1.2,380,expression(F[1]),adj=c(0,0.5),cex=1.0)
points(432,385,pch=4,cex=0.7)
segments(432,370,432,350)

file <- "risib2w_sim.RData"
if(!file.exists(file)) {
  f1 <- create.par(100,c(1,2))
  set.seed(9943123)
  f2 <- vector("list",10)
  for(i in 1:10) f2[[i]] <- cross(f1,f1,m=10,obl=TRUE)
  f3 <- vector("list",10)
  for(i in 1:5) {
    f3[[2*i-1]] <- cross(f2[[2*i-1]],f2[[2*i]],m=10,obl=TRUE)
    f3[[2*i]] <- cross(f2[[2*i-1]],f2[[2*i]],m=10,obl=TRUE)
  }
  f4 <- vector("list",10)
  for(i in 1:5) {
    f4[[2*i-1]] <- cross(f3[[2*i-1]],f3[[2*i]],m=10,obl=TRUE)
    f4[[2*i]] <- cross(f3[[2*i-1]],f3[[2*i]],m=10,obl=TRUE)
  }
  temp <- f4
  my.ri8 <- vector("list",10)
  for(j in 1:60) {
    for(i in 1:5) {
      my.ri8[[2*i-1]] <- cross(temp[[2*i-1]],temp[[2*i]],m=10,obl=TRUE)
      my.ri8[[2*i]] <- cross(temp[[2*i-1]],temp[[2*i]],m=10,obl=TRUE)
    }
    temp <- my.ri8
  }
  save(f1,f2,f3,f4,my.ri8,file=file)
} else load(file)

xloc <- 38
mult <- 40/f2[[1]]$mat[1,ncol(f2[[1]]$mat)]
xxloc <- NULL
for(i in 1:4) {
  rect(xloc-6,320,xloc+6,280,col=color[1],border=color[1], lend=1, ljoin=1)
  rect(xloc+20,320,xloc+32,280,col=color[1],border=color[1], lend=1, ljoin=1)
  rect(xloc+76,320,xloc+88,280,col=color[1],border=color[1], lend=1, ljoin=1)
  rect(xloc+102,320,xloc+114,280,col=color[1],border=color[1], lend=1, ljoin=1)

  f2m <- f2[[2*i-1]]$mat
  for(j in 2:ncol(f2m)) {
    if(f2m[2,j]==2)
      rect(xloc-6,280+f2m[1,j]*mult,xloc+6,280+f2m[1,j-1]*mult,col=color[5],border=color[5], lend=1, ljoin=1)
  }
  f2p <- f2[[2*i-1]]$pat
  for(j in 2:ncol(f2p)) {
    if(f2p[2,j]==2)
      rect(xloc+20,280+f2p[1,j]*mult,xloc+32,280+f2p[1,j-1]*mult,col=color[5],border=color[5], lend=1, ljoin=1)
  }

  f2m <- f2[[2*i]]$mat
  for(j in 2:ncol(f2m)) {
    if(f2m[2,j]==2)
      rect(xloc+76,280+f2m[1,j]*mult,xloc+88,280+f2m[1,j-1]*mult,col=color[5],border=color[5], lend=1, ljoin=1)
  }
  f2p <- f2[[2*i]]$pat
  for(j in 2:ncol(f2p)) {
    if(f2p[2,j]==2)
      rect(xloc+102,280+f2p[1,j]*mult,xloc+114,280+f2p[1,j-1]*mult,col=color[5],border=color[5], lend=1, ljoin=1)
  }

  rect(xloc-6,320,xloc+6,280,    lend=1, ljoin=1)
  rect(xloc+20,320,xloc+32,280,  lend=1, ljoin=1)
  rect(xloc+76,320,xloc+88,280,  lend=1, ljoin=1)
  rect(xloc+102,320,xloc+114,280,lend=1, ljoin=1)

  xxloc <- c(xxloc,xloc+(6+20)/2,xloc+(88+102)/2)

  points(xloc+54,300,pch=4,cex=0.7)
  segments(xloc+54,290,xloc+54,270)
  segments(xxloc[2*i-1],270,xxloc[2*i],270)
  
  xloc <- xloc+78+120+30
}

segments(min(xxloc),350,max(xxloc),350)
arrows(xxloc,c(350,350),xxloc,c(330,330),len=0.04)
text(u[1]/1.2,300,expression(F[2]),adj=c(0,0.5),cex=1.0)
arrows(xxloc,270,xxloc,250,len=0.04)

xloc <- 38
for(i in 1:4) {
  rect(xloc-6,240,xloc+6,200,col=color[1],border=color[1], lend=1, ljoin=1)
  rect(xloc+20,240,xloc+32,200,col=color[1],border=color[1], lend=1, ljoin=1)
  rect(xloc+76,240,xloc+88,200,col=color[1],border=color[1], lend=1, ljoin=1)
  rect(xloc+102,240,xloc+114,200,col=color[1],border=color[1], lend=1, ljoin=1)

  f3m <- f3[[2*i-1]]$mat
  for(j in 2:ncol(f3m)) {
    if(f3m[2,j]==2)
      rect(xloc-6,200+f3m[1,j]*mult,xloc+6,200+f3m[1,j-1]*mult,col=color[5],border=color[5], lend=1, ljoin=1)
  }
  f3p <- f3[[2*i-1]]$pat
  for(j in 2:ncol(f3p)) {
    if(f3p[2,j]==2)
      rect(xloc+20,200+f3p[1,j]*mult,xloc+32,200+f3p[1,j-1]*mult,col=color[5],border=color[5], lend=1, ljoin=1)
  }

  f3m <- f3[[2*i]]$mat
  for(j in 2:ncol(f3m)) {
    if(f3m[2,j]==2)
      rect(xloc+76,200+f3m[1,j]*mult,xloc+88,200+f3m[1,j-1]*mult,col=color[5],border=color[5], lend=1, ljoin=1)
  }
  f3p <- f3[[2*i]]$pat
  for(j in 2:ncol(f3p)) {
    if(f3p[2,j]==2)
      rect(xloc+102,200+f3p[1,j]*mult,xloc+114,200+f3p[1,j-1]*mult,col=color[5],border=color[5], lend=1, ljoin=1)
  }

  rect(xloc-6,240,xloc+6,200,    lend=1, ljoin=1)
  rect(xloc+20,240,xloc+32,200,  lend=1, ljoin=1)
  rect(xloc+76,240,xloc+88,200,  lend=1, ljoin=1)
  rect(xloc+102,240,xloc+114,200,lend=1, ljoin=1)

  points(xloc+54,220,pch=4,cex=0.7)
  segments(xloc+54,210,xloc+54,190)
  segments(xxloc[2*i-1],190,xxloc[2*i],190)
  
  xloc <- xloc+78+120+30
}

text(u[1]/1.2,220,expression(F[3]),adj=c(0,0.5),cex=1.0)
arrows(xxloc,190,xxloc,170,len=0.04)

xloc <- 38
for(i in 1:4) {
  rect(xloc-6,160,xloc+6,120,col=color[1],border=color[1], lend=1, ljoin=1)
  rect(xloc+20,160,xloc+32,120,col=color[1],border=color[1], lend=1, ljoin=1)
  rect(xloc+76,160,xloc+88,120,col=color[1],border=color[1], lend=1, ljoin=1)
  rect(xloc+102,160,xloc+114,120,col=color[1],border=color[1], lend=1, ljoin=1)

  f4m <- f4[[2*i-1]]$mat
  for(j in 2:ncol(f4m)) {
    if(f4m[2,j]==2)
      rect(xloc-6,120+f4m[1,j]*mult,xloc+6,120+f4m[1,j-1]*mult,col=color[5],border=color[5], lend=1, ljoin=1)
  }
  f4p <- f4[[2*i-1]]$pat
  for(j in 2:ncol(f4p)) {
    if(f4p[2,j]==2)
      rect(xloc+20,120+f4p[1,j]*mult,xloc+32,120+f4p[1,j-1]*mult,col=color[5],border=color[5], lend=1, ljoin=1)
  }

  f4m <- f4[[2*i]]$mat
  for(j in 2:ncol(f4m)) {
    if(f4m[2,j]==2)
      rect(xloc+76,120+f4m[1,j]*mult,xloc+88,120+f4m[1,j-1]*mult,col=color[5],border=color[5], lend=1, ljoin=1)
  }
  f4p <- f4[[2*i]]$pat
  for(j in 2:ncol(f4p)) {
    if(f4p[2,j]==2)
      rect(xloc+102,120+f4p[1,j]*mult,xloc+114,120+f4p[1,j-1]*mult,col=color[5],border=color[5], lend=1, ljoin=1)
  }

  rect(xloc-6,160,xloc+6,120,    lend=1, ljoin=1)
  rect(xloc+20,160,xloc+32,120,  lend=1, ljoin=1)
  rect(xloc+76,160,xloc+88,120,  lend=1, ljoin=1)
  rect(xloc+102,160,xloc+114,120,lend=1, ljoin=1)

  points(xloc+54,140,pch=4,cex=0.7)
  arrows(xloc+54,87,xloc+54,80,len=0.04)
  arrows(xloc+54,130,xloc+54,80,len=0.04,lty=3)
  
  xloc <- xloc+78+120+30
}

text(u[1]/1.2,140,expression(F[4]),adj=c(0,0.5),cex=1.0)


xloc <- 38
a <- 70-40
mult <- (70-a)/f2[[1]]$mat[1,ncol(f2[[1]]$mat)]
for(i in 1:4) {
  rect(xloc+54-19,70,xloc+54-7,a,col=color[1],border=color[1], lend=1, ljoin=1)
  rect(xloc+54+7,70,xloc+54+19,a,col=color[1],border=color[1], lend=1, ljoin=1)

  my.ri8m <- my.ri8[[2*i-1]]$mat
  for(j in 2:ncol(my.ri8m)) {
    if(my.ri8m[2,j]==2)
      rect(xloc+54-19,a+my.ri8m[1,j]*mult,xloc+54-7,a+my.ri8m[1,j-1]*mult,
           col=color[5],border=color[5], lend=1, ljoin=1)
  }
  my.ri8p <- my.ri8[[2*i-1]]$pat
  for(j in 2:ncol(my.ri8p)) {
    if(my.ri8p[2,j]==2)
      rect(xloc+54+7,a+my.ri8p[1,j]*mult,xloc+54+19,a+my.ri8p[1,j-1]*mult,
           col=color[5],border=color[5], lend=1, ljoin=1)
  }

  rect(xloc+54-19,70,xloc+54-7,a,lend=1, ljoin=1)
  rect(xloc+54+7,70,xloc+54+19,a,lend=1, ljoin=1)

  xloc <- xloc+78+120+30
}


points(rep(u[1]/1.2+10,3),c(-8,0,8)+mean(c(140,(70+a)/2)),pch=16,cex=0.2)
text(u[1]/1.2,(70+a)/2,expression(F[infinity]),adj=c(0,0.5),cex=1.0)


######################################################################
# C: 4-way sib-mating
######################################################################
par(mar=c(0.1,0.1,2.6,1.1))
plot(0,0,xlim=c(-40,864),ylim=c(30,480),xaxt="n",yaxt="n",xlab="",ylab="",type="n")
mtext("Four-way RIL by sibling mating",side=3,line=0.5)
u <- par("usr")
mtext(side=3,adj=0,line=0.5,"C",font=2)

u <- par("usr")

xloc <- 10+38+55-27.5
xxloc <- NULL
for(i in 1:4) {
  xxloc <- c(xxloc,xloc)
  rect(xloc-21,480,xloc- 9,440,col=color[2*i-1],border=color[2*i-1], lend=1, ljoin=1)
  rect(xloc+ 9,480,xloc+21,440,col=color[2*i-1],border=color[2*i-1], lend=1, ljoin=1)
  text(xloc,430,LETTERS[i],adj=c(0.5,1),cex=1.0, lend=1, ljoin=1)
  rect(xloc-21,480,xloc- 9,440,lend=1, ljoin=1)
  rect(xloc+ 9,480,xloc+21,440,lend=1, ljoin=1)
  xloc <- xloc+(38+55)*2+50
}
xxloc <- c(mean(xxloc[1:2]),mean(xxloc[3:4]))
points(xxloc[1],460,pch=4,cex=0.7)
arrows(xxloc[1],445,xxloc[1],410,len=0.04)
points(xxloc[2],460,pch=4,cex=0.7)
arrows(xxloc[2],445,xxloc[2],410,len=0.04)
text(u[1]/1.2,460,expression(G[0]),adj=c(0,0.5),cex=1.0)

file <- "risib4w_sim.RData"
if(!file.exists(file)) {
  f1 <- vector("list",4)
  for(i in 1:4) f1[[i]] <- create.par(100,c(2*i-1,2*i-1))
  set.seed(112115+42)
  f2a <- cross(f1[[1]],f1[[2]],m=10,obl=TRUE)
  f2b <- cross(f1[[3]],f1[[4]],m=10,obl=TRUE)
  f3a <- cross(f2a,f2b,m=10,obl=TRUE)
  f3b <- cross(f2a,f2b,m=10,obl=TRUE)
  f4a <- cross(f3a,f3b,m=10,obl=TRUE)
  f4b <- cross(f3a,f3b,m=10,obl=TRUE)
  f5a <- cross(f4a,f4b,m=10,obl=TRUE)
  f5b <- cross(f4a,f4b,m=10,obl=TRUE)
  temp <- list(f5a,f5b)
  for(i in 1:60) {
    fa <- cross(temp[[1]],temp[[2]],m=10,obl=TRUE)
    fb <- cross(temp[[1]],temp[[2]],m=10,obl=TRUE)
    temp <- list(fa,fb)
  }
  save(f1,f2a,f2b,f3a,f3b,f4a,f4b,f5a,f5b,fa,file=file)
} else load(file)

rect(xxloc[1]-21,400,xxloc[1]- 9,360,col=color[1],border=color[1], lend=1, ljoin=1)
rect(xxloc[1]+ 9,400,xxloc[1]+21,360,col=color[3],border=color[3], lend=1, ljoin=1)
rect(xxloc[2]-21,400,xxloc[2]- 9,360,col=color[5],border=color[5], lend=1, ljoin=1)
rect(xxloc[2]+ 9,400,xxloc[2]+21,360,col=color[7],border=color[7], lend=1, ljoin=1)

mult <- 40/f2a$mat[1,ncol(f2a$mat)]
temp <- f2a$mat
for(j in 2:ncol(temp)) {
  if(temp[2,j]==2)
    rect(xxloc[1]-21,360+temp[1,j]*mult,xxloc[1]-9,360+temp[1,j-1]*mult,
         col=color[2],border=color[2], lend=1, ljoin=1)
}
temp <- f2a$pat
for(j in 2:ncol(temp)) {
  if(temp[2,j]==4)
    rect(xxloc[1]+ 9,360+temp[1,j]*mult,xxloc[1]+21,360+temp[1,j-1]*mult,
         col=color[4],border=color[4], lend=1, ljoin=1)
}
temp <- f2b$mat
for(j in 2:ncol(temp)) {
  if(temp[2,j]==6)
    rect(xxloc[2]-21,360+temp[1,j]*mult,xxloc[2]-9,360+temp[1,j-1]*mult,
         col=color[6],border=color[6], lend=1, ljoin=1)
}
temp <- f2b$pat
for(j in 2:ncol(temp)) {
  if(temp[2,j]==8)
    rect(xxloc[2]+9,360+temp[1,j]*mult,xxloc[2]+21,360+temp[1,j-1]*mult,
         col=color[8],border=color[8], lend=1, ljoin=1)
}

rect(xxloc[1]-21,400,xxloc[1]- 9,360,lend=1, ljoin=1)
rect(xxloc[1]+ 9,400,xxloc[1]+21,360,lend=1, ljoin=1)
rect(xxloc[2]-21,400,xxloc[2]- 9,360,lend=1, ljoin=1)
rect(xxloc[2]+ 9,400,xxloc[2]+21,360,lend=1, ljoin=1)

text(u[1]/1.2,380,expression(G[1]),adj=c(0,0.5),cex=1.0)
xxloc <- mean(xxloc)
points(xxloc,380,pch=4,cex=0.7)
segments(xxloc,365,xxloc,345)
segments(xxloc-39,345,xxloc+39,345)
arrows(xxloc+39*c(-1,1),345,xxloc+39*c(-1,1),325,len=0.04)

rect(xxloc-60,315,xxloc-48,275,col=color[1],border=color[1], lend=1, ljoin=1)
rect(xxloc-32,315,xxloc-20,275,col=color[5],border=color[5], lend=1, ljoin=1)
rect(xxloc+20,315,xxloc+32,275,col=color[1],border=color[1], lend=1, ljoin=1)
rect(xxloc+48,315,xxloc+60,275,col=color[5],border=color[5], lend=1, ljoin=1)

temp <- f3a$mat
for(j in 2:ncol(temp)) {
  if(temp[2,j]!=1)
    rect(xxloc-60,275+temp[1,j]*mult,xxloc-48,275+temp[1,j-1]*mult,
         col=color[temp[2,j]],border=color[temp[2,j]], lend=1, ljoin=1)
}
temp <- f3a$pat
for(j in 2:ncol(temp)) {
  if(temp[2,j]!=5)
    rect(xxloc-32,275+temp[1,j]*mult,xxloc-20,275+temp[1,j-1]*mult,
         col=color[temp[2,j]],border=color[temp[2,j]], lend=1, ljoin=1)
}
temp <- f3b$mat
for(j in 2:ncol(temp)) {
  if(temp[2,j]!=1)
    rect(xxloc+20,275+temp[1,j]*mult,xxloc+32,275+temp[1,j-1]*mult,
         col=color[temp[2,j]],border=color[temp[2,j]], lend=1, ljoin=1)
}
temp <- f3b$pat
for(j in 2:ncol(temp)) {
  if(temp[2,j]!=5)
    rect(xxloc+48,275+temp[1,j]*mult,xxloc+60,275+temp[1,j-1]*mult,
         col=color[temp[2,j]],border=color[temp[2,j]], lend=1, ljoin=1)
}
rect(xxloc-60,315,xxloc-48,275,lend=1, ljoin=1)
rect(xxloc-32,315,xxloc-20,275,lend=1, ljoin=1)
rect(xxloc+20,315,xxloc+32,275,lend=1, ljoin=1)
rect(xxloc+48,315,xxloc+60,275,lend=1, ljoin=1)
text(u[1]/1.2,295,expression(paste(G[1], ":", F[1])),adj=c(0,0.5),cex=1.0)
points(xxloc,295,pch=4,cex=0.7)
segments(xxloc,280,xxloc,260)
segments(xxloc-39,260,xxloc+39,260)
arrows(xxloc+39*c(-1,1),260,xxloc+39*c(-1,1),240,len=0.04)

######################################################################

rect(xxloc-60,230,xxloc-48,190,col=color[1],border=color[1], lend=1, ljoin=1)
rect(xxloc-32,230,xxloc-20,190,col=color[1],border=color[1], lend=1, ljoin=1)
rect(xxloc+20,230,xxloc+32,190,col=color[1],border=color[1], lend=1, ljoin=1)
rect(xxloc+48,230,xxloc+60,190,col=color[1],border=color[1], lend=1, ljoin=1)

temp <- f4a$mat
for(j in 2:ncol(temp)) {
  if(temp[2,j]!=1)
    rect(xxloc-60,190+temp[1,j]*mult,xxloc-48,190+temp[1,j-1]*mult,
         col=color[temp[2,j]],border=color[temp[2,j]], lend=1, ljoin=1)
}
temp <- f4a$pat
for(j in 2:ncol(temp)) {
  if(temp[2,j]!=1)
    rect(xxloc-32,190+temp[1,j]*mult,xxloc-20,190+temp[1,j-1]*mult,
         col=color[temp[2,j]],border=color[temp[2,j]], lend=1, ljoin=1)
}
temp <- f4b$mat
for(j in 2:ncol(temp)) {
  if(temp[2,j]!=1)
    rect(xxloc+20,190+temp[1,j]*mult,xxloc+32,190+temp[1,j-1]*mult,
         col=color[temp[2,j]],border=color[temp[2,j]], lend=1, ljoin=1)
}
temp <- f4b$pat
for(j in 2:ncol(temp)) {
  if(temp[2,j]!=1)
    rect(xxloc+48,190+temp[1,j]*mult,xxloc+60,190+temp[1,j-1]*mult,
         col=color[temp[2,j]],border=color[temp[2,j]], lend=1, ljoin=1)
}
text(u[1]/1.2,210,expression(paste(G[1], ":", F[2])),adj=c(0,0.5),cex=1.0)
points(xxloc,210,pch=4,cex=0.7)
arrows(xxloc,195,xxloc,155,len=0.04)

rect(xxloc-60,230,xxloc-48,190,lend=1, ljoin=1)
rect(xxloc-32,230,xxloc-20,190,lend=1, ljoin=1)
rect(xxloc+20,230,xxloc+32,190,lend=1, ljoin=1)
rect(xxloc+48,230,xxloc+60,190,lend=1, ljoin=1)

######################################################################

rect(xxloc-60,150,xxloc-48,110,col=color[1],border=color[1], lend=1, ljoin=1)
rect(xxloc-32,150,xxloc-20,110,col=color[1],border=color[1], lend=1, ljoin=1)
rect(xxloc+20,150,xxloc+32,110,col=color[1],border=color[1], lend=1, ljoin=1)
rect(xxloc+48,150,xxloc+60,110,col=color[1],border=color[1], lend=1, ljoin=1)

temp <- f5a$mat
for(j in 2:ncol(temp)) {
  if(temp[2,j]!=1)
    rect(xxloc-60,110+temp[1,j]*mult,xxloc-48,110+temp[1,j-1]*mult,
         col=color[temp[2,j]],border=color[temp[2,j]], lend=1, ljoin=1)
}
temp <- f5a$pat
for(j in 2:ncol(temp)) {
  if(temp[2,j]!=1)
    rect(xxloc-32,110+temp[1,j]*mult,xxloc-20,110+temp[1,j-1]*mult,
         col=color[temp[2,j]],border=color[temp[2,j]], lend=1, ljoin=1)
}
temp <- f5b$mat
for(j in 2:ncol(temp)) {
  if(temp[2,j]!=1)
    rect(xxloc+20,110+temp[1,j]*mult,xxloc+32,110+temp[1,j-1]*mult,
         col=color[temp[2,j]],border=color[temp[2,j]], lend=1, ljoin=1)
}
temp <- f5b$pat
for(j in 2:ncol(temp)) {
  if(temp[2,j]!=1)
    rect(xxloc+48,110+temp[1,j]*mult,xxloc+60,110+temp[1,j-1]*mult,
         col=color[temp[2,j]],border=color[temp[2,j]], lend=1, ljoin=1)
}
text(u[1]/1.2,130,expression(paste(G[1], ":", F[3])),adj=c(0,0.5),cex=1.0)
points(xxloc,130,pch=4,cex=0.7)
arrows(xxloc,82,xxloc,75,len=0.04)
arrows(xxloc,115,xxloc,75,len=0.04,lty=3)

rect(xxloc-60,150,xxloc-48,110,lend=1, ljoin=1)
rect(xxloc-32,150,xxloc-20,110,lend=1, ljoin=1)
rect(xxloc+20,150,xxloc+32,110,lend=1, ljoin=1)
rect(xxloc+48,150,xxloc+60,110,lend=1, ljoin=1)

######################################################################


points(rep(u[1]/1.2+10,3),c(-8,0,8)+mean(c(140,65/2)),pch=16,cex=0.2)
a <- 25
text(u[1]/1.2,(65+a)/2,expression(paste(G[1], ":", F[infinity])),adj=c(0,0.5),cex=1.0)
mult <- (65-a)/fa$mat[1,ncol(fa$mat)]
rect(xxloc+21*c(-1,1),rep(65,2),xxloc+9*c(-1,1),rep(a,2),col=color[1],border=color[1], lend=1, ljoin=1)
temp <- fa$mat
for(j in 2:ncol(fa$mat)) {
  if(temp[2,j]!=1)
    rect(xxloc+21*c(-1,1),rep(a,2)+temp[1,j]*mult,xxloc+9*c(-1,1),rep(a,2)+temp[1,j-1]*mult,
         col=color[temp[2,j]],border=color[temp[2,j]], lend=1, ljoin=1)
}
rect(xxloc+21*c(-1,1),rep(65,2),xxloc+9*c(-1,1),rep(a,2),lend=1, ljoin=1)



######################################################################
# D: 8-way sib-mating
######################################################################
par(mar=c(0.1,1.1,2.6,0.1))
plot(0,0,xlim=c(-40,864),ylim=c(30,480),xaxt="n",yaxt="n",xlab="",ylab="",type="n")
mtext("Eight-way RIL by sibling mating",side=3,line=0.5)
u <- par("usr")
mtext(side=3,adj=0,line=0.5,"D",font=2)

u <- par("usr")
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

file <- "risib8w_sim.RData"
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
