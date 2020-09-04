# Loading data set
df <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";")

# Change Columns type
# 3rd:9th Columns change to numeric class
for(i in 3:9) df[,i] <- as.numeric(df[,i])

# Change 1st column to date class and creat "all.date" column with POSXIlt class
df$all.date <- paste(df$Date, df$Time)
df$all.date <- strptime(df$all.date, format = "%d/%m/%Y %H:%M:%S")
df$Date <- as.Date(df$all.date)

#subset with 2007-02-01~02-02
library(dplyr)
df <- filter(df, Date >= "2007-02-01" & Date < "2007-02-03")

#Plot 4=================================================================
png(filename = "plot4.png", width = 480, height = 480) 
par(mfrow = c(2,2))
#Top-left
plot(df$all.date, df$Global_active_power, type = "l", 
     xlab = "", ylab = "Global active power") 
#Top-right
plot(df$all.date, df$Voltage, type = "l", 
     xlab = "datetime", ylab = "Voltage") 
#Low-left
plot(df$all.date, df$Sub_metering_1, xlab = "", 
     ylab = "Energy sub metering", type = "l")
points(df$all.date, df$Sub_metering_2, col = "red", type = "l")
points(df$all.date, df$Sub_metering_3, col = "blue", type = "l")
legend("topright",lty = c(1, 1, 1), col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#Low-right
plot(df$all.date, df$Global_reactive_power, type = "l", 
     xlab = "datetime", ylab = "Global_reactive_power") 
dev.off()
