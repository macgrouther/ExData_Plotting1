# load the "dtplyr" and "datasets" libraries
library(dtplyr)
library(datasets)

# read the relevant data set (text file) into a data table called "alldata"
alldata <- read.table("./data/household_power_consumption.txt", header = TRUE,
                      sep = ";", na.strings = "?", stringsAsFactors = FALSE)

# convert the variable "Date" from a variable of class "chr" to class "Date"
alldata$Date <- as.Date(alldata$Date, format = "%d/%m/%Y")

# subset the data to only include the observations from 2007-02-01 and 2007-02-02
# then remove the large data table "alldata" to clean up the environment
epc <- subset(alldata, Date == "2007-02-01" | Date == "2007-02-02")
rm(alldata)

# convert the variable "Time" from a variable of class "chr" to class POSIXct
# then remove the vector "datetime" to clean up the environment
datetime <- paste(as.Date(epc$Date), epc$Time)
epc$Time <- as.POSIXct(datetime)
rm(datetime)

# create png file per course specs
png("plot3.png", width=480, height=480)

# create plot per course specs
with(epc, {
        plot(Sub_metering_1 ~ Time, type = "l", col = "Black", xlab = "",
             ylab = "Energy sub metering")
        lines(Sub_metering_2 ~ Time, col = "Red")
        lines(Sub_metering_3 ~ Time, col = "Blue")
        })
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# close the PNG device
dev.off()