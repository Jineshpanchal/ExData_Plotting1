#Get data from particular source which is mentioned in project
data <- read.csv("G:/Data Scientist/Coursera/4. Exploratory Data analysis/project 1/household_power_consumption.txt", sep=";",na.string = "?")

#convert date column into character format in order to transform into date formate 
data$Date <- as.character(data$Date)
data$Date <- as.Date(data$Date,format = "%d/%m/%Y")

#select data which is required to be captured and processing
subdate <- subset(data, Date=="2007-02-01" | Date == "2007-02-02")

#convert Active power column into character format in order to transform into numeric format 
subdate$Global_active_power <- as.character(subdate$Global_active_power)
subdate$Global_active_power <- as.numeric(subdate$Global_active_power)

#Convert date into weekdays 
subdate$days <- wday(subdate$Date,label = TRUE)

#create new column called as "new" with merging time and date column
subdate$new <- paste(subdate$Date, subdate$Time, sep = " ")
subdate$new <- parse_date_time(subdate$new,"%Y%m%d %H%M%S" )

#Plot png file 
png("plot3.png")
with(subdate, plot(new,Sub_metering_1,type = "l",xlab = "",ylab = "Energy sub metering"))
with(subdate,lines(new, Sub_metering_2,col="red",type = "l"))
with(subdate,lines(new, Sub_metering_3,col="blue",type = "l"))
legend("topright",lty = c(1,1,1),col= c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
#In order to have proper margin we have dev.off()
dev.off()

