library(microbenchmark)



chr.v<-c(rep("chr1", 10), rep("chr2", 20), rep("chr3", 8), rep("chr4", 19), rep("chr5", 15), rep("chr6", 19))


table(chr.v)

chr.f<-factor(chr.v)
levels(chr.f)
table(chr.f)

chr.f[1] < chr.f[2]

chr.f.order<-factor(chr.v, ordered=TRUE) # takes order as sort(unique(x))

chr.f.order[2] < chr.f.order[15]

#### LEVELS ####

chr.f.levels<-factor(chr.v, levels<-c("chr1", "chr2", "chr3", "chr4", "chr5", "chr6", "chr7"))
table(chr.f.levels)

chr.f.levels2<-factor(chr.v, levels<-c("chr1", "chr2", "chr3", "chr4"))
table(chr.f.levels2)

chr.f.levels2

chromosomes<-c("chr1", "chr2", "chr3", "chr4", "chr5", "chr6", "chr7", "chr8", "chr9", "chr10", "chr11", "chr12", "chr13", "chr14", "chr15", "chr16", "chr17", "chr18", "chr19", "chr20", "chr21", "chr22", "chrX", "chrY")

chr.f.wrong.order<-factor(chromosomes, ordered=T)

chr.f.order2<-factor(chromosomes, ordered=T, levels<-c("chr1", "chr2", "chr3", "chr4", "chr5", "chr6", "chr7", "chr8", "chr9", "chr10", "chr11", "chr12", "chr13", "chr14", "chr15", "chr16", "chr17", "chr18", "chr19", "chr20", "chr21", "chr22", "chrX", "chrY"))

levels(chr.f)<-c(levels(chr.f), "chrZ")
chr.f[1]<-"chrZ"

chr.f.exclude<-factor(chr.v, exclude=c("chr4"))

table(chr.f.exclude)

#### NA AS A LEVEL ####

chr.f.na<-factor(c(1, 2, NA, 3, 4), exclude=NULL)
table(chr.f.na)

#### LABELS ####

chr.f.labels<-factor(chr.v, levels<-c("chr1", "chr2", "chr3", "chr4", "chr5", "chr6"), labels=paste("Chromosome", 1:6))

length(which(chr.f.labels=="chr1"))
length(which(chr.f.labels=="Chromosome 1"))

#### CONVERSIONS ####

number.factor<-factor(c(1, 3, 2, 4, 8, 10))

table(number.factor)

as.numeric(number.factor)

levels(number.factor)

as.numeric(levels(number.factor))[number.factor]

#### SECOND POST ####


#### PLOTS ####

hist(table(chr.f))

hist(chr.v)

- why use factors
* for (x in levels(f)) ... (faster than for (x in unique(f)) ?)
* more efficient use of memory (further info)
* converting to int (see plots)

- reading data

- factors and plots
* difficulties
* boxplot

- benchmarking

#### BENCHMARK ####

microbenchmark(length(which(chr.v=="chr1")), length(which(chr.f=="chr1")), times=10000)

microbenchmark(sample(chr.v,1), sample(chr.f,1), times=10000)

microbenchmark(sample(chr.v, 100, replace=TRUE), sample(chr.f, 100, replace=TRUE), times=10000)

microbenchmark(sort(chr.v[length(chr.v):1]), sort(chr.f[length(chr.f):1]), times=10000)

microbenchmark(for (x in unique(chr.v)) {}, for (x in levels(chr.f)) {}, times=10000)



#### READ DATA ####

df<-read.table("Documents/Blog/sourcecodes//factors.csv", sep=";", header=T)

df.char<-read.table("Documents/Blog/sourcecodes//factors.csv", sep=";", header=T, stringsAsFactors = F)