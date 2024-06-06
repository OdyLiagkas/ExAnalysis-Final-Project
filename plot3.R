library(ggplot2)

setwd("C:/Users/odlia/Desktop")

#changes the options so that the plot won't be in e+06 format
options(scipen = 999)

#Reads the data file using readRDS
sumSCC <- readRDS(file = "summarySCC_PM25.rds")
#they are numeric values so we can work with them

#Creates a data frame as a subset of the original one but it's only for baltimore
SCC_Baltimore <- sumSCC[sumSCC$fips == '24510', ]


#opens the png object
png(filename='plot3.png')

#Creates the different bar plots
ggplot(SCC_Baltimore, aes(factor(year), Emissions, fill=type)) +
  geom_bar(stat = "identity") +
  facet_wrap(~ type, scales = "free", ncol = 1) + 
  labs(x = "Year", y = "Total PM2.5 Emissions") + 
  labs(title = "Total Emissions of PM2.5 in Baltimore from 1999 to 2008 Separated by Type")

#closes the png connection
dev.off()
