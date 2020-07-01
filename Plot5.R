if(!file.exists("summarySCC_PM25.rds")){download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destifile <- "data.zip", method = "curl")}
unzip("data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
if(!file.exists("summarySCC_PM25.rds")){download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destifile <- "data.zip", method = "curl")}
unzip("data.zip")
NEI$fips <- as.factor(NEI$fips)
NEI$SCC <- as.factor(NEI$SCC)
NEI$Pollutant <- as.factor(NEI$Pollutant)
NEI$type <- as.factor(NEI$type)
NEI$year <- as.factor(NEI$year)

## Question 5: How have emissions from motor vehicle 
## sources changed from 1999–2008 in Baltimore City?
SCC.mobile <- filter(SCC, grepl('Mobile', EI.Sector))
NEI.bc.mobile <- NEI.bc[NEI.bc$SCC %in% SCC.mobile$SCC,]
plot5.1 <- ggplot(NEI.bc.mobile, aes(x = year, y = log10(Emissions))) +
        geom_boxplot() +
        theme_bw() +
        labs(y = "lg(PM2.5 Emission)",
             title = "Change of PM2.5 Emission From Motor Vehicle Sources in Baltimore City")
mobile.emission <- aggregate(NEI.bc$Emissions, by=list(year=NEI.bc$year), FUN=sum)
names(mobile.emission) <- c("year", "emission")
plot5.2 <- ggplot(mobile.emission, aes(x = year, y = emission)) +
        geom_bar(stat='identity') +
        theme_bw() +
        labs(y = "Total PM2.5 Emission (tons)",
             title = "Total emission of PM2.5 From Motor Vehicle Sources in Baltimore City")
png("plot5.png", width = 1000, height = 480)
grid.arrange(plot5.1, plot5.2, ncol=2)
dev.off()
