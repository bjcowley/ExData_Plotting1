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
  allData[allData$Date %in% c("1/2/2007", "2/2/2007"), ]

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

#format voltage as numeric
VData <- as.numeric(subDatabyDate$Voltage)

#format global reactive power as numeric
GRPData <- as.numeric(subDatabyDate$Global_reactive_power)

#set png parameters
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))

#plot global active power chart
plot(
  subDatabyDOW,
  GAPData,
  type = "l",
  xlab = "",
  ylab = "Global Active Power",
  cex = 0.2
)

#plot voltage chart
plot(subDatabyDOW,
     VData,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")

#plot sub metering chart. Initial line.
plot(subDatabyDOW,
     SM1Data,
     type = "l",
     xlab = "",
     ylab = "Energy Sub Metering")

#plot sub metering second line on chart
lines(subDatabyDOW, SM2Data, type = "l", col = "red")

#plot sub metering third line on chart
lines(subDatabyDOW, SM3Data, type = "l", col = "blue")

#set sub metering legend
legend(
  "topright",
  c("Sub Metering 1", "Sub Metering 2", "Sub Metering 3"),
  lty = 1,
  lwd = 2.5,
  col = c("black", "red", "blue")
)

#plot global reative power chart
plot(subDatabyDOW,
     GRPData,
     type = "l",
     xlab = "datetime",
     ylab = "Global Reactive Power")

dev.off()
