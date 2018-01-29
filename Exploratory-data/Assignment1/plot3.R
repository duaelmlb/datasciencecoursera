## Script that generates the plot3.png file

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
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

## Subset raw data with rows with date = 2007-02-01 and 2007-02-02
datafeb <- subset(data, data$Date == "2007-02-01" | data$Date == "2007-02-02")

## Creating the plot3
# Create the png file
png(filename = "plot3.png", width = 480, height = 480, units = "px")

with(datafeb, plot(x = Time,
                   y = Sub_metering_1,
                   type = "n",
                   xlab = "",
                   ylab = "Energy sub metering"))

points(x = datafeb$Time, y = datafeb$Sub_metering_1, type = "l", col = "black")
points(x = datafeb$Time, y = datafeb$Sub_metering_2, type = "l", col = "red")
points(x = datafeb$Time, y = datafeb$Sub_metering_3, type = "l", col = "blue")

legend("topright", 
       lty = 1, 
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()
