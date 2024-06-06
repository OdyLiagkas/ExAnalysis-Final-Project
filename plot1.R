

setwd("C:/Users/odlia/Desktop")

#changes the options so that the plot won't be in e+06 format
options(scipen = 999)

#Reads the data file using readRDS
sumSCC <- readRDS(file = "summarySCC_PM25.rds")
#they are numeric values so we can work with them


#Aggregate emissions sum by year
EbY <- aggregate(Emissions ~ year, data = sumSCC, sum, na.rm = TRUE)

#opens the png object
png(filename='plot1.png')

#Creates a bar plot
barplot(EbY$Emissions,
        names.arg = EbY$year,
        xlab = "Year", ylab = "Total PM2.5 Emissions",
        main = "Total Emissions of PM2.5 in the U.S. from 1999 to 2008",
		col = 'darkgreen')



#closes the png connection
dev.off()