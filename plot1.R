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

#Plot 1
png(filename = "plot1.png", width = 480, height = 480)
hist(df$Global_active_power, col = "red", xlab = "Global active power(kilowatts)", main = "Global active power")
dev.off()
