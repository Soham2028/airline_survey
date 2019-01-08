library(dplyr)
library(stringr)
library (readxl)
library(ggplot2)
library(ggmap)

#reads in the JSON file, sets factors for all strings and strips the white space in the csv.
survey <- read.csv("airplaneSurvey.csv",stringsAsFactors = TRUE, strip.white = TRUE, sep = ',', na.strings = TRUE)

#renames all the columns in the survey data 
colnames(survey) <-(c("satisfaction", "airlineStatus", "age", "gender", "priceSensitivity", "firstYearFlight", "numberOfFlights", "percentOfOtherFlight", "travelType", "loyaltyCardsNum",
                      "shoppingAtAirport", "foodAtAirport", "class", "day", "date", "airlineCode", "airlineName", "originCity", "originState", "destCity", "destState", "scheduledDepHr", 
                      "scheduledDepDelay", "arriveDelay(min)", "flightCancelled", "flightTime(min)", "flightDistance", "arriveDelay>5"))

#verifies that the names were correctly placed
View(head(survey))

#understand the data better, run sapply() and tapply()

understand <- sapply(survey, summary)
understand

understand2 <- tapply(survey$satisfaction, survey$airlineStatus, table)
View(understand2)

hist(understand2$`Business travel`)

understand3 <- table(survey$satisfaction, survey$airlineStatus)
understand3

plot(understand3)


#validates the values are between 1 - 5, however there are several values which are not whole numbers. Recommendation is to round the .5 values up. Will see later what 3 index values are not. 
summary(survey$satisfaction) 
str(survey$satisfaction)



#shows that satisfaction column is a "factor."  This needs to be converted, however factors are useful in graphing strings or characters. For the satisifaction and other numerical 
#columns, use the following set of code to transform them into numeric. 
class(survey$satisfaction ) # returns "factors"


#sets the list of the levels to return, the values of s is character
s <- levels(survey$satisfaction)[survey$satisfaction]
#turns values into numberic, but introduces several NA's.
survey$satisfaction <- as.numeric(s)

summary(survey$satisfaction) # shows there are three NA's, what is the location? 

nrows <- which(is.na(survey$satisfaction))#[1] 38898 38899 38900 are the index locations of the values, respectively 4.00.2.00, 4.00.5.

#Recommend taking the values 4.00.2.00, 4.00.5. and turn int 4, 2, 4. 
survey$satisfaction[nrows] <- c(4,2,4)

#check to see if there are any more NAs...
which(is.na(survey$satisfaction)) # 0

tabulate(survey$satisfaction)

NROW(survey$satisfaction)

######### stopped here ########

#outputs the file to a .csv
write.csv(survey, file = "airplaneSurvey.csv")

#use the below if need to round the numbers 
#survey$satisfaction<-round(survey$satisfaction)

survey$satisfaction[!survey$satisfaction%%1]

#used to search for a specific value 
which(grepl(2.5, survey$satisfaction))
which(survey$satisfaction == 3.5, arr.ind=TRUE)




unique(unlist (lapply (survey, function(survey) which (is.na (survey))))) #that is a LOT of NA's. 

apply(survey,1,max,na.rm=TRUE)

###############started again##################
########################
# Do not need this yet... #####
satVstat <- survey[,1:2]
head(satVstat)
########################

summary(survey$airlineStatus)
str(survey$airlineStatus)

#are there any NA in the airlineStatus column
which(is.na(survey$airlineStatus)) #0

#perform lm on on airlineStatus vs satisfcation
airplaneSurvey <- lm(formula = satisfaction ~ airlineStatus, data = survey)
summary(airplaneSurvey)
#Multiple R-squared:  0.1184,	Adjusted R-squared:  0.1184 


#try to increase R^2 score by adding other variables
airplaneSurveyPlus <- lm(formula = satisfaction ~ airlineStatus + age + travelType + `arriveDelay(min)` + numberOfFlights, data = survey)
summary(airplaneSurveyPlus)

#Multiple R-squared:  0.4406,	Adjusted R-squared:  0.4386 

#this data shows that airline status is a match for satisfaction with an adjusted R-Squared of ~12%

