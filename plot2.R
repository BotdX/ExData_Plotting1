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
png(filename="plot2.png",width=480,height=480)
plot(x=df$datetime,y=df$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")
graphics.off()