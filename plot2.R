

setwd("C:/Users/odlia/Desktop")

#changes the options so that the plot won't be in e+06 format
options(scipen = 999)

#Reads the data file using readRDS
sumSCC <- readRDS(file = "summarySCC_PM25.rds")
#they are numeric values so we can work with them

#Creates a data frame as a subset of the original one but it's only for baltimore
SCC_Baltimore <- sumSCC[sumSCC$fips == '24510', ]

#Aggregate emissions sum by year for fips 24510 ==> Baltimore City
EbYBC <- aggregate(Emissions ~ year, data = SCC_Baltimore, sum, na.rm = TRUE)

#opens the png object
png(filename='plot2.png')

# Create a bar plot
barplot(EbYBC$Emissions,
        names.arg = EbYBC$year,
        xlab = "Year", ylab = "Total PM2.5 Emissions",
        main = "Total Emissions of PM2.5 in Baltimore from 1999 to 2008",
        col = "darkgreen")

#closes the png connection
dev.off()