#will add a few more to see if the R value goes up.  

#this data shows that airline status is a match for satisfaction with an adjusted R-Squared of ~44%



#Linear model test Sat ~ Age
test10 <- lm(formula = satisfaction ~ age, data = survey)
summary(test10)

plot(airplaneSurvey)


summary(survey$originCity)
class(survey$originCity)


survey$originCity <- str_trim(survey$originCity, "both") #will convert factors into strings upon completion of the command

oCity <- survey$originCity
View(head(oCity))
class(oCity)

oCity <- gsub("West Palm Beach/Palm Beach","Palm Beach",oCity)
oCity <- gsub("Allentown/Bethlehem/Easton","Easton",oCity)
oCity <- gsub("Bristol/Johnson City/Kingsport","Kingsport",oCity)
oCity <- gsub("Beaumont/Port Arthur","Beaumont",oCity)
oCity <- gsub("Bend/Redmond","Redmond",oCity)
oCity <- gsub("Bismarck/Mandan","Bismarck",oCity)
oCity <- gsub("Bloomington/Normal","Bloomington",oCity)
oCity <- gsub("Cedar Rapids/Iowa City","Cedar Rapids",oCity)
oCity <- gsub("Champaign/Urbana","Urbana",oCity)
oCity <- gsub("Charleston/Dunbar","Dunbar",oCity)
oCity <- gsub("College Station/Bryan","College Station",oCity)
oCity <- gsub("Dallas/Fort Worth","Dallas",oCity)
oCity <- gsub("Elmira/Corning","Corning",oCity)
oCity <- gsub("Greensboro/High Point","Greensboro",oCity)
oCity <- gsub("Harlingen/San Benito","Harlingen",oCity)
oCity <- gsub("Hancock/Houghton","Hancock",oCity)
oCity <- gsub("Iron Mountain/Kingsfd","Iron Mountain",oCity)
oCity <- gsub("Jackson/Vicksburg","Jackson",oCity)
oCity <- gsub("Gulfport/Biloxi","Biloxi",oCity)
oCity <- gsub("Jacksonville/Camp Lejeune","Jacksonville",oCity)
oCity <- gsub("Lawton/Fort Sill","Lawton",oCity)
oCity <- gsub("Manhattan/Ft. Riley","Manhattan",oCity)
oCity <- gsub("Midland/Odessa","Odessa",oCity)
oCity <- gsub("Mission/McAllen/Edinburg","Edinburg",oCity)
oCity <- gsub("Montrose/Delta","Delta",oCity)
oCity <- gsub("New Bern/Morehead/Beaufort","Beaufort",oCity)
oCity <- gsub("Newport News/Williamsburg","Williamsburg",oCity)
oCity <- gsub("Newburgh/Poughkeepsie","Poughkeepsie",oCity)
oCity <- gsub("North Bend/Coos Bay","North Bend",oCity)
oCity <- gsub("Pasco/Kennewick/Richland","Richland",oCity)
oCity <- gsub("Saginaw/Bay City/Midland","Midland",oCity)
oCity <- gsub("Sarasota/Bradenton","Sarasota",oCity)
oCity <- gsub("Scranton/Wilkes-Barre","Scranton",oCity)
oCity <- gsub("Sun Valley/Hailey/Ketchum","Ketchum",oCity)




View(oCityFix2)


sort(unique(oCity))

summary(survey$originCity)

str(survey$originCity)



str(survey$Orgin.City)
summary(survey$Origin.State)

summary(survey$Destination.City)
str()
summary(survey$Destination.State)





survey <- survey[,-35:-50]
colnames(survey) <-(c("satisfaction", "airlineStatus", "dummyAirlineStatus", "age", "gender", "dummyGender", "priceSensitivity",
                      "firstYearFlight", "numberOfFlights", "%ofOtherFlight", "travelType", "dummyTravelType", "#loyaltyCards",
                      "shoppingAtAirport", "foodAtAirport", "class", "dummyClass", "day", "date", "airlineCode", "airlineName", 
                      "originCity", "originState", "destCity", "destState", "scheduledDepHr", "scheduledDepDelay", "arriveDelay(min)", 
                      "flightCancelled", "dummyFlightCanceled", "flightTime(min)", "flightDistance", "arriveDelay>5", "dummydelay"))



