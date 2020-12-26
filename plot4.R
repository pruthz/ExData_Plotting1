#Download the dataset.
if(!file.exists("./dataset")){dir.create("./dataset")}
datasetURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(datasetURL,destfile="./dataset/Dataset.zip",method="curl")

#Unzip the dataset.
unzip(zipfile = "./dataset/Dataset.zip", exdir = "./dataset")

#Check the downloaded dataset / list of the files to learn the file name
list.files(path = "./dataset")

#Read the data 
datasetpath <- file.path("./dataset")
allData <- read.csv("./dataset/household_power_consumption.txt", 
                    sep = ";", na.strings = "?")

#Subset required data
subData4 <- subset(allData, Date == "1/2/2007" | Date == "2/2/2007")

#Convert date format
subData4$Date <- as.Date(subData4$Date, format = "%d/%m/%Y")

#Create new column with date and time in POSIXct format
DateTime <- paste(subData4$Date, subData4$Time)
subData4$DateTime <- as.POSIXct(DateTime)
  
#Plot 4
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
with(subData4, {
     plot(Global_active_power~DateTime, xlab = " ", 
          ylab = "Global Active Power", 
          type = "l")
     plot(Voltage~DateTime, xlab = "datetime", ylab = "Voltage",
          type = "l")
     plot(Sub_metering_1~DateTime, xlab = " ", 
          ylab = "Energy sub metering", 
          type = "l")
     lines(Sub_metering_2~DateTime, col = "Red")
     lines(Sub_metering_3~DateTime, col = "Blue")
     legend("topright", col = c("black", "red", "blue"), lty = 1, 
            legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
            bty = "n")
     plot(Global_reactive_power~DateTime, xlab = "datetime", 
          ylab="Global_reactive_power (kilowatts)",type = "l")
     })
dev.off()
