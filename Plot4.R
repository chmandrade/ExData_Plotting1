#By: Henrique Andrade
#his assignment uses data from the UC Irvine Machine Learning Repository, 
#a popular repository for machine learning datasets

#library
library(datasets)

#configuration settings
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fileData <- './data/Data.zip'
data <- './data'
datasetWork <- "household_power_consumption.txt"
sepFile <- '/'
sep <- ';'

#Check data file
if ( !file.exists(data) ) {
  dir.create(paste(".", data, sep=sepFile))
}

#Download data files
if ( !file.exists(fileData) ) {
  download.file(fileUrl, destfile = fileData, method = "curl")
  unzip(fileData, exdir=data)
}

# Data Loading
data.all <- read.table(paste(data,datasetWork, sep=sepFile),
                       header=TRUE, sep=sep, na.strings="?")

#Filtering Data
dates <- c("1/2/2007", "2/2/2007")
dataSubset <- subset(data.all, Date %in% dates)

#Plotting

plotDataActive <- as.numeric(dataSubset$Global_active_power)
plotDataVoltage <- as.numeric(dataSubset$Voltage)
plotDataReactive <- as.numeric(dataSubset$Global_reactive_power)

#dasy format
days <- strptime(paste(dataSubset$Date, dataSubset$Time), format="%d/%m/%Y %H:%M:%S")

submetering1 <- as.numeric(as.character(dataSubset$Sub_metering_1))
submetering2 <- as.numeric(as.character(dataSubset$Sub_metering_2))
submetering3 <- as.numeric(as.character(dataSubset$Sub_metering_3))

par(mfcol = c(2, 2))

#plot 1
plot(days, plotDataActive, type="l", xlab="", ylab="Global Active Power (kilowatts)")

# Plot 2
plot(days, submetering1, type="l", xlab="", ylab="Energy sub metering")
lines(days, submetering1, col="black")
lines(days, submetering2, col="red")
lines(days, submetering3, col="blue")

legend("topright", lty=1, bty = "n", cex=0.5, col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#plot 3
plot(days, plotDataVoltage, type = "l", ylab = "Voltage", xlab = "datetime")

#plot 4
plot(days, plotDataReactive, type="l", xlab = "datetime", ylab="Global_reactive_power")

#Saving data
dev.copy(png, "plot4.png", height = 480, width = 480, bg = "transparent")
dev.off()