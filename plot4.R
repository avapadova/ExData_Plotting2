# Read the data

# This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SRC <- readRDS("Source_Classification_Code.rds")
head(NEI)
str(SRC)

## Plot4.R

## Across the United States, how have emissions from coal combustion-related sources
## changed from 1999-2008?

#  Select the fields
CoalCombustion <- grep("coal",SRC$EI.Sector,value=T,ignore.case=T)
SRC.CoalCombustion <- subset(SRC, SRC$EI.Sector %in% CoalCombustion, select=SCC)
NEI.CoalCombustion <- subset(NEI, NEI$SCC %in%  SRC.CoalCombustion$SCC)
plot4data <- aggregate(NEI.CoalCombustion[c("Emissions")], list(year = NEI.CoalCombustion$year), sum)

#  Plot 4 implementation
library(ggplot2)

q <- qplot(year, Emissions, data=plot4data, geom=c("point", "smooth"))  

png('plot4.png', width=480, height=480)
g <- ggplot(plot4data, aes(x=year, y=Emissions)) +
        geom_point(alpha=.3) +
        geom_smooth(alpha=.2, size=1) +
        ggtitle("Total_PM2.5_Coal_Combustion_Emissions_in_the_US")
print(g)

#summary(g)
#p <- g + geom_point()
#print(p)

dev.off()
