######

samples<-100

category<-c(rep(1, samples/2), rep(2, samples/2))
h1<-runif(samples, 1, 5)
h2<-rnorm(samples, category, 0.3)

data<-data.frame(x1=rnorm(samples, 10+h1, 1), x2=rnorm(samples, h1^2+3*h2, 1), x3=h1+h2+rnorm(samples,0, 0.9), x4=rnorm(samples, 20*h1+h2, 2), x5=14*h1*h2+rnorm(samples, 0, 1))
png("fa_dim5.png")
plot(data, col=rainbow(4)[category])
dev.off()

fa<-factanal(data, factors=2, scores="regression")
fa$loadings
png("fa_computed.png")
pairs(fa$scores, col=rainbow(4)[category])
dev.off()

data1<-data.frame(x1=rnorm(samples, 10+h1, 1), x2=rnorm(samples, h1^2+3*h2, 1), x3=h1+h2+rnorm(samples,0, 0.9), x4=rnorm(samples, 20*h1+h2, 2), x5=14*h1*h2+rnorm(samples, 0, 1), x6=h1+rnorm(samples, 0, 3), x7=h1*h2*3+rnorm(samples, 0, 4), x8=6*h2+rnorm(samples, 0, 5))
plot(data1, col=rainbow(4)[category])

fa_4<-factanal(data1, factors=4, scores="regression")
fa_4$loadings
png("fa4_computed.png")
pairs(fa_4$scores, col=rainbow(4)[category])
dev.off()

fa_1<-factanal(data1, factors=1, scores="regression")
png("fa1_computed.png")
plot(fa_1$scores, col=rainbow(4)[category])
dev.off()

# Factor Analysis
fa2<-factanal(wine_s, factors=2, scores="regression")
fa3<-factanal(wine_s, factors=3, scores="regression")
fa4<-factanal(wine_s, factors=4, scores="regression")
fa6<-factanal(wine_s, factors=6, scores="regression")

pairs(fa2$scores, col=rainbow(3)[winedata[,1]])

pairs(fa3$scores, col=rainbow(3)[winedata[,1]])

pairs(fa4$scores, col=rainbow(3)[winedata[,1]])

pairs(fa6$scores, col=rainbow(3)[winedata[,1]])


