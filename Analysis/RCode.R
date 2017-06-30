getwd()
beerdata <- read.csv("Beers.csv" , TRUE, ",")
class(beerdata)
dim(beerdata)
head(beerdata)
breweriesdata <- read.csv("Breweries.csv" , TRUE, ",")
class(breweriesdata)
dim(breweriesdata)
head(breweriesdata)
# Ques. no 1)
# How many breweries are present in each state?
noofbreweries <- aggregate(rep(1, length(breweriesdata$State)), by=list(breweriesdata$State), sum )
noofbreweries
#Ques no 2)
#Merge the beer data and brewery data by brewery id.
m1 <- merge(beerdata, breweriesdata, by.x = "Brewery_id" , by.y="Brew_ID")
# First 6 observations and last 6 observations to check the merged file
head(m1,6)
tail(m1,6)
#QUES NO 3)
# Reporting No of NA's in each column
library(dplyr)
newm1 <- replace(m1,m1=="",NA)
m2 <- apply(newm1,2,function(x){sum(is.na(x))})
m2

# Ques no 4)
#To compute the median alcohol content and international bitterness unit for each state.
sortm1 <- m1[order(m1 $ State),]  # sort the data by state and stored in sortm1
sortm1
install.packages("doBy")
library(doBy)
m3 <- summaryBy(ABV ~ State, data = sortm1, FUN = list(median))
head(m3)
m4<- summaryBy(IBU ~ State, data = sortm1, FUN = list(median))
head(m4)
# merging both data frame,summary_median and summary_median2 by state
mergeddata <- merge(m3,m4, by.x = "State" , by.y = "State")
head(mergeddata)

#Barchart plot between ABV.median and IBU.median
install.packages("ggplot2")
library(ggplot2)
ggplot(data= mergeddata, aes(x= ABV.median, y= IBU.median, fill= ABV.median))+ geom_bar(stat="identity")


# Question no 5)
# State with the maximum alcoholic beer(ABV) and the most bitter beer (IBU)
m1[which.max(m1$ABV),]
m1[which.max(m1$IBU),]



# Question no 6)
# summary statistics for ABV
statistics <- summary(m1$ABV)
statistics




#   Ques no 7)
# scatter plot to find the relationship between the bitterness of the beer and its alcoholic content.
ggplot(sortm1,aes(x = IBU,y = ABV ))+geom_point(na.rm=TRUE)+geom_smooth(method=lm,se=FALSE, na.rm=TRUE)











