# Load crime data
crime <- read.csv("http://datasets.flowingdata.com/crimeRatesByState-formatted.csv")

View(crime)


# Box plots for all crime rates
boxplot(crime.new[,-1], horizontal=TRUE, main="Crime Rates in US")

# Multiple histograms
par(mfrow=c(3, 3))
colnames <- dimnames(crime.new)[[2]]
for (i in 2:8) {
  hist(crime[,i], xlim=c(0, 3500), breaks=seq(0, 3500, 100), main=colnames[i], probability=TRUE, col="red", border="white")
}

# Density plot
par(mfrow=c(3, 3))
colnames <- dimnames(crime.new)[[2]]
for (i in 2:8) {
  d <- density(crime[,i])
  plot(d, type="n", main=colnames[i])
  polygon(d, col="red", border="gray")
}


# Histograms and density lines
par(mfrow=c(3, 3))
colnames <- dimnames(crime.new)[[2]]
for (i in 2:8) {
  hist(crime[,i], xlim=c(0, 3500), breaks=seq(0, 3500, 100), main=colnames[i], probability=TRUE, col="gray", border="white")
  d <- density(crime[,i])
  lines(d, col="red")
}


 

####################################################################3
# reading Files

# reading csv file into object crime2014
crime2014 <- read.csv("2014 rate.csv",stringsAsFactors = FALSE)
# reading csv file into object crime2013
crime2013 <- read.csv("2013 rate.csv",stringsAsFactors = FALSE)
# reading csv file into object crime2012
crime2012 <- read.csv("2012 rate.csv",stringsAsFactors = FALSE)
# reading csv file into object crime2011
crime2011 <- read.csv("2011 rate.csv",stringsAsFactors = FALSE)
# reading csv file into object crime2010
crime2010 <- read.csv("2010 rate.csv",stringsAsFactors = FALSE)


View(crime2010)

# Viewing names of attributes within data set
names(crime2014)

# renaming variables
names(crime2014) <- c("State","Violent_crime","Murder","Forcible_Rape","Robbery","Aggravated_assault","Property_crime","Burglary","Larceny_theft","Motorvehicle_theft")

names(crime2013) <- c("State","Violent_crime","Murder","Forcible_Rape","Robbery","Aggravated_assault","Property_crime","Burglary","Larceny_theft","Motorvehicle_theft")

names(crime2012) <- c("State","Violent_crime","Murder","Forcible_Rape","Robbery","Aggravated_assault","Property_crime","Burglary","Larceny_theft","Motorvehicle_theft")

names(crime2011) <- c("State","Violent_crime","Murder","Forcible_Rape","Robbery","Aggravated_assault","Property_crime","Burglary","Larceny_theft","Motorvehicle_theft")

names(crime2010) <- c("State","Violent_crime","Murder","Forcible_Rape","Robbery","Aggravated_assault","Property_crime","Burglary","Larceny_theft","Motorvehicle_theft")

# excluding informatio for Washingtod D.C. and Puerto Rico
#installing sqldf package 
install.packages("sqldf")
#loading the package
library(sqldf)

