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
dataPlot <- as.numeric(dataSubset$Global_active_power)
hist(dataPlot, main="Global Active Power",  col="red", xlab="Global Active Power (kilowatts)",
          ylab = "Frequency")

#Saving data
dev.copy(png, "plot1.png", height = 480, width = 480, bg = "transparent")
dev.off()