#Download the dataset.
if(!file.exists("./dataset")){dir.create("./dataset")}
datasetURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(datasetURL,destfile="./dataset/Dataset.zip",method="curl")

#Unzip the dataset.
unzip(zipfile = "./dataset/Dataset.zip", exdir = "./dataset")

#Check the downloaded dataset. Get the list of the files to learn the file name
list.files(path = "./dataset")

#Read the data 
datasetpath <- file.path("./dataset")
allData <- read.csv("./dataset/household_power_consumption.txt", sep = ";", na.strings = "?")

#Subset required data
subData2 <- subset(allData, Date == "1/2/2007" | Date == "2/2/2007")

#Convert date format
subData2$Date <- as.Date(subData2$Date, format = "%d/%m/%Y")

#Create new column with date and time in POSIXct format
DateTime <- paste(subData2$Date, subData2$Time)
subData2$DateTime <- as.POSIXct(DateTime)
  
#Plot 2
png("plot2.png", width = 480, height = 480)
with(subData2, plot(Global_active_power~DateTime, xlab = " ", ylab = "Global Active Power (kilowatts)", type = "l"))
dev.off()
