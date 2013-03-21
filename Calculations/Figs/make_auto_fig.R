pdf("auto_fig.pdf", height=10, width=7.5)
par(bty="n", mar=c(0.1,0.1,0.1,2.1))
plot(0, 0, type="n", xlab="", ylab="", xaxt="n", yaxt="n", xlim=c(-5, 95), ylim=c(0,100))
left <- seq(0, 100, length=9)[-9]
right <- left + diff(left[1:2])*0.5
top <- seq(100, 0, length=19)[-19]
bottom <- top + diff(top[1:2])*0.5
for(i in seq(along=left)) {
  for(j in seq(along=top)) {
    rect(left[i], top[j], right[i], bottom[j], lwd=2)
    segments(left[i]+(right[i]-left[i])/4, top[j],
             left[i]+(right[i]-left[i])/4, bottom[j]) 
    segments(left[i]+(right[i]-left[i])*2/4, top[j],
             left[i]+(right[i]-left[i])*2/4, bottom[j],lwd=2) 
    segments(left[i]+(right[i]-left[i])*3/4, top[j],
             left[i]+(right[i]-left[i])*3/4, bottom[j]) 
  }
}
for(j in seq(along=top)) 
  text(par("usr")[1]/2, (top[j]+bottom[j])/2, j, adj=c(0.5, 0.5))
dev.off()