str(survey)

############### perform lm on the entire dataset ###############
View(survey)
survey <- as.data.frame(survey)
str(survey)

survey$airlineStatus <- str_trim(survey$airlineStatus, "both")
str(survey$airlineStatus)

airplaneSurvey <- lm(formula = satisfaction ~ airlineStatus, data = survey)
summary(airplaneSurvey)


airplaneSurvey24 <- lm(formula = satisfaction ~ airlineStatus + age, data = survey)
summary(airplaneSurvey24)


#Residuals:
#  Min       1Q   Median       3Q      Max 
#-2.64406 -0.94243  0.05757  0.84186  1.84186 

#Coefficients:
#                     Estimate Std. Error t value Pr(>|t|)    
#airlineStatusBlue     3.158143   0.003037  1039.7   <2e-16 ***
#airlineStatusGold     3.743794   0.008700   430.3   <2e-16 ***
#airlineStatusPlatinum 3.644056   0.014022   259.9   <2e-16 ***
#airlineStatusSilver   3.942434   0.005620   701.5   <2e-16 ***
 
#Multiple R-squared:  0.9336,	Adjusted R-squared:  0.9336 




ggplot(survey, aes(x=airlineStatus, y=satisfaction)) + geom_point()

ggplot(survey, aes(x=age, y=satisfaction)) + geom_point()


airplaneSurvey1 <- lm(formula = satisfaction ~ class -1, data = survey)
summary(airplaneSurvey1)

plot(airplaneSurvey1)


airplaneSurvey2 <- lm(formula = satisfaction ~ airlineStatus + age + gender + priceSensitivity + firstYearFlight + numberOfFlights + travelType + shoppingAtAirport + foodAtAirport + class + day + airlineCode + airlineName + originCity + originState + destCity + destState + scheduledDepHr + scheduledDepDelay + flightCancelled + flightDistance, data = survey) 

summary(airplaneSurvey2)


which(colnames(survey)=="satisfaction" )
which(colnames(survey)=="airlineStatus")

satisfaction <- unlist(survey$satisfaction)
max(satisfaction)
min(satisfaction)
summary(satisfaction)
str(satisfaction)
#avg(satisfaction)
length(satisfaction)



status <- unlist(survey$airlineStatus)
View(status)
length(status)

which()

#"Detractors, promoters, passive" "--->" "NPS score is "  "how to increase overall net promotor score" 
#what makes customers happy or not



df.satVSstatus <- data.frame(satisfaction, status)
#changes Blue, Gold, Platnium, and Silver to their factor levels
levels(df.satVSstatus$status) <- 1:4

#changes the status factors into numbers and overwrites the $status column
df.satVSstatus$status <- as.numeric(df.satVSstatus$status)

#filters out all the values of status == 1 (Blue)
sat_vs_statusBlue <- filter(df.satVSstatus, status == 1)
count(sat_vs_statusBlue)
hist(sat_vs_statusBlue$satisfaction)

# plots survey vs status Blue (1)
g <- ggplot(sat_vs_statusBlue, aes(x=sat_vs_statusBlue$status, y=sat_vs_statusBlue$satisfaction)) + geom_point(aes(size = 1)) 
g <- g + ggtitle("Status vs Satisfaction") + theme(axis.text.x = element_text(angle = 90, hjust = 1))
g #

blue <- ggplot(sat_vs_statusBlue, aes(x=sat_vs_statusBlue$satisfaction)) + geom_histogram(binwidth = 0.5, fill = "blue")
blue <- blue + ggtitle("Histogram of Blue Patrons Satisfaction")
blue  #plots a histogram of urban population from mergeddf

#filters out all the status values == 2 (Gold)
sat_vs_statusGold <- filter(df.satVSstatus, status == 2)

gold <- ggplot(sat_vs_statusGold, aes(x=sat_vs_statusGold$satisfaction)) + geom_histogram(binwidth = 0.5, fill = "gold")
gold <- gold + ggtitle("Histogram of gold Patrons Satisfaction")
gold  #plots a histogram of urban population from mergeddf

