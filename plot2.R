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
plotData$Date<-as.Date(factor(plotData$Date),format="%d/%m/%Y")
plotData$Time<-strptime(plotData$Time,format="%X")

# set device and make plot
png(filename = "plot2.png",width=480, height=480, units="px", bg="transparent")

with(plotData,{
        plot(x=seq_along(Global_active_power), y=Global_active_power, type="l", main="", ylab="Global Active Power (kilowatts)", xlab="", xaxt="n");
        axis(side=1, at=c(0, min(which(weekdays(plotData$Date)=="Friday")), length(plotData$Date)), labels=c("Thu","Fri","Sat"))
        })

# close device
dev.off()