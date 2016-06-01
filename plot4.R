# This R code generates the forth plot of the Project 1: plot4.R

#Preprocessing Steps

setwd("C:/Users/ahaldar/Desktop/Coursera")
rm(list=ls()) 
library(plyr)
library(data.table)
library(dplyr)

#Extraction of data
#Reading in data using read.table
filename<-"household_power_consumption.txt"
df_complete <- read.table(filename,
                          header=TRUE, sep=";",dec=".", 
                          stringsAsFactors=FALSE, na.strings = "?",
                          colClasses=c("character","character",rep("numeric",7)))

#Updating the Date and Time columns in data frame to proper date and time classes
DateTime<-paste(df_complete$Date,df_complete$Time)
df_complete$DateTime<-strptime(DateTime,"%d/%m/%Y %H:%M:%S") #Adding a new column

#Selecting relevant data
df_temp<- df_complete[df_complete$Date %in% c("1/2/2007","2/2/2007") ,]
# Or, df_temp  <- subset(df_complete, subset=(Date >= "2007/02/01" & Date <= "2007/02/02"))
Subset_df <-na.omit(df_temp)

# Generating Plot 4

# Setting the plot parameters to be 2 rows and 2 column plots
par(mfrow = c(2, 2))

# SubPlot 1: Global Active Power over time
with(Subset_df,plot(DateTime, Global_active_power, type="l", main="",
                    xlab="" , ylab="Global Active Power"))

# SubPlot 2: Voltage over time
with(Subset_df,plot(DateTime, Voltage, type="l", main="",
                    xlab="datetime" , ylab="Voltage"))

# SubPlot 3: Sub-metering over time
with(Subset_df,plot  (DateTime, Sub_metering_1, type="l", main="",
                      xlab="", 
                      ylab="Energy sub metering"))
with(Subset_df,lines(DateTime, Sub_metering_2, col="red"))
with(Subset_df,points(DateTime, Sub_metering_3, col="blue",type="l"))
legend("topright", lty=1, col=c("black","red","blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# SubPlot 4:Global reactive Power over time
with(Subset_df,plot(DateTime, Global_reactive_power, type="l", main="",
                    xlab="datetime" , 
                    ylab="Global_reactive_power"))


# Saving the plot to png file
dev.copy(png, file = "./plot4.png", width=480, height=480) 
dev.off()  # close the PNG device