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

#plot graph
png("plot2.png", width = 480, height = 480)
rows <- row.names(data_subset)
plot(rows, data_subset$Global_active_power, 
     type = "l", ylab = "Global Active Power (kilowatts)"
     ,xaxt = 'n', yaxt = 'n', xlab = '')
axis(1, at = c(rows[1], rows[length(rows) / 2], 
               rows[length(rows)]),labels = c("Thu", "Fri", "Sat"))
axis(2, at = seq(0, 3000, 1000), labels = seq(0, 6, 2))
dev.off()