#get data file
EPCDataSet <- "household_power_consumption.txt"
allData <-
  read.table(
    EPCDataSet,
    header = TRUE,
    sep = ";",
    stringsAsFactors = FALSE,
    dec = "."
  )

#subset records to the proper date range
subDatabyDate <-
  allData[allData$Date %in% c("1/2/2007", "2/2/2007"),]

#subset records by day of week
subDatabyDOW <-
  strptime(paste(subDatabyDate$Date, subDatabyDate$Time, sep = " "),
           "%d/%m/%Y %H:%M:%S")

#format global active power as numeric
GAPData <- as.numeric(subDatabyDate$Global_active_power)

#format submeterings as numerics
SM1Data <- as.numeric(subDatabyDate$Sub_metering_1)
SM2Data <- as.numeric(subDatabyDate$Sub_metering_2)
SM3Data <- as.numeric(subDatabyDate$Sub_metering_3)

#set png parameters
png("plot3.png", width = 480, height = 480)

#plot initial line on chart
plot(subDatabyDOW,
     SM1Data,
     type = "l",
     xlab = "",
     ylab = "Energy Sub Metering")

#plot second line on chart
lines(subDatabyDOW, SM2Data, type = "l", col = "red")

#plot third line on chart
lines(subDatabyDOW, SM3Data, type = "l", col = "blue")

#set legend
legend(
  "topright",
  c("Sub Metering 1", "Sub Metering 2", "Sub Metering 3"),
  lty = 1,
  lwd = 2.5,
  col = c("black", "red", "blue")
)

dev.off()
