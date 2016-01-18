library(ggplot2)
library(grid)
library(gridExtra)


LoadData <- function() {
  
  NEI <<- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
  SCC <<- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")
  
  NEI$Pollutant <<- as.factor(NEI$Pollutant)
  NEI$type <<- as.factor(NEI$type)
  NEI$fips <<- as.factor(NEI$fips)
  NEI$SCC <<- as.factor(NEI$SCC)
  NEI$year <<- as.factor(NEI$year)
  
}



Question1Plot <- function() {
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  NEI$Pollutant <- as.factor(NEI$Pollutant)
  NEI$type <- as.factor(NEI$type)
  NEI$fips <- as.factor(NEI$fips)
  NEI$SCC <- as.factor(NEI$SCC)
  NEI$year <- as.factor(NEI$year)
  
  png(file="plot1.png",width=600,height=800,res=45)
  
  sumData <- tapply(NEI$Emissions, NEI$year, FUN=sum, simplify = TRUE)
  sumDataDataFrame <- data.frame(year =c("1999", "2002","2005", "2008"), PM2.5 = sumData)
  # plot the graph using the x axis as a factor representation of the data. 
  # This leads to the fat lines, but makes it easer to see the years that have measuments
  # Plot coult have also been plotted using numerics for the dates i.e.   
  # plot(c(1999, 2002,2005, 2008), sumDataDataFrame$PM2.5, xlab = "Year", ylab = "PM2.5 emitted (tons)", main = "Total PM2.5 emitted per year")
  plot(sumDataDataFrame$year, sumDataDataFrame$PM2.5, xlab = "Year", ylab = "PM2.5 emitted (tons)", main = "Total PM2.5 emitted per year")
  dev.off()
}


Question2Plot <- function() {
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  NEI$Pollutant <- as.factor(NEI$Pollutant)
  NEI$type <- as.factor(NEI$type)
  NEI$fips <- as.factor(NEI$fips)
  NEI$SCC <- as.factor(NEI$SCC)
  NEI$year <- as.factor(NEI$year)
  png(file="plot2.png",width=600,height=800,res=45)
  
  baltimoreData <- NEI[NEI$fips == "24510",]
  sumData <- tapply(baltimoreData$Emissions, baltimoreData$year, FUN=sum, simplify = TRUE)
  sumDataDataFrame <- data.frame(year =c("1999", "2002","2005", "2008"), PM2.5 = sumData)
  # plot the graph using the x axis as a factor representation of the data. 
  # This leads to the fat lines, but makes it easer to see the years that have measuments
  # Plot coult have also been plotted using numerics for the dates i.e.   
  # plot(c(1999, 2002,2005, 2008), sumDataDataFrame$PM2.5, xlab = "Year", ylab = "PM2.5 emitted (tons)", main = "Total PM2.5 emitted per year in Baltimore City")
  plot(sumDataDataFrame$year, sumDataDataFrame$PM2.5, xlab = "Year", ylab = "PM2.5 emitted (tons)", main = "Total PM2.5 emitted per year in Baltimore City") 
  dev.off()
}


Question3Plot <- function() {
  library(ggplot2)
  library(grid)
  library(gridExtra)
  
  png(file="plot3.png",width=600,height=800,res=45)
  
  baltimoreData <- NEI[NEI$fips == "24510",]
 
  sumData <- tapply(baltimoreData$Emissions, list(baltimoreData$year,  baltimoreData$type), FUN=sum, simplify = TRUE)
  sumDataDataFrame <- data.frame(year =c("1999", "2002","2005", "2008"),  sumData)
  
 
         
  ## Setup ggplot with data frame
  p1 <- ggplot(sumDataDataFrame, aes( year, ON.ROAD))
  p1 <- p1   + geom_point() +   ylab("Total PM2.5 emitted per year") + ggtitle("On-Road")
  
  p2 <- ggplot(sumDataDataFrame, aes( year, NON.ROAD))
  p2 <- p2 + geom_point() +   ylab("Total PM2.5 emitted per year") + ggtitle("Non-Road")
  
  p3 <- ggplot(sumDataDataFrame, aes( year, POINT))
  p3 <- p3 + geom_point() +   ylab("Total PM2.5 emitted per year") + ggtitle("Point")
  
  p4 <- ggplot(sumDataDataFrame, aes( year, NONPOINT))
  p4 <- p4 + geom_point() +   ylab("Total PM2.5 emitted per year") + ggtitle("Non-Point")
  
  grid.arrange(p1,p2,p3,p4,ncol = 2, top = "Total PM2.5 emitted per year in Baltimore City by Type")
  
  dev.off()
}





