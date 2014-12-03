#Get data from particular source which is mentioned in project
data <- read.csv("G:/Data Scientist/Coursera/4. Exploratory Data analysis/project 1/household_power_consumption.txt", sep=";",na.string = "?")

#convert date column into character format in order to transform into date formate 
data$Date <- as.character(data$Date)

#select data which is required to be captured and processing
data$Date <- as.Date(data$Date,format = "%d/%m/%Y")
subdate <- subset(data, Date=="2007-02-01" | Date == "2007-02-02")

#convert Active power column into character format in order to transform into numeric format 
subdate$Global_active_power <- as.character(subdate$Global_active_power)
subdate$Global_active_power <- as.numeric(subdate$Global_active_power)

#Convert date into weekdays 
subdate$days <- wday(subdate$Date,label = TRUE)

#create new column called as "new" with merging time and date column
subdate$new <- paste(subdate$Date, subdate$Time, sep = " ")
subdate$new <- parse_date_time(subdate$new,"%Y%m%d %H%M%S" )

# ploting all four picture together in single png file
png("plot4.png")

#select 2 row and 2 column
par(mfrow = c(2,2))

#firt image plotting
with(subdate,plot(new, Global_active_power,type = "l",ylab = "Global Active Power",xlab = ""))

#second image plotting
with(subdate,plot(new,Voltage,type = "l",ylab = "Voltage",xlab = "datetime"))

#third image plotting
with(subdate, plot(new,Sub_metering_1,type = "l",xlab = "",ylab = "Energy sub metering"))
with(subdate,lines(new, Sub_metering_2,col="red",type = "l"))
with(subdate,lines(new, Sub_metering_3,col="blue",type = "l"))
legend("topright",bty = "n",lty = c(1,1,1),col= c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#fourth image plotting
with(subdate,plot(new,Global_reactive_power,type = "l",ylab = "Global_reactive_power",xlab = "datetime"))
dev.off()
