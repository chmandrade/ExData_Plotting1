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

#Plotting data
plotData <- as.numeric(dataSubset$Global_active_power)
days <- strptime(paste(dataSubset$Date, dataSubset$Time), format="%d/%m/%Y %H:%M:%S")
plot(days, plotData, type="l", xlab="", ylab="Global Active Power (kilowatts)")

#Saving data
dev.copy(png, "plot2.png", height = 480, width = 480, bg = "transparent")
dev.off()