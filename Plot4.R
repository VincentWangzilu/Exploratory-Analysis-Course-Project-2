NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEI$fips <- as.factor(NEI$fips)
NEI$SCC <- as.factor(NEI$SCC)
if(!file.exists("summarySCC_PM25.rds")){download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destifile <- "data.zip", method = "curl")}
unzip("data.zip")
NEI$Pollutant <- as.factor(NEI$Pollutant)
NEI$type <- as.factor(NEI$type)
NEI$year <- as.factor(NEI$year)

## Question 4: Across the United States, how have emissions  
## from coal combustion-related sources changed from 1999–2008?
coal <- filter(SCC, EI.Sector  == "Fuel Comb - Comm/Institutional - Coal" | EI.Sector  == "Fuel Comb - Electric Generation - Coal")
NEI.coal <- NEI[NEI$SCC %in% coal$SCC,]

plot4.1 <- ggplot(NEI.coal, aes(x = year, y = log10(Emissions))) +
        geom_boxplot() +
        theme_bw() +
        labs(y = "lg(PM2.5 Emission)",
             title = "Change of PM2.5 Emission From Coal Combustion")

coal.emission <- aggregate(NEI.coal$Emissions, by=list(year=NEI.coal$year), FUN=sum)
names(coal.emission) <- c("year", "emission")
plot4.2 <- ggplot(coal.emission, aes(x = year, y = emission)) +
        geom_bar(stat='identity') +
        theme_bw() +
        labs(y = "Total PM2.5 Emission (tons)",
             title = "Total emission of PM2.5 From Coal Combustion")
png("plot4.png", width = 800, height = 480)
grid.arrange(plot4.1, plot4.2, ncol=2)
dev.off()