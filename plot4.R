# original file URL
downloadUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# file check
if (!file.exists("household_power_consumption.txt")) {
        download.file(downloadUrl, destfile = "plotData.zip")
        unzip("plotData.zip")
        file.remove("plotData.zip")
}

# load the file
#plotData <- read.table("household_power_consumption.txt", header=TRUE, sep=";",colClasses=rep(c("character","numeric"), c(2,7)), na.strings=c("?"))
colFormat <- c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
plotData <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", colClasses = colFormat, na.strings = "?")

# get the dates interval
plotData$DateTime <- paste(plotData$Date, plotData$Time)
plotData$DateTime <- strptime(plotData$DateTime, "%d/%m/%Y %H:%M:%S")
interval <- (plotData$DateTime >= "2007-02-01" & plotData$DateTime <= "2007-02-02")
plotData <- subset(plotData, interval == TRUE)

# set device and make plot
png(filename = "plot4.png",width=480, height=480, units="px", bg="transparent")

par(mfrow = c(2, 2))
with(plotData, {
        ylabel1 <- "Global Active Power"
        plot(plotData$DateTime, plotData$Global_active_power, type = "l", xlab = "", ylab = ylabel1)
        xlabel2 <- "datetime"
        ylabel2 <- "Voltage"
        plot(plotData$DateTime, plotData$Voltage, type = "l", xlab = xlabel2, ylab = ylabel2)
        ylabel3 <- "Energy sub metering"
        plot(plotData$DateTime, plotData$Sub_metering_1, type = "l", xlab = "", ylab = ylabel3)
        points(plotData$DateTime, plotData$Sub_metering_2, type = "l", col = "red")
        points(plotData$DateTime, plotData$Sub_metering_3, type = "l", col = "blue")
        legend.txt <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
        legend.col <- c("black", "red", "blue")
        legend("topright", legend = legend.txt, col = legend.col, lty = 1, lwd = 2)
        xlabel4 <- "datetime"
        ylabel4 <- "Global_reactive_power"
        plot(plotData$DateTime, plotData$Global_reactive_power, type = "l", xlab = xlabel4, ylab = ylabel4)
})

# close device
dev.off()