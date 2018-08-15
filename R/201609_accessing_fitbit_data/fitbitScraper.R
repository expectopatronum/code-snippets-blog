library(fitbitScraper)

cookie <- login(email="veroamilbe@gmail.com", password=Sys.getenv("FBPW"), rememberMe = TRUE)

dates <- seq(as.Date("2016-06-01"), as.Date("2016-09-17"), by="day")
df_list <- lapply(dates, function(x)
  get_intraday_data(cookie=cookie, what="steps", as.character(x)))
fit_fs_2016 <- do.call(rbind, df_list)
fit_fs_2016$hour <- as.POSIXct(cut.POSIXt(fit_fs_2016$time, breaks="hour"))
#fit_fs_2016$month <- cut.POSIXt(fit_fs_2016$time, breaks="month")
fit_fs_2016$month <- format(fit_fs_2016$time, "%m")
fit_fs_2016$mday <- format(fit_fs_2016$time, "%d")
fit_fs_2016$dhour <- format(fit_fs_2016$time, "%d %H")

ggplot(fit_fs_2016, aes(x=dhour, y=steps, group=mday)) + stat_summary(fun.y=sum, geom="line") + facet_wrap(~month) + ggtitle("Hourly activity from June 1st to September 17th")
ggsave("hourly_activity.png")
