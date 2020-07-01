if(!file.exists("summarySCC_PM25.rds")){download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destifile <- "data.zip", method = "curl")}
unzip("data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEI$fips <- as.factor(NEI$fips)
NEI$SCC <- as.factor(NEI$SCC)
NEI$Pollutant <- as.factor(NEI$Pollutant)
NEI$type <- as.factor(NEI$type)
NEI$year <- as.factor(NEI$year)

## Question 1: Have total emissions from PM2.5 
## decreased in the United States from 1999 to 2008? 
total.emission <- aggregate(NEI$Emissions, by=list(year=NEI$year), FUN=sum)
names(total.emission) <- c("year", "emission")
png("plot1.png")
barplot(emission ~ year, data = total.emission, ylab = "Total emission of PM2.5 (tons)", main = "Total Emission of PM2.5 in United States (1999-2008)")
dev.off()