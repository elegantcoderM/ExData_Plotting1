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

## Plot the histogram
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
hist(data$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency")

## Copy to a png file
dev.copy(png, file = "plot1.png", width=480, height=480)
dev.off()

