## @knitr dataCleaner

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
