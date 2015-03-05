library(dplyr)
library(data.table)
# Download the source file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","householdPowerConsumption.zip",mode = "wb")
# Unzip the data file into a text file
unzip("householdPowerConsumption.zip")
# Read the text data file into a data frame
householdPowerConsumption.df <- read.delim("household_power_consumption.txt",header = TRUE, sep = ";", na.strings = "?",stringsAsFactors = FALSE) 
# Convert the data frame to a data table
householdPowerConsumption.dt <- as.data.table(householdPowerConsumption.df)
# Add a column that contains Date/Time in POSIXct format
householdPowerConsumption.dt$dateTime <- as.POSIXct(strptime((paste(householdPowerConsumption.dt$Date,householdPowerConsumption.dt$Time)),format="%d/%m/%Y %H:%M:%S"))
# Convert Date column from character 
householdPowerConsumption.dt$Date <- as.Date(householdPowerConsumption.dt$Date,format="%d/%m/%Y")
# Create a data table that contains the subset of data collected during the period 2/1/2007 & 2/2/2007
powerConsumptionSubset.dt <- filter(householdPowerConsumption.dt, householdPowerConsumption.dt$Date == "2007-02-01"| householdPowerConsumption.dt$Date == "2007-02-02")

#######################################################################################################
#######################################################################################################

# Open a png graphics device which creates a 480x480 pixel file named Plot3.png
png(filename = "Plot3.png",width = 480, height = 480, units = "px")
# Plot a line graph of Sub metering 1 colored black
plot(powerConsumptionSubset.dt$dateTime,powerConsumptionSubset.dt$Sub_metering_1,type = "l",xlab="",ylab="Energy sub metering",col="black")
# Plot a line graph of Sub metering 2 colored red
lines(powerConsumptionSubset.dt$dateTime,powerConsumptionSubset.dt$Sub_metering_2,col="red")
# Plot a line graph of Sub metering 3 colored blue
lines(powerConsumptionSubset.dt$dateTime,powerConsumptionSubset.dt$Sub_metering_3,col="blue")
# Create a legend box in the top right corner of the graph
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),lwd=c(2.5,2.5,2.5),col=c("black","red","blue"))
# Close the png graphics device
dev.off()