## Read thewhole file and extract only days 2007-02-01 and 2007-02-02
whole <- read.table("household_power_consumption.txt", header = T, sep = ";",
                    na.strings = "?")
whole$Date <- strptime(whole$Date, "%d/%m/%Y")
startdate <- strptime("2007-02-01", "%Y-%m-%d")
enddate <- strptime("2007-02-02", "%Y-%m-%d")
exdata1 <- whole[(whole$Date >= startdate) & (whole$Date <= enddate),]

## Create a new column for POSIX time
Sys.setlocale("LC_ALL", "English")  ## So that weekdays have english
                                    ## abbreviations; in case the defauls
                                    ## is not English
exdata1$Weekdays <- weekdays(exdata1$Date, abbreviate=T)
exdata1$newTime <- strptime(paste(as.character(exdata1$Date), exdata1$Time),
                            "%Y-%m-%d %T")
## Open PNG device
png(filename = "plot4.png",
    width = 480, height = 480, units = "px")

## The actual plot
par(mfrow = c(2, 2))
plot(exdata1$newTime, exdata1$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power")
plot(exdata1$newTime, exdata1$Voltage, type = "l",
     xlab = "datetime", ylab = "Voltage")
plot(exdata1$newTime, exdata1$Sub_metering_1, type = "n",
     xlab = "", ylab = "Energy sub metering")
lines(exdata1$newTime, exdata1$Sub_metering_1, col = "black")
lines(exdata1$newTime, exdata1$Sub_metering_2, col = "red")
lines(exdata1$newTime, exdata1$Sub_metering_3, col = "blue")
legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1, 1, 1), col = c("black", "red", "blue"), bty = "n")
plot(exdata1$newTime, exdata1$Global_reactive_power, type = "l",
     xlab = "datetime", ylab = "Global_reactive_power")

## Close PNG device
dev.off()
