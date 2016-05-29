
Crime<-read.csv("CrimeRatebyState.csv",stringsAsFactors = F,sep =",", header = TRUE)

View(Crime)
# Removing Unwanted Columns

# Removing Unwanted Rows
Crime<-Crime[-1,]

Crime<-Crime[-(869:894),]
# Creating a column for State
Crime["State"]<-NA


#changing column names
names(Crime)<- c("Year","Population","Violent_crime","Murder","Forcible_Rape","Robbery","Aggravated_assault","Property_crime","Burglary","Larceny_theft","Motorvehicle_theft","State")

#removing text from column year
Crime<-Crime[!(Crime$Year=='Year'),]
#removing blank spaces 
Crime<-Crime[!(Crime$Year==''),]
#removing additional text from Yearm column
Crime$Year <-gsub("Estimated crime in","", Crime$Year)

#assigning value 1 to variable a

a<-1
#Assigning State to records
repeat{
  state<-Crime$Year[a]
  Crime$State[(a+1):(a+13)]=state
  Crime<-Crime[-(a),]
  a<-a+13
  if(a>nrow(Crime))
  {
    break
  }
}


#changing order of columns 
Crime<-Crime[c("State", "Year","Population","Violent_crime","Murder","Forcible_Rape","Robbery","Aggravated_assault","Property_crime","Burglary","Larceny_theft","Motorvehicle_theft")]

#to view structure of Dataset
str(Crime)
#convert year to numeric
Crime$Year<-as.numeric(Crime$Year)
#removing population column
Crime$Population <- NULL
#convert Violent crime rate to numeric
Crime$Violent_crime<-as.numeric(Crime$Violent_crime)
#arranging according to descending order of year
Crime<-Crime[order(-Crime$Year),]
# To remove white spaces before and after
Crime$State <-gsub("^\\s+|\\s+$", "", Crime$State)

View(Crime)

#reading values from csv file
crime2014 <- read.csv("2014 rate.csv",stringsAsFactors = FALSE)
# reading csv file into object crime2013
crime2013 <- read.csv("2013 rate.csv",stringsAsFactors = FALSE)

#entering 2014 and 2013 as values into year columns of data set
crime2014$Year <- '2014'
crime2013$Year <- '2013'

#changing names of data set
names(crime2014) <- c("State","Violent_crime","Murder","Forcible_Rape","Robbery","Aggravated_assault","Property_crime","Burglary","Larceny_theft","Motorvehicle_theft","Year")
#changing the order of columns in data set
crime2014 <- crime2014[c("State","Year","Violent_crime","Murder","Forcible_Rape","Robbery","Aggravated_assault","Property_crime","Burglary","Larceny_theft","Motorvehicle_theft")]

#chanign names of dataset
names(crime2013) <- c("State","Violent_crime","Murder","Forcible_Rape","Robbery","Aggravated_assault","Property_crime","Burglary","Larceny_theft","Motorvehicle_theft","Year")
#changing order of columns
crime2013 <- crime2013[c("State","Year","Violent_crime","Murder","Forcible_Rape","Robbery","Aggravated_assault","Property_crime","Burglary","Larceny_theft","Motorvehicle_theft")]

View(crime2014)

#appending 2 data sets to Crime
Crime <- rbind(Crime,crime2013,crime2014)
#converting numeric as required
Crime$Year<-as.numeric(Crime$Year)
#arranging according to descending order of year
Crime<-Crime[order(-Crime$Year),]

