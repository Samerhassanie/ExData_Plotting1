library(lubridate)
library(dplyr)

my_data<-read.csv("household_power_consumption.txt",colClasses="character",sep=";")
my_data<-mutate(my_data,datetime=as.POSIXct(paste(my_data$Date, my_data$Time), format="%d/%m/%Y %H:%M:%S"))
suppressWarnings(my_data[,3]<-as.numeric(my_data[,3]))
suppressWarnings(my_data[,4]<-as.numeric(my_data[,4]))
suppressWarnings(my_data[,5]<-as.numeric(my_data[,5]))
suppressWarnings(my_data[,6]<-as.numeric(my_data[,6]))
suppressWarnings(my_data[,7]<-as.numeric(my_data[,7]))
suppressWarnings(my_data[,8]<-as.numeric(my_data[,8]))
suppressWarnings(my_data[,9]<-as.numeric(my_data[,9]))

two_day_data<-my_data[(my_data$datetime>=ymd_hms("2007-02-01 00:00:00 CET") 
                       & my_data$datetime<=ymd_hms("2007-02-03 00:00:00 CET") ),]

compl_cases_Gap<-complete.cases(two_day_data$Global_active_power)



png(filename="/Users/Samer/datasciencecoursera/plot2.png",width=480,height=480,units="px")

par(ann=FALSE)
with (two_day_data[compl_cases_Gap,],plot(datetime,Global_active_power,type="l"))
title(ylab="Global Active Power (kilowatts)")

dev.off()