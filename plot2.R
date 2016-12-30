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
png("plot2.png", width=480, height=480)

# create plot per course specs
with(epc, plot(Global_active_power ~ Time, type = "l", xlab = "",
               ylab = "Global Active Power (kilowatts)"))

# close the PNG device
dev.off()