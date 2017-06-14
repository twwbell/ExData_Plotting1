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

plot3 <- function() {
        #read data, open connection png device, construct plot, close connection
        df <- readData()
        png(filename = "plot3.png", width = 480, height = 480)
        with(df, plot(DateTime, Sub_metering_1, type = "l", 
                      ylab = "Energy sub metering", xlab = ""))
        with(df, lines(DateTime, Sub_metering_2, col = "red"))
        with(df, lines(DateTime, Sub_metering_3, col = "blue"))
        legend_labels <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
        legend("topright", legend = legend_labels, col = legend_colors, lty = 1)
        dev.off()
}