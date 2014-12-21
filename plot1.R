# Read the data

# This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
head(NEI)
str(SCC)

## Plot1.R

## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Using the base plotting system, make a plot showing the total PM2.5 emission 
## from all sources for each of the years 1999, 2002, 2005, and 2008.

#  Select the fields
plot1data <- aggregate(NEI[c("Emissions")], list(year = NEI$year), sum)

#  Plot 1 implementation
png('plot1.png', width=480, height=480)
plot(plot1data$year, plot1data$Emissions, type = "l", 
     main = "Total Emissions of PM2.5 in the US",
     xlab = "Year", ylab = "Emissions")
dev.off()