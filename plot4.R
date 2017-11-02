## 1. IMPORTING DATA
## Read whole table
rawdata <- read.table("household_power_consumption.txt",
                      sep=";",
                      header=T)
## Subset relevant data
data_clean <- subset(rawdata,
                     Date=="1/2/2007" | Date=="2/2/2007")
## Remove large table to free up memory
rm(rawdata)
## 2. CLEANING DATA
library(dplyr)
## Merge Date and Time columns into Date
data_clean <- data_clean %>% 
        mutate(Date = paste(Date, Time)) %>% 
        select(-Time)
## Convert Date column to lubridate's period plass
library(lubridate)
data_clean$Date <- dmy_hms(data_clean$Date)
## Convert all columns but Date to numeric class
data_clean[,2:8] <- lapply(data_clean[,2:8],
                           function(x) as.numeric(as.character(x)))
## 3. PLOTTING DATA

## Set layout parameters
par(mfrow=c(2,2),
    mar=c(4,4,1,1),
    oma=c(2,2,1,1),
    cex=0.7)
## Plot 1st graph
with(data_clean, plot(Date, Global_active_power,
                      type="l",
                      xlab="",
                      ylab="Global Active Power"))
## Plot 2nd graph
with(data_clean, plot(Date, Voltage,
                      type="l",
                      xlab="datetime",
                      ylab="Voltage"))
## Plot 3rd graph
with(data_clean, plot(Date, Sub_metering_1,
                      type="l",
                      xlab="",
                      ylab="Energy sub metering"))
with(data_clean, lines(Date, Sub_metering_2, col="red"))
with(data_clean, lines(Date, Sub_metering_3, col="blue"))
legend("topright",
       lty=1, 
       col=c("black", "blue", "red"),
       bty = "n",
       legend=names(data_clean[,6:8]))
## Plot 4th graph
with(data_clean, plot(Date, Global_reactive_power,
                      type="l",
                      xlab="datetime"))
## 4. EXPORTING DATA
dev.copy(png, "plot4.png",
         width=480,
         height=480,
         units="px")
dev.off()