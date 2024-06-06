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
#creates a new column in this data frame for the city
baltimoreVehiclesSumSCC$city <- "Baltimore"


#creates a data frame as a subset of the one for the vehicles but it's only for LA
LAVehiclesSumSCC <- vehiclesSumSCC[vehiclesSumSCC$fips=="06037",]
#creates a new columns again for the city
LAVehiclesSumSCC$city <- "L.A."

#combines both data frames
ALLVehiclesSumSCC <- rbind(baltimoreVehiclesSumSCC, LAVehiclesSumSCC)

#opens the png object
png("plot6.png")

#Creates the ggplot barplot
ggplot(ALLVehiclesSumSCC, aes(x=factor(year), y=Emissions, fill=city)) +
  geom_bar(aes(fill=year),stat="identity") +
  facet_grid(scales="free", space="free", .~city) +
  labs(x="Year", y="Total PM2.5 Emissions") + 
  labs(title="Total Vehicle Emissions of PM2.5 in Baltimore and LA from 1999 to 2008")


#closes the png connection
dev.off()

#using aggregate to sum everything in order to do a barplot with base R
EbY <- aggregate(Emissions ~ year + city, data = ALLVehiclesSumSCC, sum)

#opens another png object for the second version of the PNG file
png(filename='plot6-2.png')

col_palette <- ifelse(EbY$city == "Baltimore", "#004000", "#400000")

#Creates the second version of the barplot using BASE R
barplot(EbY$Emissions, 
        names.arg = EbY$year,
        col = col_palette,
        main = "Total Vehicle Emissions of PM2.5 in Baltimore and LA by Year",
        xlab = "Year", ylab = "Total PM2.5 Emissions"
)

#colour palette for legend
col_palette2 <- c("#004000", "#400000")

#adds a legend
legend("topleft", 
       legend = c("Baltimore", "LA"),  
       fill = col_palette2,  
       title = "City") 

#closes the png connection
dev.off()
