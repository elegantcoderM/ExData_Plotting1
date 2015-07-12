library(dplyr)

## Read File
data <- read.table("household_power_consumption.txt", header = TRUE,
                   sep = ";")
## Change dates to Date type 
dateFormat <- "%d/%m/%Y"
data$Date <- as.Date(data$Date, format = dateFormat)

## Get subset of dates 2007-02-01 and 2007-02-02
date1 <- as.Date("01/02/2007", format = dateFormat)
date2 <- as.Date("02/02/2007", format = dateFormat)

data <- subset(data, date1 == Date | date2 == Date)

## Plot graph
data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
data$Sub_metering_3 <- as.numeric(as.character(data$Sub_metering_3))
data <- tbl_df(data)
data <- mutate(data, DateTime = as.POSIXct(paste(data$Date, data$Time)))

png(file = "plot3.png", width = 480, height = 480)
with(data, plot(DateTime, Sub_metering_1, type = "l", main = "Energy sub metering",
                ylab = "Energy sub metering", xlab = ""))
lines(Sub_metering_2 ~ DateTime, data, col = "red")
lines(Sub_metering_3 ~ DateTime, data, col = "blue")

legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = 1, col = c("black", "red", "blue"))
dev.off()
