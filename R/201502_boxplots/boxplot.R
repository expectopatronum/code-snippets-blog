r1<-rnorm(15, 10, 2)
r2<-rnorm(20, 12, 3.5)
r3<-rnorm(15, 8, 1)
r4<-rpois(15, 9)

#### boxplot of one dataset

png("Documents/Blog/images/boxplot_r1.png")
boxplot(r1)
dev.off()

#### standard boxplot

png("Documents/Blog/images/boxplot_r1-r4.png")
boxplot(r1, r2, r3, r4)
dev.off()

#### boxtplot with title

png("Documents/Blog/images/boxplot_title2.png")
boxplot(r1, r2, r3, r4, main="Boxplot of my data")
dev.off()

#### boxplot with modified x-axis

png("Documents/Blog/images/boxplot_axis.png")
boxplot(r1, r2, r3, r4, xaxt="n", main="Boxplot of my data")
axis(side=1, las=2, at = 1:4, labels=c("r1", "r2", "r3", "r4"))
dev.off()

#### boxplot with colors
png("Documents/Blog/images/boxplot_colors.png")
boxplot(r1, r2, r3, r4, xaxt="n", main="Boxplot of my data", col=rainbow(4, alpha = 0.5))
axis(side=1, las=2, at = 1:4, labels=c("r1", "r2", "r3", "r4"))
dev.off()

#### show single points
png("Documents/Blog/images/boxplot_singlepoints.png")
boxplot(r1, r2, r3, r4, xaxt="n", main="Boxplot of my data", col=rainbow(4, alpha = 0.5))
axis(side=1, las=2, at = 1:4, labels=c("r1", "r2", "r3", "r4"))
frequencies<-c(rep(1, length(r1)), rep(2, length(r2)), rep(3, length(r3)), rep(4, length(r4)))
points(frequencies, c(r1, r2, r3, r4), col=rainbow(4)[frequencies], pch=19, cex=0.5)
dev.off()

#### visual separation
png("Documents/Blog/images/boxplot_sep.png")
boxplot(r1, r2, r3, r4, xaxt="n", main="Boxplot of my data", col=rainbow(4, alpha = 0.5))
axis(side=1, las=2, at = 1:4, labels=c("r1", "r2", "r3", "r4"))
frequencies<-c(rep(1, length(r1)), rep(2, length(r2)), rep(3, length(r3)), rep(4, length(r4)))
points(frequencies, c(r1, r2, r3, r4), col=rainbow(4)[frequencies], pch=19, cex=0.5)
abline(v=2.5, col="darkgrey")
dev.off()


?boxplot
?bxp

#### boxplot for featured page

png("Documents/Blog/images/boxplot_featured.png")
boxplot(r1, r2, r3, r4, xaxt="n", yaxt="n", col=rainbow(4, alpha = 0.5), frame=FALSE, notch=TRUE)
#axis(side=1, las=2, at = 1:4, labels=c("r1", "r2", "r3", "r4"))
frequencies<-c(rep(1, length(r1)), rep(2, length(r2)), rep(3, length(r3)), rep(4, length(r4)))
points(frequencies, c(r1, r2, r3, r4), col=rainbow(4)[frequencies], pch=19, cex=0.5)
dev.off()