#filters out all the status values == 3 (Platinum)
sat_vs_statusPlatinum <- filter(df.satVSstatus, status == 3)

platinum <- ggplot(sat_vs_statusPlatinum, aes(x=sat_vs_statusPlatinum$satisfaction)) + geom_bar(fill = "darkgrey")
platinum <- platinum + ggtitle("Histogram of Platinum Patrons Satisfaction")
platinum 

#filters out all the status values == 4 (Silver)
sat_vs_statusSilver <- filter(df.satVSstatus, status == 4)

silver <- ggplot(sat_vs_statusSilver, aes(x=sat_vs_statusSilver$satisfaction)) + geom_bar(fill = "lightgrey")
silver <- silver + ggtitle("Histogram of Silver Patrons Satisfaction")
silver

#combine hist plots into one graph - look at point where I can combine all the 3 histograms 
install.packages("plotly")
library(plotly)

barplot(sat_vs_statusBlue, sat_vs_statusSilver)

test <- ggplot

########################
total <- rbind(sat_vs_statusBlue, sat_vs_statusSilver, sat_vs_statusGold, sat_vs_statusPlatinum)
ggplot(total, aes(total$satisfaction, fill = total$status)) + geom_density(alpha = 0.2)
###########################

################################
ggplot(df.statusVSstatus, aes(x=xx)) + 
  geom_histogram(data=subset(,yy == 'a'),fill = "red", alpha = 0.2) +
  geom_histogram(data=subset(dat,yy == 'b'),fill = "blue", alpha = 0.2) +
  geom_histogram(data=subset(dat,yy == 'c'),fill = "green", alpha = 0.2)

ggplotly()

dat <- data.frame(xx = c(runif(100,20,50),runif(100,40,80),runif(100,0,30)),yy = rep(letters[1:3],each = 100))

ggplot(dat,aes(x=xx)) +
  geom_histogram(data=subset(dat,yy == 'a'),fill = "red", alpha = 0.2) +
  geom_histogram(data=subset(dat,yy == 'b'),fill = "blue", alpha = 0.2) +
  geom_histogram(data=subset(dat,yy == 'c'),fill = "green", alpha = 0.2)

ggplotly()
####################################################

#plot just shows 
ggplot(df.satVSstatus, aes(x=df.satVSstatus$satisfaction, color=df.satVSstatus$status,fill=df.satVSstatus$status)) + geom_bar(position="dodge")
status_combo <- blue + silver + gold + platinum

summary(df.satVSstatus)

#satisfaction       status     
#Min.   :1.000   Min.   :1.000  
#1st Qu.:3.000   1st Qu.:1.000  
#Median :4.000   Median :1.000  
#Mean   :3.379   Mean   :1.747  
#3rd Qu.:4.000   3rd Qu.:2.000  
#Max.   :5.000   Max.   :4.000



#loads ggplot2
library(ggplot2)

# plots survey vs status Blue (1)
g <- ggplot(sat_vs_statusBlue, aes(x=sat_vs_statusBlue$status, y=sat_vs_statusBlue$satisfaction)) + geom_point(aes(size = 1)) 
g <- g + ggtitle("Status vs Satisfaction") + theme(axis.text.x = element_text(angle = 90, hjust = 1))
g #







max(survey$`Arrival Delay in Minutes`, na.rm=TRUE)



df.ag <- group_by(f.airline1, AgeGroup)
> summarise(df.ag, count = n(), avg_sat = mean(Satisfaction,na.rm = TRUE), mean(No.of.Flights.p.a.,na.rm = TRUE))


class(survey$Satisfaction)
class(survey$`Airline Status`)


survey$`Airline Status` <- str_trim(survey$`Airline Status`, "both")


sat_vs_status <- select(survey$Satisfaction & survey$`Airline Status`)


sat_vs_status <-  select(survey$`Dummy Airline status (Blue = 1, Silver = 2, Gold = 3, Plat = 4)`)


which.max(satisfaction)

statusBlue <- unlist(survey$`Airline Status`== "Blue")

plot(statusBlue)  







