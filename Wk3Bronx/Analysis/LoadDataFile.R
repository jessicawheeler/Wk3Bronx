## @knitr dataLoader

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
workingDataDirectory <- c("/Users/JessicaSibal/Dropbox/Wk3Bronx/Data/rollingsales_bronx.xls")

### ------------------------------------------------------------------------------
### NOTE : this read assumes a .xls file
###        - it assumes perl has been installed on computer if using windows pc  -
### If it fails - check to see if error includes a perl install requirement   ----
###-------------------------------------------------------------------------------
bx <- read.xls(workingDataDirectory, sheet = 1, pattern = "BOROUGH")
