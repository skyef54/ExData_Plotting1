# This R code is a part of Exploratory Data Analysis course provided by Coursera.
# The code constructs the plot1 of Course Project 1.

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
names(df) <- scan(source_file, sep = ";", nlines = 1, what = "character", quiet = TRUE)

# add column with POSIXlt format by joining data form two columns
df$DateTime <- strptime(paste0(df$Date, " ", df$Time), "%d/%m/%Y %H:%M:%S")

# create file 1
hist(df$Global_active_power, col="red", main = "", xlab = "")
title(main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.print(device = png, file = "plot1.png", width = 480, height = 480)
