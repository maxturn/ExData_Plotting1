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
table(newData$Date)
head(newData)

# Data for Plot 1 
plot1Data = newData$Global_active_power

# Open png file
png("plot1.png", width = 480, height = 480)

# Create the plot
hist(plot1Data, 
     col = "red",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency",
     main = "Global Active Power")

# Close the file
dev.off()
