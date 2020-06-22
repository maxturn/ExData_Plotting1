setwd("~/desktop/Coursera/Exploratory Data Analysis")
rm(list=ls())

library(tidyverse)

# Read in the Data
myData = read_delim("household_power_consumption.txt", 
                    delim = ";", 
                    col_names=TRUE) 
head(myData)


# Cleaned the Data 
newData = myData %>% 
    mutate(Date = as.Date(Date, format="%d/%m/%Y")) %>% 
    filter (Date >= "2007-02-01", Date <= "2007-02-02") 
head(newData)


# Combine the Date and Time columns to create data for the plot and select
# only the variables needed for the plot.
plot4Data = newData %>% 
    mutate(Date.Time = as.POSIXct(paste(Date, Time), 
                                  format = "%Y-%m-%d %H:%M:%S")) %>% 
    select(Date.Time, Sub_metering_1, Sub_metering_2, Sub_metering_3,
           Global_active_power, Global_reactive_power, Voltage)
head(plot4Data)


# Open png file
png("plot4.png", width = 480, height = 480)

# Create the plots
par(mfrow=c(2,2))
# Global Active Power vs. Time
plot(plot4Data$Date.Time, plot4Data$Global_active_power, 
     type="n",
     xlab = "",
     ylab = "Global Active Power")
lines(plot4Data$Date.Time, plot4Data$Global_active_power)

# Voltage vs. Time
plot(plot4Data$Date.Time, plot4Data$Voltage, 
     type = "n",
     xlab = "datetime",
     ylab = "Voltage")
lines(plot4Data$Date.Time, plot4Data$Voltage)

# Energy sub metering vs Time
plot(plot4Data$Date.Time, plot4Data$Sub_metering_1, 
     type = "n",
     xlab = "",
     ylab = "Energy sub metering")
lines(plot4Data$Date.Time, plot4Data$Sub_metering_1, col = "black")
lines(plot4Data$Date.Time, plot4Data$Sub_metering_2, col = "red")
lines(plot4Data$Date.Time, plot4Data$Sub_metering_3, col = "blue")
legend("topright", 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"),
       lty=1,
       box.lty=0)

# Global reactive power vs. Time
plot(plot4Data$Date.Time, plot4Data$Global_reactive_power, 
     type = "n",
     xlab = "datetime",
     ylab = "Global_reactive_power")
lines(plot4Data$Date.Time, plot4Data$Global_reactive_power)

# Close the file
dev.off()
