library("ggplot2")

setwd("C:/Users/odlia/Desktop")

#changes the options so that the plot won't be in e+06 format
options(scipen = 999)

#Reads the data file using readRDS
sumSCC <- readRDS(file = "summarySCC_PM25.rds")
#they are numeric values so we can work with them
SCC <- readRDS(file = "Source_Classification_Code.rds")

#Create the subset of the data frame for the vehicles
condition <- grepl("vehicle", SCC[, "SCC.Level.Two"], ignore.case=TRUE)
vehiclesSCC <- SCC[condition, "SCC"]
vehiclesSumSCC <- sumSCC[sumSCC[, "SCC"] %in% vehiclesSCC,]

#Creates a data frame as a subset of the one for the vehicles but it's only for baltimore
baltimoreVehiclesSumSCC <- vehiclesSumSCC[vehiclesSumSCC$fips=="24510",]

#opens the png object
png("plot5.png")

#Creates the ggplot barplot
ggplot(baltimoreVehiclesSumSCC,aes(factor(year),Emissions)) +
  geom_bar(stat="identity", fill ="#004000" ,width=0.8) +
  labs(x="Year", y="Total PM2.5 Emissions") + 
  labs(title="Total Vehicle Emissions of PM2.5 in the U.S. from 1999 to 2008")

#closes the png connection
dev.off()

#using aggregate to sum everything in order to do a barplot with base R
EbY <- aggregate(Emissions ~ year, data = baltimoreVehiclesSumSCC, sum)

#opens another png object for the second version of the PNG file
png(filename='plot5-2.png')

#Creates the second version of the barplot using BASE R
barplot(EbY$Emissions, 
        names.arg = EbY$year,
        col = "#004000",
        main = "Total Vehicle Emissions of PM2.5 in the U.S. by Year",
        xlab = "Year", ylab = "Total PM2.5 Emissions"
)

#closes the png connection
dev.off()
