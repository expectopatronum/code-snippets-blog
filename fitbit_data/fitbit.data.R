library(ggplot2)

read.fitbit <- function(filename) {
  all <- readLines(filename)
  all <- all[all != ""]
  starts <- which(grepl("^Datum", all))
  activity_start <- starts[1]
  sleep_start <- starts[2]
  activity_data <- read.csv(textConnection(all[activity_start:(sleep_start-2)]), stringsAsFactors = FALSE, dec = ",")
  sleep_data <-read.csv(textConnection(all[sleep_start:length(all)]), stringsAsFactors = FALSE)
  
  # rename columns
  colnames(activity_data) <- c("date", "burned.calories", "steps", "distance", "levels", "min.sitting", "min.leight", "min.high", "min.veryhigh", "act.calories")
  colnames(sleep_data) <- c("date", "min.sleep", "min.awake", "times.awake", "time.bed")
  
  # replace dots and commas, convert to integers/numeric
  activity_data$burned.calories <- as.integer(sub("[.]", "", activity_data$burned.calories))
  activity_data$steps <- as.integer(sub("[.]", "", activity_data$steps))
  activity_data$min.sitting <- as.integer(sub("[.]", "", activity_data$min.sitting))
  activity_data$act.calories <- as.integer(sub("[.]", "", activity_data$act.calories))
  
  data <- merge(activity_data, sleep_data, by="date")
  
  return (data)  
}


split.date <- function(data) {
  spl.data <- strsplit(data$date, "[-]")
  day <- sapply(spl.data, "[[", 1)
  month <- sapply(spl.data, "[[", 2)
  year <- sapply(spl.data, "[[", 3)
  data$day <- as.integer(day)
  data$month <- as.integer(month)
  data$year <- as.integer(year)
  data$date <-as.Date(data$date)
  data$wday <- factor(weekdays(data$date), levels = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"), ordered=TRUE)
  data$weeknr <- strftime(data$date,format="%W")
  data$wknd <- data$wday %in% c("Saturday", "Sunday")
  return(data)
}

