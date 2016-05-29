# US-Crime-Data-Visualization-Analysis
A data analysis project that analyzes the safer states to stay in the US based on various external factors like unemployment, poverty, median income and population density


Data Sources Used:

Source 1: We have selected www.fbi.gov as the source to extract all relevant information regarding crime in the United States. 
Source 2: The second source selected for the additional data is www.bls.gov to extract all relevant information pertaining to unemployment in the United States  
Source 3: The third source selected is census.gov for the collection of data related to poverty rate in the United States classified by state.
Our First data set is the Type of Crimes that took place in the United States classified by State. This data again would be spanning across 2011 to 2014, which would be extracted for each year and then clubbed together.
Our second data set is the number of arrests that took place in the United States classified by State. This data again would be spanning across 2011 to 2014, which would be extracted for each year and then clubbed together.
Our third data set is the number of total law enforcement employees in the United States classified by State. This data is also from 2011 to 2014, which would be extracted for each year and then clubbed together.
Our fourth data set is the State Unemployment data set which covers the rate of unemployment across the United States. This data is also from 2011 to 2014, which would be extracted for each year and then clubbed together.
The above data sets will be mixed and matched to analyze the effect of each factor on Crime.

Business Context:
The aim is to focus on the various crimes reported in the United States and see to analyze the relationship between the crimes and the factors affecting crime which may range from unemployment, population density, economic condition to law enforcement agencies, education etc. The analysis can open up opportunities for the medical, educational, judicial sector of different states to develop and contribute to reduce crime as a whole in the country. The analysis does not focus on development of one particular company or industry and spans across different entities to collaborate to a social cause. The general public, especially those who are planning to move to another state in the United States, could make use of this analysis to have a better idea of crime and law enforcement in that area.
The major question that we are looking to answer is what are the major factors that influence crime in the United States?
Additional questions we can answer are: Which category of crime has the highest number of crimes for all the states in the US?
And what is the distribution of crime categories over the years? What is the distribution of crime rate and unemployment in the US?

It is a very open ended question but we hope to get some insight as to what can be the potential influential factors and hope that our effort can contribute to the noble cause i.e. reducing the number of crimes across the US.
Assessment of Data Quality

•   	Completeness – All the rows and columns contain valid data respective to attributes since the data is from government affiliated websites.
•   	Accuracy/Validity – The attributes require integer values and are present in the same format

•   	Availability – The data is present on the source website https://www.fbi.gov and http://www.bls.gov. 
•   	Consistency - There is no conflicting information about the data set as it is maintained on the government website.
•   	Accessibility – The data can be exported in the excel format from the source website.
•   	Timeliness/Currency/Volatility – We are currently using the data available from 2011- 2014, which gets updated yearly. For our analysis we require yearly data.

Relationship/affinity of data sets:
All of the above mentioned data sets would be joined on the basis of the ‘State’ Attribute.

Description of data set attributes:
•	Type of crimes:  Violent crime, Murder and non-negligent manslaughter, Forcible Rape, Robbery, Aggravated Assault, Property Crime, Burglary, Larceny-theft, Motor vehicle theft.
•	Number of arrests:  State, Total all classes, Violent Crime, Property Crime.
•	Total law enforcement employees:  State, Total Law enforcement employees, number of agencies
•	State Unemployment:  State, Rate
