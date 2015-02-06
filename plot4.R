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

compl_cases_Gap<-complete.cases(two_day_data$Sub_metering_1,
                                two_day_data$Sub_metering_2,
                                two_day_data$Sub_metering_3)



png(filename="/Users/Samer/datasciencecoursera/plot4.png",width=480,height=480,units="px")

par(ann=FALSE,mfcol=c(2,2))
with (two_day_data[compl_cases_Gap,],plot(datetime,Global_active_power,type="l"))
title(ylab="Global Active Power (kilowatts)")

with(two_day_data[compl_cases_Gap,],plot(datetime,Sub_metering_1,type="n"))
with (two_day_data[compl_cases_Gap,],points(datetime,Sub_metering_1,type="l"))
with (two_day_data[compl_cases_Gap,],points(datetime,Sub_metering_2,type="l",col="red"))
with (two_day_data[compl_cases_Gap,],points(datetime,Sub_metering_3,type="l",col="blue"))
title(ylab="Energy sub metering")
legend("topright", col = c("black","red", "blue"),bty="n", legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),lty=1,col)

with (two_day_data[compl_cases_Gap,],plot(datetime,Voltage,type="l"))
title(ylab="Voltage",xlab="datatime")

with (two_day_data[compl_cases_Gap,],plot(datetime,Global_reactive_power,type="l"))
title(ylab="Global_reactive_power",xlab="datatime")

dev.off()