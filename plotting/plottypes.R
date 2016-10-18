gender<-sample(c("m", "w"), 20, replace=TRUE)

menIdx<-which(gender=="m")
womenIdx<-which(gender=="w")

weight<-ifelse(gender=="m", rnorm(length(menIdx), 80, 20), rnorm(length(womenIdx), 65, 10))
height<-weight+100+rnorm(20, 0, 8)

data<-data.frame("height"=height, "weight"=weight, "hairColor"=sample(c("blonde", "black", "brown"), 20, replace=TRUE), "gender"=gender, "degree"=sample(c("None", "High School", "University"), 20, replace=TRUE), "nrPets"=sample(0:3, 20, replace=TRUE))

data$degree<-ordered(data$degree, levels=c("None", "High School", "University"))

str(data)


#### 1 DIMENSIONAL ####

## METRIC ##

png("Documents/Blog/images/plottypes/metric1d.png")
par(mfrow=c(3,1))
hist(data$height, main="Height")
plot(density(data$height), main="Height")
boxplot(data$weight, main="Weight")
dev.off()

# DISCRETE 

png("Documents/Blog/images/plottypes/metric_discrete1d.png")
par(mfrow=c(3,1))
hist(data$nrPets, main="Nr of pets")
pie(table(data$nrPets), main="Nr of pets")
barplot(table(data$nrPets), main="Nr of pets")
dev.off()

## ORDINAL ##

png("Documents/Blog/images/plottypes/ordinal1d.png")
par(mfrow=c(1,2))
pie(table(data$degree), main="Degree")
barplot(table(data$degree), main="Degree")
dev.off()

## CATEGORICAL ##

png("Documents/Blog/images/plottypes/categorical1d.png")
par(mfrow=c(1,2))
pie(table(data$gender), main="Gender")
barplot(table(data$hairColor), main="Hair color")
dev.off()

#### MULTI DIMENSIONAL ####

## METRIC / METRIC


png("Documents/Blog/images/plottypes/metric_metric2d.png")
par(mfrow=c(1,2))
plot(data$height, data$weight, xlab="Height", ylab="Weight", xlim=c(0, max(data$height)), ylim=c(0, max(data$weight)))

boxplot(data$height, data$weight, xaxt="n")
axis(1, at=1:2, labels=c("Height", "Weight"))
dev.off()

# DISCRETE / CONTINUOUS

png("Documents/Blog/images/plottypes/discret_continuous.png")
plot(sort(height), type="o", ylab="Height", xlab="Time", main="Height over time")
dev.off()

#plot(data$nrPets, ylab="Nr of pets", xlab="Time")


## METRIC / ORDINAL

png("Documents/Blog/images/plottypes/metric_ordinal2d.png")
boxplot(height ~ degree, data=data)
dev.off()

## METRIC / CATEGORICAL 

png("Documents/Blog/images/plottypes/metric_categorical2d.png")
par(mfrow=c(1,2))
boxplot(height ~ gender, data=data)

hist(data$height[womenIdx], col=rgb(1, 0, 0, 0.5), xlim=c(min(data$height)-30, max(data$height)+30), main="Height", xlab="Height")
hist(data$height[menIdx], col=rgb(0, 0, 1, 0.5), add=TRUE)
legend("topright", c("male", "female"), lty=1, col=c("blue", "red"))
dev.off()

## ORDINAL / CATEGORICAL

table(data[,c("gender", "degree")])

## CATEGORICAL / CATEGORICAL

table(data[,c("gender", "hairColor")])


