library(dplyr)

readData <- function() {
        setClass("myDate")
        setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y"))
        colclasses <- c("myDate","character","numeric","numeric","numeric",
                        "numeric","numeric","numeric","numeric")
        df <- read.table("household_power_consumption.txt", sep = ";", 
                           na.strings = "?", header = TRUE, colClasses = colclasses)

        df <- filter(df, Date == "2007-02-01" | Date == "2007-02-02")
        DateTime <- strptime(paste(df$Date, df$Time), "%Y-%m-%d %H:%M:%S")
        df <- cbind(DateTime, df)
        select(df, -c(Date, Time))
}

plot1 <- function() {
        #read data, open connection png device, construct plot, close connection
        df <- readData()
        png(filename = "plot1.png", width = 480, height = 480)
        hist(df$Global_active_power, col = "red", main = "Global Active Power", 
             xlab = "Global Active Power (kilowatts)")
        dev.off()
}