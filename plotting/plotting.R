# R INFO GRAPHIC FOR PLOTTING OPTIONS


# lines
# dots
# legend
# axis


#pdf("Documents/Blog/images/plotting.pdf")
#png("Documents/Blog/images/plotting.png")
par(mfrow=c(3,1))
plot(1:20, 1:20, pch=1:20, main="Different plotting symbols (pch)", xlab="pch", ylab="pch", yaxt="n", xaxt="n")
axis(1, at=1:20, labels=1:20)
plot(1:6, col="white", main="Different plotting lines (lty)", xlab="lty", ylab="lty", xaxt="n")
abline(h=1:6, lty=1:6)
plot(rep(1, 100), 1:100, xaxt="n", xlim=c(1, 6), ylim=c(1, 100), pch=19, col=rainbow(100), main="Different color plotting functions (col)", xlab="color function", ylab="col")
points(rep(2, 100), 1:100, col=heat.colors(100))
points(rep(3, 100), 1:100, col=terrain.colors(100))
points(rep(4, 100), 1:100, col=topo.colors(100))
points(rep(5, 100), 1:100, col=cm.colors(100))
points(rep(6, 100), 1:100, col=gray((1:100)/100))
axis(1, at=1:6, labels=c("rainbow()", "heat.colors()", "terrain.colors()", "topo.colors()", "cm.colors()", "gray()"))
#dev.off()

rainbow(n, s = 1, v = 1, start = 0, end = max(1, n - 1)/n, alpha = 1)
heat.colors(n, alpha = 1)
terrain.colors(n, alpha = 1)
topo.colors(n, alpha = 1)
cm.colors(n, alpha = 1)