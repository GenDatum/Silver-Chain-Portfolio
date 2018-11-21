#######################################################################################
#### This is only an example to hash out the code to produce a time series heatmap ####
#### This can now be use for number of visits per day filtered by funding etc      ####
#### Example provided here is only for illustation purposes and very crude         ####
####                                                                               ####
#### Wei Ang - 09/08/2018                                                          #### 
####                                                                               ####
####################################################################################### 

## Load up necessary libraries ## 
library(ggplot2)
library(plyr)
library(scales)
library(zoo)
library(lubridate)

## Read in the Data ##
df <- read.csv("U:/Work/R/Data/data_20180807_tender.csv")

## Format the Date ## 
df$date <- as.Date(as.character(df$To_Date), "%d/%m/%Y")  # format date

## Filter to facilitate aggregation ## 
df = df[,c(38, 31)]
#df <- df[as.numeric(df$year_name) >= 2017, ]  # filter reqd years
df.new = aggregate( . ~ date,mean,data=df)

## Create Month Week ##
## Need to be careful here ##
## Different method give different week number in months ##
monthweeks <- function(x) {
    UseMethod("monthweeks")
}
monthweeks.Date <- function(x) {
    ceiling(as.numeric(format(x, "%d")) / 7)
}
monthweeks.POSIXlt <- function(x) {
    ceiling(as.numeric(format(x, "%d")) / 7)
}
monthweeks.character <- function(x) {
    ceiling(as.numeric(format(as.Date(x), "%d")) / 7)
}
table(monthweeks(df.new$date))
df.new$monthweek = (monthweeks(df.new$date))

## Other data manipulation/derivation ##
df.new$week <- as.integer(format(df.new$date,"%V"))
df.new$weekdayf = weekdays(df.new$date)
df.new$year <- format(df.new$date,"%Y")
df.new$yearmonth <- as.yearmon(df.new$date)
df.new$yearmonthf <- factor(df.new$yearmonth)

## A dataset to perform the plot ## 
df.out = df.new[which(df.new$year == 2018),]
df.out$Length_Of_Stay_Days = as.numeric(as.character(df.out$Length_Of_Stay_Days))

#######################################################################################
#### Code Ends Here!                                                               ####
#######################################################################################