Question4Plot <- function() {
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  NEI$Pollutant <- as.factor(NEI$Pollutant)
  NEI$type <- as.factor(NEI$type)
  NEI$fips <- as.factor(NEI$fips)
  NEI$SCC <- as.factor(NEI$SCC)
  NEI$year <- as.factor(NEI$year)
  
  png(file="plot4.png",width=600,height=800,res=45)
  
  # using boxplots as number of sources is changing each year
  coalSCC <- subset(SCC, grepl("(?i)coal", Short.Name))
  mergedTables <- merge(NEI,coalSCC,by="SCC")
  
  boxplot(mergedTables$Emissions ~ mergedTables$year, outline=FALSE,  xlab = "Year", ylab="PM2.5 (tons)", main = "PM2.5 recorded by Coal related sources in the USA")
  dev.off()
}

Question5Plot <- function() {
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  NEI$Pollutant <- as.factor(NEI$Pollutant)
  NEI$type <- as.factor(NEI$type)
  NEI$fips <- as.factor(NEI$fips)
  NEI$SCC <- as.factor(NEI$SCC)
  NEI$year <- as.factor(NEI$year)
  png(file="plot5.png",width=600,height=800,res=45)
  
  # using boxplots as number of sources is changing each year
  baltimoreData <- NEI[NEI$fips == "24510",]
  carSCC <- subset(SCC, grepl("(?i)vehicle", Short.Name))
  par(mfrow = c(1, 1))
  baltimoreMergedTables <- merge(baltimoreData,carSCC,by="SCC")
  boxplot(baltimoreMergedTables$Emissions ~ baltimoreMergedTables$year, outline=FALSE, xlab = "Year", ylab="PM2.5 (tons)", main = "PM2.5 recorded by Vehicle related sources in Baltimore City" )
  dev.off()
}



Question6Plot <- function() {
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  NEI$Pollutant <- as.factor(NEI$Pollutant)
  NEI$type <- as.factor(NEI$type)
  NEI$fips <- as.factor(NEI$fips)
  NEI$SCC <- as.factor(NEI$SCC)
  NEI$year <- as.factor(NEI$year)
  png(file="plot6.png",width=600,height=800,res=45)
  
  # using boxplots as number of sources is changing each year
  baltimoreData <- NEI[NEI$fips == "24510",]
  laData <- NEI[NEI$fips == "06037",]
  carSCC <- subset(SCC, grepl("(?i)vehicle", Short.Name))
  
  baltimoreMergedTables <- merge(baltimoreData,carSCC,by="SCC")
  laMergedTables <- merge(laData,carSCC,by="SCC")
  par(mfrow = c(1, 2),mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
  boxplot(baltimoreMergedTables$Emissions ~ baltimoreMergedTables$year, outline=FALSE,  xlab = "Year", ylab="PM2.5 (tons)", main = "Baltimore City")
  boxplot(laMergedTables$Emissions ~ laMergedTables$year, outline=FALSE,  xlab = "Year", ylab="PM2.5 (tons)", main = "LA County")
  mtext("PM2.5 recorded by Vehicle related sources", outer = TRUE)
  
  dev.off()
  
}


