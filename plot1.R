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

#format global active power as number
GAPData <- as.numeric(subDatabyDate$Global_active_power)

#set png parameters
png("plot1.png", width = 480, height = 480)

#plot histogram
hist(GAPData,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

dev.off()
