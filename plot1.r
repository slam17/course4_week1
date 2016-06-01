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
data$Time <- format(data$Time,"%I:%M:%S %p")

#subset the data
data_subset <- subset(data, as.Date(data$Date) == "2007-02-01" | as.Date(data$Date) == "2007-02-02")

#plot graph
png("plot1.png", width = 480, height = 480)
hist(as.numeric(data_subset$Global_active_power)/500,  main = paste("Global Active Power"), 
              xlab = "Global Active Power (kilowatts)", col = "red", ylim = c(0, 1200))
dev.off()