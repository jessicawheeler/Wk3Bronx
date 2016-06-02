## @knitr dataAnalyser

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
