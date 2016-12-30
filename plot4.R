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
png("plot4.png", width=480, height=480)

# create plot per course specs
par(mfrow = c(2, 2))

# top left plot from plot2.R with modified y-label
with(epc, plot(Global_active_power ~ Time, type = "l", xlab = "",
               ylab = "Global Active Power"))

# top right plot per course specs
with(epc, plot(Voltage ~ Time, type = "l", xlab = "datetime", ylab = "Voltage"))

# bottom left plot from plot3.R
with(epc, {
        plot(Sub_metering_1 ~ Time, type = "l", col = "Black", xlab = "",
             ylab = "Energy sub metering")
        lines(Sub_metering_2 ~ Time, col = "Red")
        lines(Sub_metering_3 ~ Time, col = "Blue")
})
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1, bty = "n")

# bottom right plot per course specs
with(epc, plot(Global_reactive_power ~ Time, type = "l", 
               xlab = "datetime", ylab = "Global_reactive_power"))

# close the PNG device
dev.off()