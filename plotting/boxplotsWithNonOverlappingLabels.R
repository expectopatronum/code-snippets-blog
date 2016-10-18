library(wordcloud)

x1<-rnorm(50, 1200, 300)
x2<-x1-rnorm(50, 300, 50)
x3<-x1-rnorm(50, 400, 80)

xnames<-paste0("Sample_",1:50)

createBoxplotWithLabels<-function(x, name, xnames) {
  boxplot(x, main=name)
  points(rep(1, length(x)), x, pch=19, col=gray(0.3, 0.3))
  abline(h=mean(x)-sd(x), col="red", lty=2)
  
  low<-x<=(mean(x)-sd(x))
  textplot(rep(1, sum(low)), x[low], xnames[low], new=FALSE, col=gray(0.3), xlim=c(0, 0.8))  
}

pdf("BoxplotsWithNonOverlappingLabels.pdf", width=15)
par(mfrow=c(1,3))
createBoxplotWithLabels(x1, "x1", xnames)
createBoxplotWithLabels(x2, "x2", xnames)
createBoxplotWithLabels(x3, "x3", xnames)
dev.off()
