X1<-rnorm(20, 15, 2)

mu1<-15.5
mu2<-12
mu3<-15

t.test(X1, mu = mu1)
t.test(X1, mu = mu2)
t.test(X1, mu = mu3)


X2<-rnorm(1000, 15, 2)

t.test(X2, mu = mu1)
t.test(X2, mu = mu2)
t.test(X2, mu = mu3)
