#Get data from particular source which is mentioned in project

data <- read.csv("G:/Data Scientist/Coursera/4. Exploratory Data analysis/project 1/household_power_consumption.txt", sep=";")
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

#ploting result
with(subdate,plot(new, Global_active_power,type = "l",ylab = "Global Active Power(Kilowatts)",xlab = ""))