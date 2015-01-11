
if (!file.exists("./data/household_power_consumption.txt")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "./data/power_data.zip", method = "auto")
  unzip("./data/power_data.zip", overwrite = T, exdir = "./data")
}

data_file <- "./data/household_power_consumption.txt"

file_data <- read.table(data_file,
                        header = TRUE,
                        sep = ";",
                        colClasses = c("character", "character", rep("numeric",7)),
                        na = "?")
dim(file_data)
attach(file_data)
##get data for the 2 days specified

subset <- Date == "1/2/2007" | Date == "2/2/2007"

newData <- file_data[subset,]

attach(newData)

x <- paste(Date, Time)
newData$DateTime <- strptime(x, "%d/%m/%Y %H:%M:%S")
rownames(newData) <- 1:nrow(newData)
dim(newData) 
attach(newData)

png(filename = "plot1.png",
    width = 480, height = 480,
    units = "px", bg = "transparent")
hist(Global_active_power,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     breaks = 12, ylim = c(0, 1200))
dev.off()