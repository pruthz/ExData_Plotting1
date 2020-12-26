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
subData1 <- subset(allData, Date == "1/2/2007" | Date == "2/2/2007")

#Convert date and time variables
subData1$Date <- as.Date(subData1$Date, format = "%d/%m/%Y")
subData1$Time <- strptime(subData1$Time, format = "%H:%M:%S")
  
#Plot 1
png("plot1.png", width = 480, height = 480)
hist(subData1$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "Red")
dev.off()
