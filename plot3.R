# This R code generates the third plot of the Project 1: plot3.R

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

# Generating Plot 3
# Plot - Sub-metering plots over Time 

with(Subset_df,plot(DateTime,Sub_metering_1, type="l",
               xlab="",ylab = "Energy Sub Metering",col="grey"))
with(Subset_df,points(DateTime,Sub_metering_2, type="l",
                 xlab="",ylab = "Energy Sub Metering",col="red"))
with(Subset_df,points(DateTime,Sub_metering_3,type="l",
                 xlab="",ylab = "Energy Sub Metering",col="blue"))

legend("topright", lty=1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Saving the plot to png file
dev.copy(png, file = "./plot3.png", width=480, height=480) 
dev.off()  # close the PNG device
