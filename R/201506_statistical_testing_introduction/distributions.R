
png("norm_studt.png")
par(mfrow = c(1, 2))

# norm. distribution
curve(dnorm, -5.5, 5.5, main="Standard normal distribution", lwd=2)

# t distribution 

curve(dt(x, df=1), -5.5, 5.5, ylim=c(0, 0.4), main="Students t distribution", col=rainbow(4)[1], ylab="dt(x, df=df)", lwd=2)
curve(dt(x, df=10), -5.5, 5.5, add=T, col=rainbow(4)[2], lwd=2)
curve(dt(x, df=30), -5.5, 5.5, add=T, col=rainbow(4)[3], lwd=2)
curve(dt(x, df=100), -5.5, 5.5, add=T, col=rainbow(4)[4], lwd=2)

legend("topright", c("df=1", "df=2", "df=3", "df=4"), col=rainbow(4), lty=1, lwd=2)

# norm and t compared

dev.off()

png("norm_studt_comp.png")
curve(dnorm, -5.5, 5.5, main="Compare norm. and t distribution", col=rainbow(3)[1], ylab="Density", lwd=2)
curve(dt(x, df=1), add=T, col=rainbow(3)[2], lwd=2)
curve(dt(x, df=30), add=T, col=rainbow(3)[3], lty=2, lwd=2)

legend("topright", c("norm", "t df=1", "t df=30"), col=rainbow(3), lty=c(1, 1, 2), lwd=2)
dev.off()

# chi squared

png("chi.png")
curve(dchisq(x, df=1), 0, 10, col=rainbow(4)[1], main="Chi squared distribution", ylab="dchisq(df=df)", lwd=2)
curve(dchisq(x, df=2), add=T, col=rainbow(4)[2], lwd=2)
curve(dchisq(x, df=5), add=T, col=rainbow(4)[3], lwd=2)
curve(dchisq(x, df=10), add=T, col=rainbow(4)[4], lwd=2)

legend("topright", c("df=1", "df=2", "df=5", "df=10"), col=rainbow(4), lty=1, lwd=2)
dev.off()

# f distirbution

png("f.png")
curve(df(x, 1, 1), 0, 5, col=rainbow(4)[1], ylim=c(0, 2), main="F distribution", ylab="df(x, df1=df1, df2=df2)", lwd=2)
curve(df(x, 1, 10), add=T, col=rainbow(4)[2], lwd=2)
curve(df(x, 10, 1), add=T, col=rainbow(4)[3], lwd=2)
curve(df(x, 100, 100), add=T, col=rainbow(4)[4], lwd=2)

legend("topright", c("df1=1 df2=1", "df1=1 df2=10", "df1=10 df2=1", "df1=100 df2=100"), col=rainbow(4), lty=1, lwd=2)
dev.off()


# color p value

png("norm_pvalue.png")
fun.norm<-curve(dnorm, -5.5, 5.5, main="Standard normal distribution", lwd=2)
polygon(pmax(fun.norm$x, 1.96), fun.norm$y, col="gray")
polygon(pmin(fun.norm$x, -1.96), fun.norm$y, col="gray")
dev.off()

# compute p value

pnorm(1.96) # 0.9750021
1-pnorm(1.96) # 0.0249979
2*(1-pnorm(1.96)) # 0.04999579

1-pt(1.96, df=1) # 0.1501714
1-pt(1.96, df=30) # 0.02967116
1-pt(1.96, df=100) # 0.02638945

1-pchisq(1.96, df=1) # 0.1615133
1-pchisq(1.96, df=5) # 0.8546517

1-pf(1.96, df1=1, df2=1) # 0.3948631
1-pf(1.96, df1=5, df2=5) # 0.2389522


