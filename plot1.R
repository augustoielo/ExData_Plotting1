# original file URL
downloadUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# file check
if (!file.exists("household_power_consumption.txt")) {
        download.file(downloadUrl, destfile = "plotData.zip")
        unzip("plotData.zip")
        file.remove("plotData.zip")
}

# load the file
plotData <- read.table("household_power_consumption.txt", header=TRUE, sep=";",colClasses=rep(c("character","numeric"), c(2,7)), na.strings=c("?"))

# get the dates interval
interval <- plotData$Date == "1/2/2007" | plotData$Date == "2/2/2007"
plotData <- plotData[interval,]

# set device and make plot
png(filename = "plot1.png",width=480, height=480, units="px", bg="transparent")
hist(plotData$Global_active_power, xlab="Global Active Power (kilowatts)", ylab="Frequency", main="Global Active Power", col="Red")

# close device
dev.off()
