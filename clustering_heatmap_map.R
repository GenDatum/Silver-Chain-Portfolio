## Running this to ensure libraries are installed and run ##
usePackage <- function(x)
  {
    if (!require(x,character.only = TRUE))
    {
      install.packages(x,dep=TRUE)
        if(!require(x,character.only = TRUE)) stop("Package not found")
    }
  }

# load packages #
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

# Load Australian State and Territories shapefile data
#aus_ste <- readOGR(dsn = "U:/Work/R/Data/SC_Geographical/ABS/State and Territory", layer = "STE11aAust")
#wa=aus_ste[aus_ste@data$STATE_CODE==5 , ]

# Load SLA shapefile data
aus_ste <- readOGR(dsn = "U:/Work/R/Data/SC_Geographical/ABS/SLA", layer = "SLA11aAust")
wa=aus_ste[aus_ste@data$STATE_CODE==5 , ]

cen = read.csv("U:/Work/R/Data/SC_Geographical/geocoded_WA_SC_FY1718_Service_Centre_Map_Prelim_V1.csv", stringsAsFactors=FALSE, na.strings="NULL")
dim(cen)
names(cen)

del = read.csv("U:/Work/R/Data/SC_Geographical/geocoded_WA_SC_FY1718_Service_Delivery_Map_Prelim_V1_20180917.csv", stringsAsFactors=FALSE, na.strings="NA")
dim(del)
names(del)






