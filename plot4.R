#read in file
file=file.path("household_power_consumption.txt")
dfheader=read.csv2(file,header=T,nrow=1)
nc=ncol(dfheader)

#read only rows in certain date range
DF.Date = read.csv2(file, header = TRUE, as.is=T,colClasses = c(NA, rep("NULL", nc - 1)))
DF.Date$Date=as.Date(DF.Date$Date,"%d/%m/%Y")
ndate=DF.Date$Date>="2007-02-01" & DF.Date$Date<="2007-02-02"
df = read.csv2(file, col.names = names(dfheader), skip = which.max(ndate), nrows=sum(ndate)-1,as.is = TRUE,dec=".")

#create datetime column
df$Date=as.Date(df$Date,"%d/%m/%Y")
df$datetime=as.POSIXct(paste(df$Date, df$Time), format="%Y-%m-%d %H:%M:%S")

#make png plot
png(filename="plot4.png",width=480,height=480)
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
plot(x=df$datetime,y=df$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")
plot(x=df$datetime,y=df$Voltage,type="l",xlab="datetime",ylab="Voltage")
plot(x=df$datetime,y=df$Sub_metering_1,type="l",ylab="Energy sub metering",xlab="")
lines(x=df$datetime,y=df$Sub_metering_2, col="orangered")
lines(x=df$datetime,y=df$Sub_metering_3, col="blue")
legend("topright",legend=colnames(df)[(ncol(df)-3):(ncol(df)-1)],lty=c(1,1,1),col=c("black","orangered","blue"),bty="n")
plot(x=df$datetime,y=df$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")
graphics.off()