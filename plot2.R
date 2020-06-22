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
plot2Data = newData %>% 
    mutate(Date.Time = as.POSIXct(paste(Date, Time), 
                                  format = "%Y-%m-%d %H:%M:%S")) %>% 
    select(Date.Time, Global_active_power)
head(plot2Data)



# Open png file
png("plot2.png", width = 480, height = 480)

# Create the plot
plot(plot2Data$Date.Time, plot2Data$Global_active_power, 
     type="n",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
lines(plot2Data$Date.Time, plot2Data$Global_active_power)

# Close the file
dev.off()
