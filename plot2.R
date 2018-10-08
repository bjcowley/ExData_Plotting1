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

#set png parameters
png("plot2.png", width = 480, height = 480)

#plot line chart
plot(subDatabyDOW,
     GAPData,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

dev.off()
