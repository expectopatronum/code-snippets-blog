winedata=read.csv("wine.data.txt",sep=",", header=F)

wine_s<-scale(winedata[,2:14])

# PCA
library(scatterplot3d)
pc<-princomp(wine_s)
summary(pc)

pairs(pc$scores[,1:5], col=rainbow(3)[winedata[,1]], asp=1)

scatterplot3d(pc$scores[,c(1,2,4)], color=rainbow(3)[winedata[,1]])


# ICA
library(fastICA)
ica<-fastICA(wine_s, n.comp=5)
ica8<-fastICA(wine_s, n.comp=8)

pairs(ica$S, col=rainbow(3)[winedata[,1]])

pairs(ica8$S, col=rainbow(3)[winedata[,1]])

plot(ica$S[,1], ica$S[,1], col=rainbow(3)[winedata[,1]], xlab="Comp 1", ylab="Comp 1")


plot(a02$V1, a02$V2, xlab="Feature 1", ylab="Feature 2", main="Dataset 2", pch=20, cex=0.4, asp=1)
for (i in 1:10) {
  ic2<-fastICA(a02, n.comp=2)
  load <- ic2$A
  slope <- load[2, ]/load[1, ]
  abline(0, slope[1], lwd = 1.5, col=colors[i])  # first component solid line
  abline(0, slope[2], lwd = 1.5, lty = 2, col=colors[i])  # second component dashed
}

x<-rnorm(20, 2, 0.5)
y<-rnorm(20, x+3, 4)

data<-data.frame(x, y)
data<-scale(data)

#png("ica_visualized.png")
plot(data, asp=1)
colors<-rainbow(3)
for (i in 1:3) {
  ica2<-fastICA(data, n.comp=2)
  load<-ica2$A
  slope <- load[2, ]/load[1, ]
  abline(0, slope[1], lwd = 1.5, col=colors[i])  # first component solid line
  abline(0, slope[2], lwd = 1.5, lty = 2, col=colors[i])  # second component
}
#dev.off()