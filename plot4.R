#Store locale settings
old_locale<-Sys.getlocale(category = "LC_TIME")

#Change locale to english
Sys.setlocale("LC_TIME","English")

#read data from file
ds<-read.table("household_power_consumption.txt",sep = ";", header = TRUE,na.strings = "?",stringsAsFactors = FALSE)

#Conver datetime operations
dates<-ds$Date
times<-ds$Time
x<-paste(dates,times)
DateTime<-strptime(x, "%d/%m/%Y %H:%M:%S")
ds_datetime<-cbind(DateTime,ds[,seq(3,9)])
main_dataset<-subset(ds_datetime,(DateTime >= as.POSIXct("01/02/2007",format="%d/%m/%Y")) & (DateTime < as.POSIXct("03/02/2007",format="%d/%m/%Y")))

#plot

png("Plot4.png")
par(mfrow=c(2,2))

#Top left plot
plot(main_dataset$DateTime,main_dataset$Global_active_power, type = "n", xlab = "",ylab = "Global Active Power (Kilowatts)")
lines(main_dataset$DateTime,main_dataset$Global_active_power)

#Top right plot
plot(main_dataset$DateTime,main_dataset$Voltage, type = "n", xlab = "datetime",ylab = "Voltage")
lines(main_dataset$DateTime,main_dataset$Voltage)

#Bottom left plot
plot(main_dataset$DateTime,main_dataset$Sub_metering_1, type = "n", xlab = "",ylab = "Energy sub metering")

lines(main_dataset$DateTime,main_dataset$Sub_metering_1)
lines(main_dataset$DateTime,main_dataset$Sub_metering_2, col = "red")
lines(main_dataset$DateTime,main_dataset$Sub_metering_3, col = "blue")
legend("topright",lwd = 1,col=c("black","blue","red"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#Bottom right plot
plot(main_dataset$DateTime,main_dataset$Global_reactive_power, type = "n", xlab = "datetime",ylab = "Global_reactive_power")
lines(main_dataset$DateTime,main_dataset$Global_reactive_power)

dev.off()

#Return Locale to previous status
Sys.setlocale("LC_TIME",old_locale)