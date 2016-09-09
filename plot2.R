#' File: plot2.R
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

# Enforce that this script will generate a 1x1 panel of plots
# With RStudio, other scripts setting mfrow affects this one
par(mfrow = c(1,1))

plot(powerDF$DateTime, 
     powerDF$Global_active_power, 
     type="l", #Line chart
     xlab="", #Let R set x-tick labels
     ylab="Global Active Power (kilowatts)" #Assignment specifies this label
)

# Save the plot currently on the screen device to the PNG device(file)
dev.copy(png, "plot2.png", width=480, height=480)
dev.off()
