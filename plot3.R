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

# set colors
colors <- c("black","red","blue")

# set device and make plot
png(filename = "plot3.png",width=480, height=480, units="px", bg="transparent")

with(plotData,{
        plot(x=seq_along(Sub_metering_1), y=Sub_metering_1, type="n", main="", ylab="Energy sub metering", xlab="", xaxt="n");
        for (i in 1:3){
                lines(x=seq_along(Sub_metering_1),
                      y=plotData[,6+i],
                      type="l",
                      col=colors[i])
        };
        axis(side=1, at=c(0, min(which(weekdays(plotData$Date)=="Friday")), length(plotData$Date)), labels=c("Thu","Fri","Sat"));
        legend("topright", legend=names(plotData)[7:9], col=colors, lty=1)
})

# close device
dev.off()