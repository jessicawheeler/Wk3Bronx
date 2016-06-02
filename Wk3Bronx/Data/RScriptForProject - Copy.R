# UNIT 3 and 4 Project in R 
#Dataset: Bronx
#Group Members: Nathan Mowat, Jessica Wheeler, Gilles Salomon, Christopher Woodard

#STEP 1: DOWNLOAD PACKAGES AND LOAD THEM.
require(gdata)
require(plyr)

#STEP 2: GET DATA INTO R FROM DROPBOX
setwd("C:\\Users\\natha_000\\Dropbox\\WeekThreeProject\\Analysis\\Data")
bronx <- read.csv("rollingsales_bronx.csv",skip=4,header=TRUE)

#STEP 3: CHECK DATA
head(bronx)
summary(bronx)
str(bronx)

#STEP 4: CLEAN DATA
bronx$SALE.PRICE.N <- as.numeric(gsub("[^[:digit:]]","", bronx$SALE.PRICE)) #Changes SALE.PRICE to numeric, and cleans it up creating a new variable
count(is.na(bronx$SALE.PRICE.N)) #Counts all the NA's in the dataset under SALE.PRICE.N
names(bronx) <- tolower(names(bronx)) #Changes all column names to lower case
bronx$gross.sqft <- as.numeric(gsub("[^[:digit:]]","", bronx$gross.square.feet)) #Gets rid of leading digits
bronx$land.sqft <- as.numeric(gsub("[^[:digit:]]","", bronx$land.square.feet)) #Gets rid of leading digits
bronx$sale.date <- as.Date(bronx$sale.date) # Changes sale.date to date format in R
bronx$year.built <- as.numeric(as.character(bronx$year.built)) #Changes variable to numeric from factor

#STEP 5: VISUALIZE DATA OF SALES AND GROSS.SQFT
attach(bronx)
hist(sale.price.n) # regular histogram of the data, doesn't look right.
hist(sale.price.n[sale.price.n>0]) #noticed over 15,000 missing data (or NA's) for sales.price.n
hist(gross.sqft[sale.price.n==0]) #WONT RUN AS OF NOW
detach(bronx)

bronx.sale <- bronx[bk$sale.price.n!=0,] #Keeping only the actual sales: DOESNT GET RID OF NA's, NOT ZEROES IN DATA SET, THEY ARE DASHES (-)
plot(bronx.sale$gross.sqft,bronx.sale$sale.price.n) #ScatterPlot of gross.sqft (on x-axis) vs sale.price.n (on y-axis)

#STEP 6: LOOK AT 1-3 FAMILY HOMES
bronx.homes <- bronx.sale[which(grepl("FAMILY",bronx.sale$building.class.category)),] 
dim(bronx.homes) # shows 2589 Rows and 24 Columns
plot(log(bronx.homes$gross.sqft),log(bronx.homes$sale.price.n)) #Plot of Log transform of gross.sqft and sale.price.n
summary(bronx.homes[which(bronx.homes$sale.price.n<100000),]) #Summary of sale.price.n below $100,000


#STEP 7: REMOVE OUTLIERS THAT DON'T SEEM LIKE ACTUAL SALES
bronx.homes$outliers <- (log(bronx.homes$sale.price.n) <=5) + 0 #Removed the log data that was less than 5
bronx.homes <- bronx.homes[which(bronx.homes$outliers==0),] 
plot(log(bronx.homes$gross.sqft),log(bronx.homes$sale.price.n)) #ScatterPlot of Log gross.sqft vs sale.price.n with outliers removed



