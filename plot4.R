# This R code is a part of Exploratory Data Analysis course provided by Coursera.
# The code constructs the plot4 of Course Project 1.

# define input file
source_file <- "household_power_consumption.txt"

# download file if it doesn't exist
if (!file.exists(source_file)){
  download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "file.zip")
  unzip("file.zip")
}

# define dates to read data
validDates_pattern <- "^[1-2]/2/2007"
pipe_params <- paste0("findstr \"", validDates_pattern, "\" \"", source_file, "\"")

# load data into dataframe, PIPE method. Use date filtered input for read function. Extremely saves time and memory.
df <- read.table(pipe(pipe_params), sep = ";", stringsAsFactors = F, na.strings = "?") 
names(df) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", 
               "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

# add column with POSIXlt format by joining data form two columns
df$DateTime <- strptime(paste0(df$Date, " ", df$Time), "%d/%m/%Y %H:%M:%S")

# create file 4
png("plot4.png")
par(mfcol = c(2,2))

# create topleft plot
plot(df$DateTime, df$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

# create bottomleft plot
plot(df$DateTime, df$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
points(df$DateTime, df$Sub_metering_2, type = "l", col = "red")
points(df$DateTime, df$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), pch = "_", bty = "n")

# create topright plot
plot(df$DateTime, df$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

# create bottomright plot
plot(df$DateTime, df$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

dev.off()
