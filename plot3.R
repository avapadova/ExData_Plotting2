# Read the data

# This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
head(NEI)
str(SCC)

## Plot3.R

## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable,
## which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City?
## Which have seen increases in emissions from 1999-2008?

#  Select the fields
BaltimoreCity <- subset(NEI, fips == "24510")
plot3data <- aggregate(BaltimoreCity[c("Emissions")], list(type = BaltimoreCity$type, year = BaltimoreCity$year), sum)

#  Plot 3 implementation
library(ggplot2)

q <- qplot(year, Emissions, data=plot3data, geom=c("point", "smooth"), colour=type)  

png('plot3.png', width=480, height=480)

g <- ggplot(plot3data, aes(x=year, y=Emissions, colour=type)) +
        geom_point(alpha=.3) +
        geom_smooth(alpha=.2, size=1, method="loess") +
        ggtitle("Total Emissions in Baltimore City by Type")

print(g)

#summary(g)
#p <- g + geom_point()
#print(p)


dev.off()