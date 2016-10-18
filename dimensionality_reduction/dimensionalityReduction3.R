# Projection pursuit
library(pcaPP)

pp2<-PCAproj(wine_s,k=2)
png("ownCloud/Bananenhauptquartier/Blog/images/15_05 unsupervised techniques/pp2.png")
plot(pp2$scores, col=rainbow(3)[winedata[,1]])
dev.off()

pp3<-PCAproj(wine_s,k=3)
pairs(pp3$scores, col=rainbow(3)[winedata[,1]])

pp5<-PCAproj(wine_s,k=5)
pairs(pp5$scores, col=rainbow(3)[winedata[,1]])

scatterplot3d(pp5$scores[,c(2,1,3)], color=rainbow(3)[winedata[,1]], angle=70)

summary(pp5)
summary(pp2)

# non negative matrix factorisation

library(fabia)


n13<-nmfdiv(t(winedata[,2:14]), 13)

extractPlot(n13, ti="NMFDIV", Y=winedata[,1])

ne<-nmfeu(t(winedata[,2:14]), 13)
extractPlot(ne, ti="NMFEU", Y=winedata[,1])

nms<-nmfsc(t(winedata[,2:14]), 13)
extractPlot(nms, ti="NMFSC", Y=winedata[,1])

n3<-nmfdiv(t(winedata[,2:14]), 3)
extractPlot(n3, ti="NMFDIV", Y=winedata[,1])

n2<-nmfdiv(t(winedata[,2:14]),2)

extractPlot(n2, ti="NMFDIV", Y=winedata[,1])

library(NMFN)

nn2<-nnmf(wine_s,2)

plot(nn2$W, col=rainbow(3)[winedata[,1]]) # not so interesting

nn5<-nnmf(wine_s,5)

pairs(nn5$W, col=rainbow(3)[winedata[,1]])



