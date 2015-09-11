#Downloads dataset
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(url,temp)
data <- read.table(unz(temp,  unzip(temp, list = TRUE)[1,1]), sep = ";", header = TRUE, na.strings = c("?"))
unlink(temp)

#Converts "Date" and "Time" variables in Date/Time format and subsets the dataset
Sys.setlocale("LC_TIME", "C")
data$Time <- paste(data$Date, data$Time)
data$Time <- strptime(data$Time, "%d/%m/%Y %H:%M:%S")
data <- data[, c(2:ncol(data))]
data <- subset(data, data$Time >= "2007-02-01 00:00:00" & data$Time < "2007-02-03 00:00:00")

#Plot 1
par(mfcol = c(2,2))
plot(data$Time, data$Global_active_power, type = "l", xlab ="", ylab = "Global Active Power") 
#Plot2
plot(data$Time, data$Sub_metering_1, type = "l", xlab ="", ylab = "Energy sub metering") 
points(data$Time, data$Sub_metering_2, col = "red", type = "l")
points(data$Time, data$Sub_metering_3, col = "blue", type = "l")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 1, col = c("Black","Red","Blue"))
#Plot3
plot(data$Time, data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage") 
#Plot4
plot(data$Time, data$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global Reactive Power") 

dev.copy(png, file = "plot4.png")
dev.off() 

