## Script that generates the plot2.png file

## Precondition : Downloading and unzipping the .zip containing the raw data
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url = fileURL, 
              destfile = "AssignmentData.zip", 
              method = "curl")
unzip("./AssignmentData.zip",exdir=".")

## Read the file
data <- read.table(file = "./household_power_consumption.txt", 
                   sep = ";", 
                   header = TRUE,
                   colClasses = "character")

##Convert date and time
data$Time <- strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$Global_active_power <- as.numeric(data$Global_active_power)

## Subset raw data with rows with date = 2007-02-01 and 2007-02-02
datafeb <- subset(data, data$Date == "2007-02-01" | data$Date == "2007-02-02")

## Creating the plot2
# Create the png file
png(filename = "plot2.png", width = 480, height = 480, units = "px")

with(datafeb, plot(x = Time,
                   y = Global_active_power,
                   type = "l",
                   xlab = "",
                   ylab = "Global Active Power (kilowatts)"))

dev.off()
