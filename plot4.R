#' File: plot4.R
#' Author: Steven Magana-Zook
#' Created: 9/9/2016
#' Purpose: To create an exploratory graph about household electricity 
#' usage in support of the Exploratory Data Analysis Coursera course (Week 1 Quiz)

columnTypes = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
columnNames = unlist(strsplit("Date;Time;Global_active_power;Global_reactive_power;Voltage;Global_intensity;Sub_metering_1;Sub_metering_2;Sub_metering_3",";"))

# Only read the two days of interest. Makes reading WAY faster.
powerDF = read.table("data/household_power_consumption.txt",
                     header = FALSE, # we wont read the heade rbecause we skip to the data of interest 
                     sep=";", 
                     na.strings = "?", #NA strings specified in assignment write-up
                     skip = 66637, # go to Feb-1-2007's first entry
                     nrows = 2879, #read till the last entry of Feb-2-2007
                     colClasses = columnTypes,
                     col.names = columnNames)

# Combine the contents fo the date and time columns so we can plot them as one value
powerDF$DateTime = paste(powerDF$Date,powerDF$Time)

# change the column type to be POSIXlt instead of character so we can treat the timestamps as date time values
powerDF$DateTime = strptime(powerDF$DateTime, "%d/%m/%Y %H:%M:%S")


png(file="plot4.png", width=480, height=480)
 
par(mfrow = c(2,2))

plot(powerDF$DateTime, 
     powerDF$Global_active_power, 
     type="l", #Line chart
     xlab="", #Let R set x-tick labels
     ylab="Global Active Power (kilowatts)" #Assignment specifies this label
)

plot(powerDF$DateTime, 
     powerDF$Voltage, 
     type="l", #Line chart
     xlab="datetime", 
     ylab="Voltage"
)

plot(powerDF$DateTime, 
     powerDF$Sub_metering_1, 
     type="l", #Line chart
     xlab="", #Let R set x-tick labels
     ylab="",
     col="black"
)

lines(powerDF$DateTime, 
      powerDF$Sub_metering_2, 
      col="red"
)

lines(powerDF$DateTime, 
      powerDF$Sub_metering_3, 
      col="blue"
)
title(ylab="Energy sub metering")

legend("topright", #Where to put the legend
       legend=paste("Sub_metering_",1:3), #Wording for each legend item
       lty=1, #Type of line to show in legend for each item
       col=c("black","red","blue")) #Color cooresponding to the lines/label

plot(powerDF$DateTime, 
     powerDF$Global_reactive_power, 
     type="l", #Line chart
     xlab="datetime", #Let R set x-tick labels
     ylab="Global_reactive_power"
)

dev.off()