#using sqldf to perform certain data extraction
library(sqldf)
#removing data of District of columbia and Puerto Rico and Hawaii
Crime <- sqldf ( 'SELECT *
                       FROM Crime
                     WHERE State != "District of Columbia" AND State != "Puerto Rico" AND State!= "Hawaii" ')

View(Crime)

#using dplyr to use the gsub function to get rid of ',' and replace by space
library(dplyr)

Crime$Property_crime <-gsub(",", "", Crime$Property_crime)
Crime$Burglary <-gsub(",", "", Crime$Burglary)
Crime$Larceny_theft <-gsub(",", "", Crime$Larceny_theft)

#converting numeric as required
Crime$Violent_crime <-as.numeric(Crime$Violent_crime)
Crime$Murder<-as.numeric(Crime$Murder)
Crime$Forcible_Rape<-as.numeric(Crime$Forcible_Rape)
Crime$Robbery<-as.numeric(Crime$Robbery)
Crime$Aggravated_assault<-as.numeric(Crime$Aggravated_assault)
Crime$Property_crime<-as.numeric(Crime$Property_crime)
Crime$Burglary<-as.numeric(Crime$Burglary)
Crime$Larceny_theft<-as.numeric(Crime$Larceny_theft)
Crime$Motorvehicle_theft<-as.numeric(Crime$Motorvehicle_theft)
View(top_Property)


#using readxl to read xlsx files
library(readxl)
Unemployment <- read_excel("unemployment.xlsx")

View(Unemployment)

#removing data of District of columbia and Puerto Rico and Hawaii
Unemployment <- sqldf ( 'SELECT *
                       FROM Unemployment
                 WHERE State != "District of Columbia" and State!= "Hawaii" ')

#arranging in descending order of Year
Unemployment<-Unemployment[order(-Unemployment$Year),]
#removing Yaer column
Unemployment$Year <- NULL
#adding unemployment rate from unemployment data set to Crime data set
Crime$Unemploymentrate <- Unemployment$`Unemployment Rate`

#reading poverty data 
poverty <- read_excel("poverty.xlsx")
View(poverty)
#changing names
names(poverty) <-c ("State","Year","Poverty")
#removing data of District of columbia  and Hawaii
poverty<- sqldf ( 'SELECT *
                       FROM poverty
                 WHERE State != "District of Columbia" AND State != "Hawaii" ')
#avoiding excess data
poverty<-poverty[-(736:746),]
#adding poverty from poverty data set to Crime data set
Crime$Poverty <- poverty$Poverty

#extracting violent crime data to calculate percentage change
PercentageCrime <- Crime %>%
                select(State, Year, Violent_crime)
#extracting Property crime data to calculate percentage change
PercentageProperty <- Crime %>%
                select(State,Year,Property_crime)

View(PercentageCrime)
# installing reshape to change layout of data set
install.packages("reshape2")
library(reshape2)
#spreading the violent crime data set according to year
ReshapeData<- reshape(PercentageCrime, idvar="State", timevar="Year", direction="wide")
#spreading the property crime data set according to year
ReshapeProperty<- reshape(PercentageProperty, idvar="State", timevar="Year", direction="wide")

View(ReshapeData)

#calculating percentage change between 2000 and 2014 for violent crime 
ReshapeData$PercentageChange2014 <- (ReshapeData$Violent_crime.2014 - ReshapeData$Violent_crime.2000)*100/ ReshapeData$Violent_crime.2000

ReshapeData$PercentageChange2013 <- (ReshapeData$Violent_crime.2013 - ReshapeData$Violent_crime.2000)*100/ ReshapeData$Violent_crime.2000

ReshapeData$PercentageChange2012 <- (ReshapeData$Violent_crime.2012 - ReshapeData$Violent_crime.2000)*100/ ReshapeData$Violent_crime.2000

ReshapeData$PercentageChange2011 <- (ReshapeData$Violent_crime.2012 - ReshapeData$Violent_crime.2000)*100/ ReshapeData$Violent_crime.2000

ReshapeData$PercentageChange2010 <- (ReshapeData$Violent_crime.2010 - ReshapeData$Violent_crime.2000)*100/ ReshapeData$Violent_crime.2000

ReshapeData$PercentageChange2009 <- (ReshapeData$Violent_crime.2009 - ReshapeData$Violent_crime.2000)*100/ ReshapeData$Violent_crime.2000

ReshapeData$PercentageChange2008 <- (ReshapeData$Violent_crime.2008 - ReshapeData$Violent_crime.2000)*100/ ReshapeData$Violent_crime.2000

ReshapeData$PercentageChange2007 <- (ReshapeData$Violent_crime.2007 - ReshapeData$Violent_crime.2000)*100/ ReshapeData$Violent_crime.2000

ReshapeData$PercentageChange2006 <- (ReshapeData$Violent_crime.2006 - ReshapeData$Violent_crime.2000)*100/ ReshapeData$Violent_crime.2000

ReshapeData$PercentageChange2005 <- (ReshapeData$Violent_crime.2005 - ReshapeData$Violent_crime.2000)*100/ ReshapeData$Violent_crime.2000

ReshapeData$PercentageChange2004 <- (ReshapeData$Violent_crime.2004 - ReshapeData$Violent_crime.2000)*100/ ReshapeData$Violent_crime.2000

ReshapeData$PercentageChange2003 <- (ReshapeData$Violent_crime.2003 - ReshapeData$Violent_crime.2000)*100/ ReshapeData$Violent_crime.2000

ReshapeData$PercentageChange2002 <- (ReshapeData$Violent_crime.2002 - ReshapeData$Violent_crime.2000)*100/ ReshapeData$Violent_crime.2000

ReshapeData$PercentageChange2001 <- (ReshapeData$Violent_crime.2001 - ReshapeData$Violent_crime.2000)*100/ ReshapeData$Violent_crime.2000

ReshapeProperty$PercentagePChange2014 <- (ReshapeData$Property_crime.2014 - ReshapeData$Property_crime.2000)*100/ ReshapeData$Property_crime.2000

#calculating percentage change between 2000 and 2014 for Property crime 
  ReshapeProperty$PercentagePchange<-( ReshapeProperty$Property_crime.2014 - ReshapeProperty$Property_crime.2000)*100/ReshapeProperty$Property_crime.2000

View(ReshapeProperty)

install.packages("ggplot2") 
install.packages("plyr")
#loading ggplot2 package
library(ggplot2)
library(plyr)
library(scales)

df<- ReshapeData


dtf <- data.frame(x = df$State,y = df$PercentageChange2014) 
ggplot(dtf, aes(x, y)) +
  geom_bar(stat = "identity", aes(fill = "red")) + coord_flip() + theme_bw() +
  theme(
    plot.background = element_blank()
    ,panel.grid.major = element_blank()
    ,panel.grid.minor = element_blank()
    ,panel.border = element_blank()
  ) +
  theme(axis.line = element_line(color = 'black'))+
  theme(legend.position = "none") 
  
ReshapeProperty$PercentagePchange


df2<- ReshapeProperty

dtf2 <- data.frame(x = df2$State,y = df2$PercentagePchange) 
ggplot(dtf2, aes(x, y)) +
  geom_bar(stat = "identity", aes(fill = "green")) + coord_flip() + theme_bw() +
  theme(
    plot.background = element_blank()
    ,panel.grid.major = element_blank()
    ,panel.grid.minor = element_blank()
    ,panel.border = element_blank()
  ) +
  theme(axis.line = element_line(color = 'black'))+
  theme(legend.position = "none")



View(ReshapeData) 
comparison <- ReshapeData %>%
          filter(PercentageChange2014>0 | State == 'New York') %>%
          select(State,Violent_crime.2014,Violent_crime.2013,Violent_crime.2012,Violent_crime.2011,Violent_crime.2010,Violent_crime.2009,Violent_crime.2008,Violent_crime.2007,Violent_crime.2006,Violent_crime.2005,Violent_crime.2004,Violent_crime.2003,Violent_crime.2002,Violent_crime.2001,Violent_crime.2000) 
          
View(comparison)  

names(comparison) <- c("State","2014","2013","2012","2011","2010","2009","2008","2007","2006","2005","2004","2003","2002","2001","2000")  



install.packages("tidyr") 
library(tidyr) 

e <- comparison%>% gather(., key, value, -State) %>% 
  mutate(year = as.numeric(substr(as.character(key), 1, 4))) %>%
  select(-key) 
 
View(e) 

ggplot(data=e,aes(x=year,y=value,color=State)) +
  geom_line()+
  theme(
    plot.background = element_blank()
    ,panel.grid.major = element_blank()
    ,panel.grid.minor = element_blank()
    ,panel.border = element_blank()
  ) + 
  theme(axis.line = element_line(color = 'black')) 





#MAp

View(Crime)    

Mapdata <- reshape(PercentageCrime, idvar="State", timevar="Year", direction="wide")  

names(Mapdata) <- c("region","2014","2013","2012","2011","2010","2009","2008","2007","2006","2005","2004","2003","2002","2001","2000")  

View(Mapdata)  

Map <- sqldf ( 'SELECT State,avg(Violent_crime)
                       FROM Crime  
                        group by State')  

names(Map) <- c("region","Violent_crime")
View(Map)  
install.packages("maps") 
library(maps)


us <-map_data("state")
data(stateMapEnv)
View(stateMapEnv)
View(Map)


install.packages("mapproj")
library(mapproj)

gg <- ggplot()
gg <- gg + geom_map(data=us, map=us,
                    aes(x=long, y=lat, map_id=region),
                    fill="#ffffff", color="#ffffff", size=0.15) 

gg <- gg + geom_map(data=Map, map=us,
                    aes(fill= Violent_crime, map_id=region),
                    color="#ffffff", size=0.15)   
gg <- gg + scale_fill_continuous(low='thistle2', high='darkred', 
                                 guide='colorbar')  


gg <- gg + labs(x=NULL, y=NULL) 
gg <- gg + coord_map("albers", lat0 = 39, lat1 = 45) 
gg <- gg + theme(panel.border = element_blank())
gg <- gg + theme(panel.background = element_blank()) 
gg <- gg + theme(axis.ticks = element_blank()) 
gg <- gg + theme(axis.text = element_blank())+geom_text(data=cnames, aes(long, lat, label = region), size=3) +
  coord_map()

#==============================================================property map========

PMap <- sqldf ( 'SELECT State,avg(Property_crime)
               FROM Crime  
               group by State') 
View(PMap)
PMap$State <- tolower(PMap$State)
names(PMap) <-c("region","Property_crime")


bb <- ggplot()
bb <- bb + geom_map(data=us, map=us,
                    aes(x=long, y=lat, map_id=region),
                    fill="#ffffff", color="#ffffff", size=0.15) 

bb <- bb + geom_map(data=PMap, map=us,
                    aes(fill= Property_crime, map_id=region),
                    color="#ffffff", size=0.15)   
bb <- bb + scale_fill_continuous(low='skyblue', high='skyblue4', 
                                 guide='colorbar')


bb <- bb + labs(x=NULL, y=NULL) 
bb <- bb + coord_map("albers", lat0 = 39, lat1 = 45) 
bb <- bb + theme(panel.border = element_blank())
bb <- bb + theme(panel.background = element_blank()) 
bb <- bb + theme(axis.ticks = element_blank()) 
bb <- bb + theme(axis.text = element_blank())+geom_text(data=cnames, aes(long, lat, label = region), size=3) +
  coord_map()

bb



View(Crime)
names(Crime)
mapViolentcrime <- Crime %>%
  filter(State =="Tennessee" | State == "South Carolina" | State == "Delaware" |State =="Nevada" | State == "Louisiana") 

TennesseeData<- Crime %>%
  filter(State =="Tennessee")%>%
  select(State, Year,Murder,Forcible_Rape,Robbery,Aggravated_assault)
  
SouthcarolinaData<- Crime %>%
  filter(State =="South Carolina")%>%
  select(State, Year,Murder,Forcible_Rape,Robbery,Aggravated_assault)

NewMexicoData<- Crime %>%
  filter(State =="New Mexico")%>%
  select(State, Year,Murder,Forcible_Rape,Robbery,Aggravated_assault)

NevadaData<- Crime %>%
  filter(State =="Nevada")%>%
  select(State, Year,Murder,Forcible_Rape,Robbery,Aggravated_assault)

install.packages("reshape")
library(reshape)




Tdata <- melt(TennesseeData, id=c("State","Year"))
TennesseeViolentCrime <- ggplot(data=Tdata, aes(x=Year, y=value, fill=variable)) +
  geom_bar(stat="identity", position=position_dodge())


SCdata <- melt(SouthcarolinaData, id=c("State","Year")) 
SouthcarolinaDataViolentCrime <- ggplot(data=SCdata, aes(x=Year, y=value, fill=variable)) +
  geom_bar(stat="identity", position=position_dodge()) 


NMdata <- melt(NewMexicoData, id=c("State","Year"))
NewMexicoDataViolentCrime <- ggplot(data=NMdata, aes(x=Year, y=value, fill=variable)) +
  geom_bar(stat="identity", position=position_dodge())



NVdata <- melt(NevadaData, id=c("State","Year"))
NevadaDataViolentCrime <- ggplot(data=NVdata, aes(x=Year, y=value, fill=variable)) +
  geom_bar(stat="identity", position=position_dodge())


#=======================================================================
# in order to check the top 4 states with highest Property crime
PMap<-PMap[order(-PMap$Property_crime),] 


ArizonaData<- Crime %>%
  filter(State =="Arizona")%>%
  select(State, Year,Burglary,Larceny_theft,Motorvehicle_theft)


WashingtonData<- Crime %>%
  filter(State =="Washington")%>%
  select(State, Year,Burglary,Larceny_theft,Motorvehicle_theft)


SouthcarolinaPData<- Crime %>%
  filter(State =="South Carolina")%>%
  select(State, Year,Burglary,Larceny_theft,Motorvehicle_theft)

LouisianaData <- Crime %>%
  filter(State =="Louisiana")%>%
  select(State, Year,Burglary,Larceny_theft,Motorvehicle_theft)


#Plots

Adata <- melt(ArizonaData, id=c("State","Year"))
ArizonaPropertyCrime <- ggplot(data=Adata, aes(x=Year, y=value, fill=variable)) +
  geom_bar(stat="identity", position=position_dodge())


Wdata <- melt(WashingtonData, id=c("State","Year"))
WashingtonPropertyCrime <- ggplot(data=Wdata, aes(x=Year, y=value, fill=variable)) +
  geom_bar(stat="identity", position=position_dodge())


SData <- melt(SouthcarolinaPData, id=c("State","Year"))
SouthcarolinaPropertyCrime <- ggplot(data=SData, aes(x=Year, y=value, fill=variable)) +
  geom_bar(stat="identity", position=position_dodge())


LData <- melt(LouisianaData, id=c("State","Year"))
LouisianaPropertyCrime <- ggplot(data=LData, aes(x=Year, y=value, fill=variable)) +
  geom_bar(stat="identity", position=position_dodge())









"
# Load crime data
crime <- read.csv("http://datasets.flowingdata.com/crimeRatesByState-formatted.csv")
par(mar = rep(2, 4))
# Remove Washington, D.C. and national average
crime.new <- crime[crime$state != "District of Columbia",]
crime.new <- crime.new[crime.new$state != "United States ",]

# Box plot
boxplot(crime.new$robbery, horizontal=TRUE, main="Robbery Rates in US")
boxplot(crime.new[,-1], horizontal=TRUE, main="Crime Rates in US")

# Histogram
hist(crime.new$robbery)
hist(crime.new$robbery, breaks=10)

par(mfrow=c(3, 3))
colnames <- dimnames(crime.new)[[2]]
for (i in 2:8) {
  hist(crime[,i], xlim=c(0, 3500), breaks=seq(0, 3500, 100), main=colnames[i], probability=TRUE, col="gray", border="white")
  d <- density(crime[,i])
  #lines(d, col="red")
}


# Density plot
par(mfrow=c(3, 3))
colnames <- dimnames(crime.new)[[2]]
for (i in 2:8) {
  d <- density(crime[,i])
  plot(d, type="n", main=colnames[i])
  polygon(d, col="red", border="gray")
}


"



"
top_Property<- arrange(Crime,desc(Property_crime))
top_Violent<- arrange(Crime,desc(Violent_crime))

yo <- summarise(group_by(top_Property, Year,State, Property_crime) )
yo2 <- summarise(group_by(top_Violent, Year,State, Property_crime) )

View(yo)
View(yo2)



repeat{
  test <- vector(mode = 'complex', length = 0) 
  test<-crimeold[1,]
  crimeold<-crimeold[-1,]
  PropertyCrimestates<-rbind(PropertyCrimestates,test)
  count<-length(unique(PropertyCrimestates$State))
  if(count > 9)
  {
    break
  }
}

crimeold<- top_Property
PropertyCrimestates <- vector(mode = 'complex', length = 0) 
repeat{
  test <- vector(mode = 'complex', length = 0) 
  test<-crimeold[1,]
  crimeold<-crimeold[-1,]
  PropertyCrimestates<-rbind(PropertyCrimestates,test)
 count<-length(unique(PropertyCrimestates$State))
  if(count > 9)
  {
    break
  }
}

View(PropertyCrimestates)

blah <- PropertyCrimestates %>%
  select(State,Year, Property_crime)
 
yo <- summarise(group_by(blah, Year,State, Property_crime) )
          
View(yo)

violentcrimeold<-top_Violent
ViolentCrimestates <- vector(mode = 'complex', length = 0) 
repeat{
  test2 <- vector(mode = 'complex', length = 0) 
  test2<-violentcrimeold[1,]
  violentcrimeold<-violentcrimeold[-1,]
  ViolentCrimestates<-rbind(ViolentCrimestates,test2)
  count<-length(unique(ViolentCrimestates$State))
  if(count > 9)
  {
    break
  }
}


View(ViolentCrimestates)

table(PropertyCrimestates$State)
table(ViolentCrimestates$State)
"




