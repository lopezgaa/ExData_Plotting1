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


png("Plot1.png")
par(mfrow=c(1,1))
hist(main_dataset$Global_active_power,col = "red",main = "Global Active Power",xlab = "Global Active Power (Kilowatts)")
dev.off()

#Return Locale to previous status
Sys.setlocale("LC_TIME",old_locale)