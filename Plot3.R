if(!file.exists("summarySCC_PM25.rds")){download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destifile <- "data.zip", method = "curl")}
unzip("data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEI$fips <- as.factor(NEI$fips)
NEI$SCC <- as.factor(NEI$SCC)
if(!file.exists("summarySCC_PM25.rds")){download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destifile <- "data.zip", method = "curl")}
unzip("data.zip")
NEI$Pollutant <- as.factor(NEI$Pollutant)
NEI$type <- as.factor(NEI$type)
NEI$year <- as.factor(NEI$year)

## Question 3: The change of emission of 4 types in Baltimore City
type.bc <- aggregate(NEI.bc$Emissions, by=list(year=NEI.bc$year, type = NEI.bc$type), FUN=sum)
names(type.bc) <- c("year", "type", "emission") 

plot3.1 <- ggplot(type.bc, aes(x = year, y = emission)) +
        geom_bar(stat='identity') +
        facet_grid(.~ type) +
        theme_bw() +
        labs(y = "Total PM2.5 Emission (tons)",
             title = "Total Emission of PM2.5 From 4 Types in Baltimore City (1999-2008)")


plot3.2 <- ggplot(NEI.bc, aes(x = year, y = log10(Emissions))) +
        geom_boxplot() +
        facet_grid(.~ type)+
        theme_bw() +
        labs(y = "lg(PM2.5 Emission)",
             title = "Change of PM2.5 Emission From 4 Types in Baltimore City (1999-2008)")
png("plot3.png")
grid.arrange(plot3.1, plot3.2, nrow=2)
dev.off()
