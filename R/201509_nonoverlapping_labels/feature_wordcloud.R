
words<-c("R", "visualisation", "labels", "non-overlapping", "plotting", "box plot", "Rstats", "DataViz", "graph", "statistics", "diagram", "data", "parameters", "plot")
freq<-seq(length(words), 1, -1)

jpeg("feature.jpg", width=960)
wordcloud(words, freq, colors = rainbow(5), rot.per=0, asp=200)
dev.off()
