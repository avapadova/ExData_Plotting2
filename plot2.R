# Read the data

# This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
head(NEI)
str(SCC)

## Plot2.R

## Have total emissions from PM2.5 decreased in the Baltimore City,
## Maryland (fips == "24510") from 1999 to 2008?
## Use the baseplotting system to make a plot answering this question.

#  Select the fields
BaltimoreCity <- subset(NEI, fips == "24510")
plot2data <- aggregate(BaltimoreCity[c("Emissions")], list(year = BaltimoreCity$year), sum)

#  Plot 2 implementation
png('plot2.png', width=480, height=480)
plot(plot2data$year, plot2data$Emissions, type = "l", 
     main = "Total Emissions of PM2.5 in Baltimore City",
     xlab = "Year", ylab = "Emissions")
dev.off()