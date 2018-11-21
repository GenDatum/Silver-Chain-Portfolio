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

usePackage("rgdal")
usePackage("spdplyr")
usePackage("geojsonio")
usePackage("rmapshaper")
usePackage("sp")
usePackage("mapview")
usePackage("htmlwidgets")
usePackage("installr")
usePackage("leaflet")
usePackage("devtools")

## Read in Data ## 
sa = read.csv(file="U:/Work/R/Data/SA_Inpatient_Data_20181029.csv",na.strings = "")
dim(sa) ## 4614  18
head(sa)
names(sa)

# Load SLA shapefile data
aus_ste <- readOGR(dsn = "U:/Work/R/Data/SC_Geographical/ABS/POA", layer = "POA_2016_AUST")

saa=aus_ste[as.numeric(as.character(aus_ste@data$POA_CODE16)) >= 5000 , ]
saa=saa[as.numeric(as.character(saa@data$POA_CODE16)) < 6000 , ]

ag = aggregate(number_of_Separation~ AA_Postcode2, data=sa, sum)
ag = ag[which(ag$AA_Postcode2 >= 5000),]

## Merging spatial dataset from a normal dataset ##
final = merge(saa, ag, by.x= "POA_CODE16", by.y="AA_Postcode2", all.x=TRUE)
dim(final)
final

final[which(is.na(as.character(final$number_of_Separation))),4] = 0

## Setting up colors ## 
bins <- c(1, 100, 200, 500, 1000, 2000, 3000, 4000, Inf)
pal <- colorBin("YlOrRd", domain = states$density, bins = bins)














