## read data

fit_06 <- read.fitbit("fitbit_data/fitbit_export_20160630.csv")
fit_07 <- read.fitbit("fitbit_data/fitbit_export_20160731.csv")
fit_08 <- read.fitbit("fitbit_data/fitbit_export_20160831.csv")
fit_09 <- read.fitbit("fitbit_data/fitbit_export_20160930.csv")

fit_06 <- split.date(fit_06)
fit_07 <- split.date(fit_07)
fit_08 <- split.date(fit_08)
fit_09 <- split.date(fit_09)

fit_2016 <- rbind(fit_06, fit_07, fit_08, fit_09)
fit_2016 <- fit_2016[fit_2016$min.sleep > 0,]

## activity over time

ggplot(fit_2016) + geom_line(aes(x = day, y = steps, group=month, col=month))
ggsave("fitbit_data/steps_per_month.png")
ggplot(fit_2016) + geom_histogram(aes(steps), bins=20) + facet_wrap(~month)
ggsave("fitbit_data/hist_per_month.png")

ggplot(fit_2016) + geom_histogram(aes(min.sleep), bins=20) + facet_wrap(~wknd)
ggsave("sleep_wknd.png")

summary(fit_2016[fit_2016$wknd,"min.sleep"]/60)
summary(fit_2016[!fit_2016$wknd,"min.sleep"]/60)

# ggplot(fit_2016) + geom_point(aes(x=wday, y=steps, group=weeknr, col=month))
# ggplot(fit_2016) + geom_point(aes(x=month, y=wday, col=steps))

#sum(fit_2016$min.sleep == 0)
#sum(fit_2016$steps == 0)
#sum(fit_2016$min.sleep == 0 & fit_2016$steps == 0)
#fit_2016[fit_2016$min.sleep == 0,]
#fit_2016[fit_2016$min.sleep < 350,]
#ggplot(fit_2016) + geom_bar(aes(x= wday, y=steps), stat = "sum")
