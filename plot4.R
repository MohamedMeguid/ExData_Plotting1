# Read Data
data <- read.csv(file = "household_power_consumption.txt",
                 header = TRUE, 
                 sep = ";",
                 na.strings = c("NA", "?"),
                 stringsAsFactors = FALSE)

head(data)
str(data)

#Filter Data With Dates
data <- data[data$Date %in% c("1/2/2007", "2/2/2007"), ]

#Combine Date and Time columns into one column
data$DateTime <- paste(data$Date, data$Time)

# Cast the new DateTime column as POSIXlt  
data$DateTime <- strptime(data$DateTime, format = "%d/%m/%Y %H:%M:%S")

# Plot 4 Construction

png(filename = "plot4.png", height = 480, width = 480, units = "px")

par(mfrow = c(2, 2))

# Top Left Plot
with(data, 
     plot(x = DateTime, y = Global_active_power, 
          type = "l",
          ylab = "Global Active Power",
          xlab = "")
)

# Top Right Plot
with(data, 
     plot(x = DateTime, y = Voltage, 
          type = "l",
          ylab = "Voltage",
          xlab = "datetime")
)

# Bottom Left Plot
with(data, plot(x = DateTime, y = Sub_metering_1, 
                type = "l",
                col = "black",
                xlab = "",
                ylab = "Energy sub metering")
)

with(data, lines(x = DateTime, y = Sub_metering_2, col = "red"))

with(data, lines(x = DateTime, y = Sub_metering_3, col = "blue"))

legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = 1, lwd = 2, bty = "n")

# Bottom Right Plot
with(data, 
     plot(x = DateTime, y = Global_reactive_power, 
          type = "l",
          ylab = "Global_reactive_power",
          xlab = "datetime")
)

# Close File
dev.off()
