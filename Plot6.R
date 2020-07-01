if(!file.exists("summarySCC_PM25.rds")){download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destifile <- "data.zip", method = "curl")}
unzip("data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEI$fips <- as.factor(NEI$fips)
NEI$SCC <- as.factor(NEI$SCC)
NEI$Pollutant <- as.factor(NEI$Pollutant)
NEI$type <- as.factor(NEI$type)
NEI$year <- as.factor(NEI$year)

## Question 6: Which city has seen greater changes over 
## time in motor vehicle emissions?
NEI.bcla <- filter(NEI, fips == "06037" | fips == "24510")
NEI.bcla.mobile <- NEI.bcla[NEI.bcla$SCC %in% SCC.mobile$SCC,]
NEI.bcla.mobile$fips <- sub("24510", "Baltimore City", NEI.bcla.mobile$fips)
NEI.bcla.mobile$fips <- sub("06037", "Los Angeles", NEI.bcla.mobile$fips)
plot6.1 <- ggplot(NEI.bcla.mobile, aes(x = year, y = log10(Emissions))) +
        geom_boxplot() +
        facet_grid(.~ fips)+
        theme_bw() +
        labs(y = "lg(PM2.5 Emission)",
             title = "Change of PM2.5 Emission From Motor Vehicle Sources in Baltimore City vs LA (1999-2008)")
emission.bcla <- aggregate(NEI.bcla$Emissions, by=list(year=NEI.bcla$year, fips = NEI.bcla$fips), FUN=sum)
names(emission.bcla) <- c("year", "fips", "emission")
emission.bcla$fips <- sub("24510", "Baltimore City", emission.bcla$fips)
emission.bcla$fips <- sub("06037", "Los Angeles", emission.bcla$fips)
plot6.2 <- ggplot(emission.bcla, aes(x = year, y = emission)) +
        geom_bar(stat='identity') +
        theme_bw() +
        facet_grid(.~ fips)+
        labs(y = "Total PM2.5 Emission (tons)",
             title = "Total emission of PM2.5 From Motor Vehicle Sources in Baltimore City vs LA (1999-2008)")
png("plot6.png", width = 800, height = 480)
grid.arrange(plot6.1, plot6.2, nrow=2)
dev.off()







