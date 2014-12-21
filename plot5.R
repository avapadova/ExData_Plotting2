# Read the data

# This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SRC <- readRDS("Source_Classification_Code.rds")
head(NEI)
str(SRC)

## Plot5.R

## How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
## Maryland (fips == "24510").

#  Select the fields
BaltimoreCity <- subset(NEI, fips == "24510")

VEHICLE <- grep("vehicle",SRC$EI.Sector,value=T,ignore.case=T)

SRC.VEHICLE <- subset(SRC, SRC$EI.Sector %in% VEHICLE, select=SCC)
NEI.VEHICLE <- subset(BaltimoreCity, BaltimoreCity$SCC %in%  SRC.VEHICLE$SCC)

plot5data <- aggregate(NEI.VEHICLE[c("Emissions")], list(year = NEI.VEHICLE$year), sum)



#  Plot 5 implementation
png('plot5.png', width=480, height=480)
plot(plot5data$year, plot5data$Emissions, type = "l", 
     main = "Total Motor Vehicle Emissions in Baltimore City",
     xlab = "Year", ylab = "Emissions")
dev.off()