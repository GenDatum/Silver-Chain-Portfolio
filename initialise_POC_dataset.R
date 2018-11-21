# Set Directory to read file #
getwd()
setwd("U:/Work/DOH_Reporting_Proof_of_Concept/Real/Data")

## Running this to ensure libraries are installed and run ##
usePackage <- function(x)
  {
    if (!require(x,character.only = TRUE))
    {
      install.packages(x,dep=TRUE)
        if(!require(x,character.only = TRUE)) stop("Package not found")
    }
  }

## Load up necessary libraries ## 
usePackage("ggplot2")
usePackage("plyr")
usePackage("scales")
usePackage("zoo")
usePackage("lubridate")
usePackage("dplyr")
usePackage("googleVis")
usePackage("htmlwidgets")
usePackage("RCurl")

usePackage("tidyverse")

usePackage("RXKCD")
usePackage("tm")
usePackage("wordcloud")
usePackage("RColorBrewer")
usePackage("RODBC")

usePackage("gridExtra")

## Read in Data ## 
hath = read.csv(file="hath.csv",na.strings = "")
dim(hath) ## 4614  18
head(hath)
names(hath)

pa = read.csv(file="pa.csv",na.strings = "")
dim(pa) ## 7793  18
head(pa)
names(pa)

pra = read.csv(file="pra.csv",na.strings = "")
dim(pra) ## 1249  18
head(pra)
names(pra)

cn = read.csv(file="cn.csv",na.strings = "")
dim(cn) ## 4827  18
head(cn)
names(cn)

hath$svc_type = "HATH"
cn$svc_type = "CNU"
pa$svc_type = "PA"
pra$svc_type = "PRA"

## row cn, pa, pra because same column names      ##
## hath has episode start an end date              ##
## others have date of first and last face to face ##

data_ex_hath = rbind(cn, pa, pra)
dim(data_ex_hath) ## 13869  19

hath$context.start = hath$Episode.Start.Date
hath$context.end = hath$Episode.End.Date

data_ex_hath$context.start = data_ex_hath$Date.First.Face2Face
data_ex_hath$context.end = data_ex_hath$Date.Last.Face2Face

hath = hath[,-c(6,7)]
data_ex_hath = data_ex_hath[,-c(6,7)]
names(hath)
names(data_ex_hath)

data = rbind(hath, data_ex_hath)
dim(data) ## 18483  19

rm(data_ex_hath, hath, cn, pa, pra)
ls()

data$count = 1
