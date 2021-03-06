# BronxHousingData
Chris Woodard, Nathan Mowat, Saloman Gilles, Jessica Wheeler  
June 1, 2016  

<br>

>We used the [Rolling Housing Sales for NYC](http://www1.nyc.gov/home/search/index.page?search-terms=Rolling+sales+update) website and looked at the Bronx dataset for analysis.

* The first steps towards analysis are loading the datafile and then cleaning the datafile.  Once the data is cleaned, we were able to analyze some data on housing trends in the Bronx.

###Getting Started - Loading the datafile:


```r
#this file contains coed for reading in the data to analyse
#---------------------------------------------------------------------------------------
# this file contains code for for reading in the data file for analysis               --
#---------------------------------------------------------------------------------------
### ------------------------------------------------------------------------------------
### NOTE : must be loaded first                                                       --
### ------------------------------------------------------------------------------------

# load required libraries
library(plyr)
library(gtools)
library(gdata)

# set appropriate dirctory so we can locate data file
workingDirectory <- getwd()

#set file location directory
workingDataDirectory <- c("C:/RHSProject/Data/rollingsales_bronx.xls")

### ------------------------------------------------------------------------------
### NOTE : this read assumes a .xls file
###        - it assumes perl has been installed on computer if using windows pc  -
### If it fails - check to see if error includes a perl install requirement   ----
###-------------------------------------------------------------------------------
bx <- read.xls(workingDataDirectory, sheet = 1, pattern = "BOROUGH")
```


###Cleaning the Bronx datafile:

```r
#---------------------------------------------------------------------------------------
# this file contains code for cleaning the data to analyse                            --
#---------------------------------------------------------------------------------------
### ------------------------------------------------------------------------------------
### NOTE : must load after LoadDataFile.R before it works after necessary libraries   --
### ------------------------------------------------------------------------------------

# convert column names to lower case for ease of processing
names(bx) <- tolower(names(bx))
# ensure numeric - remove currency indicator
bx$sale.price.n <- as.numeric(gsub("[^[:digit:]]","", bx$sale.price)) 
# get rid of leading digits
bx$gross.sqft <- as.numeric(gsub("[^[:digit:]]","", bx$gross.square.feet)) 
# get rid of leading digits
bx$land.sqft <- as.numeric(gsub("[^[:digit:]]","", bx$land.square.feet)) 
# changes sale.date to date format in R
bx$sale.date <- as.Date(bx$sale.date) 
# changes variable to numeric from factor
bx$year.built <- as.numeric(as.character(bx$year.built))  
# dataset with cleaned sale price
bx$cleansale  <- bx[is.numeric(bx$sale.price.n),]   

# sales remove - and 0s
bx.sale <- bx[bx$sale.price.n!=0,] 
#homes
bx.homes <- bx.sale[which(grepl("FAMILY",bx.sale$building.class.category)),]  
```

###Bronx Data Analysis:

```r
#---------------------------------------------------------------------------------------
#    this file contains analysis, includes histograms, plots, summary                 -- 
#---------------------------------------------------------------------------------------
### ------------------------------------------------------------------------------------
### NOTE : must load after cleanDataFile.R before it works after necessary libraries  --
### ------------------------------------------------------------------------------------

# histogram of raw data don't say a lot but sort of right skewed
#attach(bx)
hist(bx$sale.price.n) 
hist(bx$sale.price.n[bx$sale.price.n>0]) 
hist(bx$gross.sqft[bx$sale.price.n==0]) 

# cleaned data don't say a thing eitherbut sort of right skewed
hist(bx$cleansale$sale.price.n)
hist(bx$cleansale$sale.price.n[bx$cleansale$sale.price.n>0]) 
hist(bx$cleansale$gross.sqft[bx$cleansale$sale.price.n==0])

# plotted cleaned sales gross.sqfoot/price show some suspected outliers
plot(bx$cleansale$gross.sqft, bx$cleansale$sale.price.n)
#detach(bx)

# plot of Log-transforms of gross.sqft and sale.price.n looks good
plot(log(bx.homes$gross.sqft),log(bx.homes$sale.price.n)) 
# Summary of sale.price.n below $100,000
summary(bx.homes[which(bx.homes$sale.price.n<100000),]) 

# outliers
#Removed the log data that was less than 5
bx.homes$outliers <- (log(bx.homes$sale.price.n) <= 5) + 0 
bx.homes <- bx.homes[which(bx.homes$outliers == 0),] 
#ScatterPlot of Log gross.sqft vs sale.price.n with outliers removed
plot(log(bx.homes$gross.sqft),log(bx.homes$sale.price.n)) 
```


