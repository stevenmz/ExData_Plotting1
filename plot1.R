# File: plot1.R
# Author: Steven Magana-Zook
# Created: 9/8/2016
# Purpose: To create an exploratory graph about household electricity usage in support of the Exploratory Data Analysis Coursera course (Week 1 Quiz)

columnTypes = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
columnNames = unlist(strsplit("Date;Time;Global_active_power;Global_reactive_power;Voltage;Global_intensity;Sub_metering_1;Sub_metering_2;Sub_metering_3",";"))

# Only read the two days of interest. Makes reading WAY faster.
powerDF = read.table("data/household_power_consumption.txt",
                     header = FALSE, # we wont read the heade rbecause we skip to the data of interest 
                     sep=";", 
                     na.strings = "?",
                     skip = 66637, # go to Feb-1-2007's first entry
                     nrows = 2879, #read till the last entry of Feb-2-2007
                     colClasses = columnTypes,
                     col.names = columnNames)
 
# Enforce that this script will generate a 1x1 panel of plots
# With RStudio, other scripts setting mfrow affects this one
par(mfrow = c(1,1))

hist(powerDF$Global_active_power, 
     col="red", 
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)")

dev.copy(png, "plot1.png", width=480, height=480)
dev.off()