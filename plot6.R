# Read the data

# This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SRC <- readRDS("Source_Classification_Code.rds")
head(NEI)
str(SRC)

## Plot6.R
## Compare emissions from motor vehicle sources in Baltimore City, Maryland (fips == "24510")
## with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037").
## Which city has seen greater changes over time in motor vehicle emissions?

#  Select the fields
BCLA <- subset(NEI, fips == "24510"|fips == "06037")

VEHICLE <- grep("vehicle",SRC$EI.Sector,value=T,ignore.case=T)
SRC.VEHICLE <- subset(SRC, SRC$EI.Sector %in% VEHICLE, select=SCC)

NEI.VEHICLE <- subset(BCLA, BCLA$SCC %in%  SRC.VEHICLE$SCC)

plot6data <- aggregate(NEI.VEHICLE[c("Emissions")], list(fips = NEI.VEHICLE$fips, year = NEI.VEHICLE$year), sum)
plot6data$city <- rep(NA, nrow(plot6data))

plot6data[plot6data$fips == "24510", ][, "city"] <- "Baltimore City"
plot6data[plot6data$fips == "06037", ][, "city"] <- "Los Angles County"


#  Plot 6 implementation
library(ggplot2)

png('plot6.png', width=480, height=480)

p <- ggplot(plot6data, aes(x=year, y=Emissions, colour=city)) +
        geom_point(alpha=.3) +
        geom_smooth(alpha=.2, size=1, method="loess") +
        ggtitle("Total Vehicle Emissions in Baltimore City & LA County")

print(p)

dev.off()