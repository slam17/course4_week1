#download file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "dataset.zip", method = "curl")
unzip("dataset.zip")

#load data
data <- read.table("household_power_consumption.txt",header=TRUE, sep = ";")

#convert date and time
data$Date <- strptime(as.character(data$Date), format = "%d/%m/%Y") 
data$Date <- format(as.Date(data$Date), "%Y-%m-%d")
data$Time <- strptime(as.character(data$Time), format = "%H:%M:%S") 
data$Time <- format(data$Time,  "%I:%M:%S %p")

#subset the data
data_subset <- subset(data, as.Date(data$Date) == "2007-02-01" | as.Date(data$Date) == "2007-02-02")
rows <- row.names(data_subset)

data_subset$Sub_metering_1 <- as.numeric(levels(data_subset$Sub_metering_1))[data_subset$Sub_metering_1]
data_subset$Sub_metering_2 <- as.numeric(levels(data_subset$Sub_metering_2))[data_subset$Sub_metering_2]
data_subset$Voltage <- as.numeric(levels(data_subset$Voltage))[data_subset$Voltage]
data_subset$Global_reactive_power <- as.numeric(levels(data_subset$Global_reactive_power))[data_subset$Global_reactive_power]

#plot graph
png("plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))

#upper left
plot(rows, data_subset$Global_active_power, 
     type = "l", ylab = "Global Active Power"
     ,xaxt = 'n', yaxt = 'n', xlab = '')
axis(1, at = c(rows[1], rows[length(rows) / 2], 
               rows[length(rows)]),labels = c("Thu", "Fri", "Sat"))
axis(2, at = seq(0, 3000, 1000), labels = seq(0, 6, 2))

#upper right
plot(rows, data_subset$Voltage, 
     type = "l", ylab = "Voltage",  xaxt = 'n', yaxt = 'n', xlab = "datetime")
axis(1, at = c(rows[1], rows[length(rows) / 2], 
               rows[length(rows)]),labels = c("Thu", "Fri", "Sat"))
axis(2, at = seq(234, 246, 4), labels = seq(234, 246, 4))

#bottom left
plot(rows, data_subset$Sub_metering_1, type = "l",  ylab = "Energy sub metering",
     xaxt = 'n', yaxt = 'n', xlab = '')
with(data_subset, lines(rows, Sub_metering_2, col = "red"))
with(data_subset, lines(rows, Sub_metering_3, col = "blue"))
axis(1, at = c(rows[1], rows[length(rows) / 2], 
               rows[length(rows)]),labels = c("Thu", "Fri", "Sat"))
axis(2, at = seq(0, 30, 10), labels = seq(0, 30, 10))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2",
                              "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1,
       xjust = 1, box.lty = 0)

#bottom right
plot(rows, data_subset$Global_reactive_power, 
     type = "l", ylab = "Global_reactive_power"
     ,xaxt = 'n', yaxt = 'n', xlab = "datetime")
axis(1, at = c(rows[1], rows[length(rows) / 2], 
               rows[length(rows)]),labels = c("Thu", "Fri", "Sat"))
axis(2, at = seq(0.0, 0.5, 0.1), labels = seq(0.0, 0.5, 0.1))
dev.off()