# using Structured query language to extract columns
crime2014 <- sqldf ( 'SELECT *
                       FROM crime2014
                       WHERE State != "District of Columbia" AND State != "Puerto Rico" ')
crime2014$Year <- '2014'

crime2013 <- sqldf ( 'SELECT *
                       FROM crime2013
                      WHERE State != "District of Columbia" AND State != "Puerto Rico" ')
crime2013$Year <- '2013'

crime2012 <- sqldf ( 'SELECT *
                      FROM crime2012
                      WHERE State != "District of Columbia" AND State != "Puerto Rico" ')
crime2012$Year <- '2012'

crime2011 <- sqldf ( 'SELECT *
                      FROM crime2011
                      WHERE State != "District of Columbia" AND State != "Puerto Rico" ')
crime2011$Year <- '2011'
crime2010 <- sqldf ( 'SELECT *
                      FROM crime2010
                      WHERE State != "District of Columbia" AND State != "Puerto Rico" ')
crime2010$Year <- '2010'

final <- rbind(crime2010,crime2011,crime2012,crime2013,crime2014)

eg <- arrange(final,desc(Property_crime))

#Extractring top 6 rows
top_propertycrime <- eg[1:6,]


eg2<- arrange(final,desc(Violent_crime))
#Extractring top 6 rows
top_violentcrime <- eg2[1:6,]



View(eg)

View(eg2)

View(final)


#to plot violent crimes past 5 years for different states





"

#Analyzing crime in 2014

#Viewing structure of data

str(crime2014)

# arranging records according to Violent crime rate per 100,000 inhabitants

#firstly we convert violent_crime class from character to numeric 
crime2014$Violent_crime <- as.numeric(crime2014$Violent_crime)

# arranging records in Descending order using the order() function
sorted_violentcrime2014 <- arrange(crime2014,desc(Violent_crime))

# arranging records according to Property crime rate per 100,000 inhabitants

# arranging records in Descending order using the order() function
sorted_propertycrime2014 <- arrange(crime2014,desc(Property_crime))


#extracting top 6 rows from data frame to analyze top 6 states with highest violent crime rate
new_violentcrime2014 <- sorted_violentcrime2014[1:6,]
new_violentcrime2014$Year <- '2014'

#extracting top 6 rows from data frame to analyze top 6 states with highest property crime rate
new_propertycrime2014 <- sorted_propertycrime2014[1:6,]
new_propertycrime2014$Year <- '2014'
#######################################2013##################################################
#Analyzing crime in 2013

#Viewing structure of data

str(crime2013)

# arranging records according to Violent crime rate per 100,000 inhabitants

#firstly we convert violent_crime class from character to numeric 
crime2013$Violent_crime <- as.numeric(crime2013$Violent_crime)

# arranging records in Descending order using the order() function
sorted_violentcrime2013 <- arrange(crime2013,desc(Violent_crime))


# arranging records according to Property crime rate per 100,000 inhabitants

# arranging records in Descending order using the order() function
sorted_propertycrime2013 <- arrange(crime2013,desc(Property_crime))


#extracting top 6 rows from data frame to analyze top 6 states with highest violent crime rate
new_violentcrime2013 <- sorted_violentcrime2013[1:6,]
new_violentcrime2013$Year <- '2013'

#extracting top 6 rows from data frame to analyze top 6 states with highest property crime rate
new_propertycrime2013 <- sorted_propertycrime2013[1:6,]
new_propertycrime2013$Year <- '2013'

########################################2012##################################################
#Analyzing crime in 2012

#Viewing structure of data

str(crime2012)

# arranging records according to Violent crime rate per 100,000 inhabitants

#firstly we convert violent_crime class from character to numeric 
crime2012$Violent_crime <- as.numeric(crime2012$Violent_crime)

# arranging records in Descending order using the order() function
sorted_violentcrime2012 <- arrange(crime2012,desc(Violent_crime))


# arranging records according to Property crime rate per 100,000 inhabitants

# arranging records in Descending order using the order() function
sorted_propertycrime2012 <- arrange(crime2012,desc(Property_crime))


#extracting top 6 rows from data frame to analyze top 6 states with highest violent crime rate
new_violentcrime2012 <- sorted_violentcrime2012[1:6,]
new_violentcrime2012$Year <- '2012'

#extracting top 6 rows from data frame to analyze top 6 states with highest property crime rate
new_propertycrime2012 <- sorted_propertycrime2012[1:6,]
new_propertycrime2012$Year <- '2012'

############################################2011#################################################
#Analyzing crime in 2011

#Viewing structure of data

str(crime2011)

# arranging records according to Violent crime rate per 100,000 inhabitants

#firstly we convert violent_crime class from character to numeric 
crime2011$Violent_crime <- as.numeric(crime2011$Violent_crime)

# arranging records in Descending order using the order() function
sorted_violentcrime2011 <- arrange(crime2011,desc(Violent_crime))


# arranging records according to Property crime rate per 100,000 inhabitants

# arranging records in Descending order using the order() function
sorted_propertycrime2011 <- arrange(crime2011,desc(Property_crime))


#extracting top 6 rows from data frame to analyze top 6 states with highest violent crime rate
new_violentcrime2011 <- sorted_violentcrime2011[1:6,]
new_violentcrime2011$Year <- '2011'

#extracting top 6 rows from data frame to analyze top 6 states with highest property crime rate
new_propertycrime2011 <- sorted_propertycrime2011[1:6,]
new_propertycrime2011$Year <- '2011'

#####################################2010#########################################33

#Analyzing crime in 2010

#Viewing structure of data

str(crime2010)

# arranging records according to Violent crime rate per 100,000 inhabitants

#firstly we convert violent_crime class from character to numeric 
crime2010$Violent_crime <- as.numeric(crime2010$Violent_crime)

# arranging records in Descending order using the order() function
sorted_violentcrime2010 <- arrange(crime2010,desc(Violent_crime))

# arranging records according to Property crime rate per 100,000 inhabitants

# arranging records in Descending order using the order() function
sorted_propertycrime2010 <- arrange(crime2010,desc(Property_crime))

#extracting top 6 rows from data frame to analyze top 6 states with highest violent crime rate
new_violentcrime2010 <- sorted_violentcrime2010[1:6,]
new_violentcrime2010$Year <- '2010'
View(new_violentcrime2010)

#extracting top 6 rows from data frame to analyze top 6 states with highest property crime rate
new_propertycrime2010 <- sorted_propertycrime2010[1:6,]
new_propertycrime2010$Year <- '2010'


#merging data from past 4 years to make a detiled list of top 6 states with highest crime rate 
Violent_crimerate <- rbind(new_violentcrime2010,new_violentcrime2011,new_violentcrime2012,new_violentcrime2013,new_violentcrime2014)
sorted_final <- arrange(Violent_crimerate,desc(Violent_crime))
View(sorted_final2)

Property_crimerate <- rbind(new_propertycrime2010,new_propertycrime2011,new_propertycrime2012,new_propertycrime2013,new_propertycrime2014)
sorted_final2 <- arrange(Property_crimerate,desc(Property_crime))


View(Violent_crimerate)
View(Property_crimerate)

str(new_propertycrime2013)

join <- merge(x = new_violentcrime2014, y = new_violentcrime2013, by = "State", all = TRUE)
View(join)
"




