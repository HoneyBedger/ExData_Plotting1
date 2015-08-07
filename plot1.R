## Read thewhole file and extract only days 2007-02-01 and 2007-02-02
whole <- read.table("household_power_consumption.txt", header = T, sep = ";",
                    na.strings = "?")
whole$Date <- strptime(whole$Date, "%d/%m/%Y")
startdate <- strptime("2007-02-01", "%Y-%m-%d")
enddate <- strptime("2007-02-02", "%Y-%m-%d")
exdata1 <- whole[(whole$Date >= startdate) & (whole$Date <= enddate),]


## Open PNG device
png(filename = "plot1.png",
    width = 480, height = 480, units = "px")

## The actual plot
hist(exdata1$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency")

## Close PNG device
dev.off()
