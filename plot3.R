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
plot3Data = newData %>% 
    mutate(Date.Time = as.POSIXct(paste(Date, Time), 
                                  format = "%Y-%m-%d %H:%M:%S")) %>% 
    select(Date.Time, Sub_metering_1, Sub_metering_2, Sub_metering_3)
head(plot3Data)


# Open png file
png("plot3.png", width = 480, height = 480)

# Create the plot
plot(plot3Data$Date.Time, plot3Data$Sub_metering_1, 
     type = "n",
     xlab = "",
     ylab = "Energy sub metering")
lines(plot3Data$Date.Time, plot3Data$Sub_metering_1, col = "black")
lines(plot3Data$Date.Time, plot3Data$Sub_metering_2, col = "red")
lines(plot3Data$Date.Time, plot3Data$Sub_metering_3, col = "blue")
legend("topright", 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"),
       lty=1)

# Close the file
dev.off()
