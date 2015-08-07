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
png(filename = "plot2.png",
    width = 480, height = 480, units = "px")

## The actual plot
plot(exdata1$newTime, exdata1$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power (kilowatts)")

## Close PNG device
dev.off()
