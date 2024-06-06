library(ggplot2)

setwd("C:/Users/odlia/Desktop")

#changes the options so that the plot won't be in e+06 format
options(scipen = 999)

#Reads the data file using readRDS
sumSCC <- readRDS(file = "summarySCC_PM25.rds")
#they are numeric values so we can work with them
SCC <- readRDS(file = "Source_Classification_Code.rds")

#Create the subset of the data frame for the coal combustion emissions
Combustion <- grepl("comb", SCC[, "SCC.Level.One"], ignore.case = TRUE)
Coal <- grepl("coal", SCC[, "SCC.Level.Four"], ignore.case = TRUE) 
combustionSCC <- SCC[Combustion & Coal, ]
combustionSumSCC <- sumSCC[sumSCC[, "SCC"] %in% combustionSCC$SCC, ]


#opens the png object
png(filename='plot4.png')

#Creates the ggplot barplot
ggplot(combustionSumSCC,aes(x = factor(year),y = Emissions)) +
  geom_bar(stat="identity", fill ="#004000", width=0.8) +
  labs(x="Year", y="Total PM2.5 Emissions") + 
  labs(title="Total Coal Combustion Emissions of PM2.5 in the U.S. from 1999 to 2008")

#closes the png connection
dev.off()

#using aggregate to sum everything in order to do a barplot with base R
EbY <- aggregate(Emissions ~ year, data = combustionSumSCC, sum)

#opens another png object for the second version of the PNG file
png(filename='plot4-2.png')

#Creates the second version of the barplot using BASE R

barplot(EbY$Emissions, 
        names.arg = EbY$year,
        col = "#004000",
        main = "Total Coal Combustion Emissions of PM2.5 in the U.S. by Year",
        xlab = "Year", ylab = "Total PM2.5 Emissions",
)


#closes the png connection
dev.off()