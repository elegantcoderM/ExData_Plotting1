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

## Add DateTime column
data <- tbl_df(data)
data <- mutate(data, DateTime = as.POSIXct(paste(data$Date, data$Time)))

## Plot graphs
png(file = "plot4.png", width = 480, height = 480)
## Make the canvas ready for 4 plots (2 by 2)
par(mfrow = c(2, 2))

## Plot Global_active_power
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
with(data, plot(DateTime, Global_active_power, type = "l",
                ylab = "Global Active Power", xlab = ""))

## Plot Voltage
data$Voltage <- as.numeric(as.character(data$Voltage))
with(data, plot(DateTime, Voltage, type = "l",
                ylab = "Voltage", xlab = ""))

## Plot Sub Metering
data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
data$Sub_metering_3 <- as.numeric(as.character(data$Sub_metering_3))

with(data, plot(DateTime, Sub_metering_1, type = "l",
                ylab = "Energy sub metering", xlab = ""))
lines(Sub_metering_2 ~ DateTime, data, col = "red")
lines(Sub_metering_3 ~ DateTime, data, col = "blue")

legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = 1, col = c("black", "red", "blue"))

## Plot Voltage
data$Global_reactive_power <- as.numeric(as.character(data$Global_reactive_power))
with(data, plot(DateTime, Global_reactive_power, type = "l",
                ylab = "Global_reactive_power", xlab = ""))

dev.off()
