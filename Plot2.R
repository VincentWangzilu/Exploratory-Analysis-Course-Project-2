if(!file.exists("summarySCC_PM25.rds")){download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destifile <- "data.zip", method = "curl")}
unzip("data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEI$fips <- as.factor(NEI$fips)
NEI$SCC <- as.factor(NEI$SCC)
NEI$Pollutant <- as.factor(NEI$Pollutant)
NEI$type <- as.factor(NEI$type)
NEI$year <- as.factor(NEI$year)

## Question 2: Have total emissions from PM2.5 decreased 
## in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?
NEI.bc <- filter(NEI, fips == "24510")
emission.bc <- aggregate(NEI.bc$Emissions, by=list(year=NEI.bc$year), FUN=sum)
names(emission.bc) <- c("year", "emission")
png("plot2.png")
barplot(emission ~ year, data = emission.bc, ylab = "Total emission of PM2.5 (tons)", main = "Total Emission of PM2.5 in Baltimore City (1999-2008)")
dev.off()