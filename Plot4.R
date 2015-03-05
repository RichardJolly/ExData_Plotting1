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
# Open a png graphics device which creates a 480x480 pixel file named Plot4.png
png(filename = "Plot4.png",width = 480, height = 480, units = "px")
# Set the graphics area to contain four graphs
par(mfrow=c(2,2))
# Plot a line graph of Global Active Power
# Note the y-axis label differs from Plot2  - (kilowatts) has been removed
plot(powerConsumptionSubset.dt$dateTime,powerConsumptionSubset.dt$Global_active_power,type = "l",xlab="",ylab="Global Active Power")
# Plot a line graph of Power vs date/time
plot(powerConsumptionSubset.dt$dateTime,powerConsumptionSubset.dt$Voltage,type = "l",xlab="datetime",ylab="Voltage")
# Plot line graphs of Sub metering 1,2,3 vs date/time
# Note the legend box differs from Plot3 - it has no border
plot(powerConsumptionSubset.dt$dateTime,powerConsumptionSubset.dt$Sub_metering_1,type = "l",xlab="",ylab="Energy sub metering",col="black")
lines(powerConsumptionSubset.dt$dateTime,powerConsumptionSubset.dt$Sub_metering_2,col="red")
lines(powerConsumptionSubset.dt$dateTime,powerConsumptionSubset.dt$Sub_metering_3,col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),lwd=c(2.5,2.5,2.5),col=c("black","red","blue"),bty="n")
# plot a line graph of Global reactive power vs date/time
plot(powerConsumptionSubset.dt$dateTime,powerConsumptionSubset.dt$Global_reactive_power,type = "l",xlab="datetime",ylab="Global_reactive_power")
# Reset the graphics space for one graph
par(mfrow=c(1,1))
# Close the graphics device
dev.off()