library(ggplot2)
g <- ggplot(survey, aes(x=survey$`Airline Status`, y=survey$Satisfaction)) + geom_point(aes(size = survey$`Arrival Delay in Minutes`)) 
g <- g + ggtitle("Status vs Satisfaction") + theme(axis.text.x = element_text(angle = 90, hjust = 1))
g #


max(survey$`Departure Delay in Minutes`, na.rm=TRUE)


1592/60


###################### test plots ################################V
View(satVstat)
blueSat <- filter(satVstat, satVstat$airlineStatus=='Blue')
silverSat <- filter(satVstat, satVstat$airlineStatus=='Silver')
goldSat <- filter(satVstat, satVstat$airlineStatus=='Gold')
platinumSat <- filter(satVstat, satVstat$airlineStatus=='Platinum')


class(blueSat$airlineStatus)

View(platinumSat)

gstatus <- ggplot(blueSat) + aes(x=blueSat$satisfaction)
gstatus <- gstatus + geom_histogram(bins = 5)
gstatus

plot(blueSat)


gAge <- ggplot(survey) + aes(x=survey$age, y=survey$satisfaction) + geom_point()
gAge

gAge <- gAge + facet_wrap(~survey$gender)
gAge <- gAge + geom_smooth(method = 'lm')

gAge



#######################Graphing Locations #########################
MakeGeoURL <- function(address) 
{
root <- "http://www.datasciencetoolkit.org/maps/apl/geocode/" 
url <- paste(root, "json?address=", address, sep="")
return(URLencode(url)) 
}

#addr2latlng function
addr2latlng <- function(address)
{
  url <- MakeGeoURL(address)  #sets up URL string
  apiResult <- getURL(url)    #sends URL to internet
  geoStruct <- fromJSON(apiResult, simply=FALSE)
  lat <- NA
  lng <- NA
  try(lat <- geoStruct$results[[1]]$geometry$location$lat)
  try(lng <- geoStruct$results[[1]]$geometry$location$lng)
  return(c(lat,lng))
}


testcity <- MakeGeoURL("1600 Pennsylvania Avenue, Washington, DC")
testcity <- addr2latlng("1600 Pennsylvania Avenue, Washington, DC")


survey$originState <- tolower(survey$originState)
survey$originCity <- tolower(survey$originCity)
#step 1, get map data
us <- map_data("state")



maptest <- ggplot(survey, aes(map_id = state))
maptest <- maptest + geom_map(map = us, aes())

originmap <- c(survey$originCity, survey$originState)
View(originmap)
View(head(survey))
summary(originmap)
latlon <- geocode(source="dsk", strsplit(originmap))
latlon

str(originmap)
############### need to convert cities to lat / long)

oCityTest <- as.data.frame(unlist(oCity))


oCitylat <- geocode(oCity, source = "dsk")
oCitylat <- oCity
summary(oCityTest)
str(oCityTest)
View(head(oCityTest))

class(oCityTest)
factor(oCityTest)

colnames(oCityTest) <-(c("cityState"))
colnames(oCitylat)[colnames(oCitylat)==""] <- "cityState"

oCityTest$newCityState <- as.character(oCityTest$cityState)


#s <- factor(oCityTest)[oCityTest$cityState]
#View(s)

#turns values into numberic, but introduces several NA's.
#survey$satisfaction <- as.numeric(s)


#Error: google restricts requests to 2500 requests a day for non-business use.#####

# Loop through the addresses to get the latitude and longitude of each address and add it to the
# origAddress data frame in new columns lat and lon
for(i in 1:nrow(oCityTest))
{
  # Print("Working...")
  result <- geocode(oCityTest$newCityState[i], output = "latlona", source = "dsk")
  oCityTest$lon[i] <- as.numeric(result[1])
  oCityTest$lat[i] <- as.numeric(result[2])
  oCityTest$geoAddress[i] <- as.character(result[3])
}
# Write a CSV file containing origAddress to the working directory
write.csv(origAddress, "geocoded.csv", row.names=FALSE)

View(head(oCityTest))

# Need to clean the other city columns
head(survey$destCity)
str(survey$destCity)
summary(survey$destCity)






