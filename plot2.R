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


# Plot 2 Construction

png(filename = "figure/plot2.png", height = 480, width = 480, units = "px")

with(data,
     plot(x = DateTime, y = Global_active_power,
          type = "l",
          xlab = "",
          ylab = "Global Active Power (kilowatts)")
     )

dev.off()
