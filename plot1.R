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
hist(data_clean$Global_active_power,
     col="red",
     main="Global Active Power",
     xlab= "Global Active Power (kilowatts)")
## 4. EXPORTING DATA
dev.copy(png, "plot1.png",
         width=480,
         height=480,
         units="px")
dev.off()