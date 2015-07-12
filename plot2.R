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
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
data <- tbl_df(data)
data <- mutate(data, DateTime = as.POSIXct(paste(data$Date, data$Time)))

with(data, plot(DateTime, Global_active_power, type = "l", main = "Global Active Power",
     ylab = "Global Active Power (kilowatts)", xlab = ""))

## Copy to a png file
dev.copy(png, file = "plot2.png", width=480, height=480)
dev.off()
